using BusinessObject.Models;

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
