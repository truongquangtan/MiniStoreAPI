using BusinessObject.Models;

namespace DataAccess.OrderRepository
{
    public interface IOrderRepository : ICrudBaseRepository<Order, string>
    {

    }
}
