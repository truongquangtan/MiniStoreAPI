using API.Constants;
using BusinessObject.Models;
using DataAccess.RoleRepository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/roles")]
    [ApiController]
    public class RolesController : ControllerBase
    {
        private readonly IRoleRepository roleRepository;
        
        public RolesController(IRoleRepository roleRepository)
        {
            this.roleRepository = roleRepository;
        }

        [HttpGet]
        public IEnumerable<Role> Get() => roleRepository.GetAll().Where(r => r.Id != RoleConstant.MANAGER);
    }
}
