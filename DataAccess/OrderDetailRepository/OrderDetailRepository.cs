using BusinessObject.Models;

namespace DataAccess.OrderDetailRepository
{
    public class OrderDetailRepository : IOrderDetailRepository, IDisposable
    {
        private readonly MiniStoreContext context = new();

        public void Dispose() => context?.Dispose();

        public void DeleteById(string id)
        {
            var orderDetail = context.OrderDetails.FirstOrDefault(x => x.Id == id);
            context.OrderDetails.Remove(orderDetail);
            context.SaveChanges();
        }

        public IEnumerable<OrderDetail> GetAll()
        {
            return context.OrderDetails.ToList();
        }

        public OrderDetail? GetById(string id)
        {
            return context.OrderDetails.FirstOrDefault(o => o.OrderId == id);
        }

        public OrderDetail? Save(OrderDetail entity)
        {
            var order = context.OrderDetails.Add(entity);
            context.SaveChanges();
            return order.Entity;
        }

        public void Update(OrderDetail entity)
        {
            context.OrderDetails.Update(entity);
            context.SaveChanges();
        }
    }
}
