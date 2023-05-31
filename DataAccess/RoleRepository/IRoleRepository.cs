using BusinessObject.Models;

namespace DataAccess.RoleRepository
{
    public interface IRoleRepository
    {
        IEnumerable<Role> GetAll();
    }
}
