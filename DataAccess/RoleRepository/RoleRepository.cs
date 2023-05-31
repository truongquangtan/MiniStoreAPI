using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.RoleRepository
{
    public class RoleRepository : IRoleRepository, IDisposable
    {
        private readonly MiniStoreContext context = new MiniStoreContext();

        public void Dispose()
        {
            context?.Dispose();
        }

        public IEnumerable<Role> GetAll()
        {
            return context.Roles.ToList();
        }
    }
}
