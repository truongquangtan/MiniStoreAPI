using BusinessObject.Models;

namespace DataAccess.OrderRepository
{
    public interface IOrderRepository : ICrudBaseRepository<Order, string>
    {
        Task<Order?> SaveOrderWithTransaction(Order order);
        Task UpdateOrderWithTransaction(Order order);
        Task DeleteOrderWithTransaction(string id);
    }
}
