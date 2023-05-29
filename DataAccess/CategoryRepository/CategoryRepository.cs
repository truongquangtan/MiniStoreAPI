using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.CategoryRepository
{
    public class CategoryRepository : ICategoryRepository, IDisposable
    {
        private readonly MiniStoreContext context;
        public CategoryRepository(MiniStoreContext context)
        {
            this.context = context;
        }
        public void Dispose() => context?.Dispose();
        public IEnumerable<Category> GetAll() => context.Categories.ToList();
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
                context.Categories.Remove(category);
            }
        }
    }
}
