using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.OrderRepository
{
    public class OrderProcessException : Exception
    {
        public int ProductId { get; set; } = -1;

        public OrderProcessException() { }
        public OrderProcessException(int productId, string message) : base(message)
        {
            ProductId = productId;
        }
        public OrderProcessException(string message) : base(message) { }
        public OrderProcessException(string message, Exception inner) : base(message, inner) { }
        protected OrderProcessException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }
    }
    public class OrderRepository : IOrderRepository, IDisposable
    {
        private readonly MiniStoreContext context = new ();

        public void Dispose() => context?.Dispose();

        public void DeleteById(string id)
        {
            var order = context.Orders.Where(o => o.Id == id).Include(o => o.OrderDetails).FirstOrDefault() ?? throw new Exception("Order not existed");
            context.OrderDetails.RemoveRange(order.OrderDetails);
            context.Orders.Remove(order);
            context.SaveChanges();
        }

        public IEnumerable<Order> GetAll()
        {
            return context.Orders.Include(o => o.OrderDetails).ThenInclude(o => o.Product).ToList();
        }

        public Order? GetById(string id)
        {
            return context.Orders.Where(o => o.Id == id).Include(o => o.OrderDetails).ThenInclude(o => o.Product).FirstOrDefault();
        }

        public Order? Save(Order order)
        {
            var entitySaved = context.Add(order);
            context.SaveChanges();
            return entitySaved.Entity;
        }

        public async Task<Order?> SaveOrderWithTransaction(Order order)
        {
            using var transaction = await context.Database.BeginTransactionAsync();

            try
            {
                foreach (var orderDetail in order.OrderDetails)
                {
                    var product = context.Products.Where(p => p.Id == orderDetail.ProductId).FirstOrDefault();
                    if (product == null)
                    {
                        throw new OrderProcessException(orderDetail.ProductId, $"The product with id {orderDetail.ProductId} not found");
                    }

                    product.Quantity -= orderDetail.Quantity;
                    if (product.Quantity < 0)
                    {
                        throw new OrderProcessException(orderDetail.ProductId, $"The quantity of product with id {orderDetail.ProductId} is not enough");
                    }

                    context.Update(product);
                }

                var entity = context.Orders.Add(order);
                context.SaveChanges();
                transaction.Commit();
                return entity.Entity;
            }
            catch (OrderProcessException ex)
            {
                transaction.Rollback();
                throw ex;
            }
        }

        public async Task UpdateOrderWithTransaction(Order order)
        {
            // Get old order information
            var oldOrder = context.Orders.Where(o => o.Id == order.Id).Include(o => o.OrderDetails).FirstOrDefault()
                ?? throw new OrderProcessException("Order not found");
            var oldOrderDetails = oldOrder.OrderDetails;

            // Begin transaction
            using var transaction = await context.Database.BeginTransactionAsync();
            try
            {
                // Update the quantity of existed order detail
                // And add new order detail if needed
                foreach (var orderDetail in order.OrderDetails)
                {
                    var oldOrderDetail = oldOrderDetails.Where(o => o.Id == orderDetail.Id).FirstOrDefault();

                    // Update order detail information: quantity and price if it already existed
                    if (oldOrderDetail != null)
                    {
                        int delta = orderDetail.Quantity - oldOrderDetail.Quantity;
                        var product = context.Products.Where(p => p.Id == oldOrderDetail.ProductId).FirstOrDefault() ?? throw new OrderProcessException("Product not found");
                        oldOrderDetail.Quantity = orderDetail.Quantity;
                        oldOrderDetail.Price = orderDetail.Price;
                        product.Quantity -= delta;

                        context.OrderDetails.Update(oldOrderDetail);
                        context.Products.Update(product);
                    }
                    else
                    // Else add new the order detail information
                    {
                        var product = context.Products.Where(p => p.Id == orderDetail.ProductId).FirstOrDefault()
                            ?? throw new OrderProcessException(orderDetail.ProductId, $"The product with id {orderDetail.ProductId} not found");

                        product.Quantity -= orderDetail.Quantity;
                        if (product.Quantity < 0)
                        {
                            throw new OrderProcessException(orderDetail.ProductId, $"The quantity of product {product.Name} is not enough");
                        }

                        context.Update(product);
                        context.OrderDetails.Add(orderDetail);
                    }
                }

                // In case of the order update not contain old order details, delete it
                var deletedOrderDetail = oldOrderDetails.Except(order.OrderDetails).ToList();
                deletedOrderDetail.ForEach(orderDetail => DeleteOrderDetail(orderDetail, context));

                // Save the database and commit as a transaction
                context.SaveChanges();
                transaction.Commit();
            }
            catch (Exception)
            {
                // If there was any error in process, roll back the transaction to ensure the integrity
                transaction.Rollback();
                throw;
            }
        }
        private static void DeleteOrderDetail(OrderDetail orderDetail, MiniStoreContext context)
        {
            var product = context.Products.Where(p => p.Id == orderDetail.ProductId).FirstOrDefault()
                            ?? throw new OrderProcessException(orderDetail.ProductId, $"The product with id {orderDetail.ProductId} not found");

            product.Quantity += orderDetail.Quantity;

            context.Update(product);
            context.OrderDetails.Remove(orderDetail);
        }

        public async Task DeleteOrderWithTransaction(string id)
        {
            using var transaction = await context.Database.BeginTransactionAsync();

            try
            {
                var orderEntity = context.Orders.Where(o => o.Id == id).Include(o => o.OrderDetails).ThenInclude(o => o.Product).FirstOrDefault()
                    ?? throw new OrderProcessException("The order not found.");

                orderEntity.OrderDetails.ToList().ForEach(orderDetail => DeleteOrderDetail(orderDetail, context));
                context.Orders.Remove(orderEntity);

                context.SaveChanges();
                transaction.Commit();
            }
            catch (OrderProcessException ex)
            {
                transaction.Rollback();
                throw ex;
            }
        }

        public void Update(Order entity)
        {
            context.Orders.Update(entity);
            context.SaveChanges();
        }
    }
}
