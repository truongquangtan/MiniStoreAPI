using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public interface ICrudBaseRepository<T, KeyType>
    {
        IEnumerable<T> GetAll();
        T? GetById(KeyType id);
        T? Save(T entity);
        void DeleteById(KeyType id);
        void Update(T entity);
    }
}
