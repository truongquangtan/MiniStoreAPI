using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.CategoryRepository
{
    public interface ICategoryRepository
    {
        IEnumerable<Category> GetAll();
        Category? Save(Category category);
        void Delete(int id);
    }
}
