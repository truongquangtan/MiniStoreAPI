using BusinessObject.Models;

namespace DataAccess.ProductRepository
{
    public interface IProductRepository : ICrudBaseRepository<Product, int>
    {
        void AddImageToProduct(int productId, string imageUrl);
        void DeleteAllImagesOfProduct(int productId);
    }
}
