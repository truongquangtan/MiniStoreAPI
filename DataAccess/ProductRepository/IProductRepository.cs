using BusinessObject.Models;

namespace DataAccess.ProductRepository
{
    public interface IProductRepository : ICrudBaseRepository<Product, int>
    {

    }
}
