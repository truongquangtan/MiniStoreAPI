using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.UserRepository
{
    public interface IUserRepository : ICrudBaseRepository<User, string>
    {
        User? GetByEmailAndPassword(string email, string password);
    }
}
