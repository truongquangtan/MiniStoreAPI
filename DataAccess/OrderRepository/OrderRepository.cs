using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.OrderRepository
{
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

        public Order? Save(Order entity)
        {
            var order = context.Orders.Add(entity);
            context.SaveChanges();
            return order.Entity;
        }

        public void Update(Order entity)
        {
            context.Orders.Update(entity);
            context.SaveChanges();
        }
    }
}
