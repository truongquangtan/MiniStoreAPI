using BusinessObject.Models;

namespace DataAccess.CategoryRepository
{
    public class CategoryRepository : ICategoryRepository, IDisposable
    {
        private readonly MiniStoreContext context = new();
        public void Dispose() => context?.Dispose();
        public IEnumerable<Category> GetAll() => context.Categories.Where(c => c.IsDeleted == false).ToList();
        public Category? Save(Category category)
        {
            var categoryAdded = context.Categories.Add(category);
            context.SaveChanges();
            return categoryAdded.Entity;
        }
        public void Delete(int id)
        {
            var category = context.Categories.FirstOrDefault(c => c.Id == id);
            if(category != null)
            {
                category.IsDeleted = true;
                context.SaveChanges();
            }
        }
    }
}
