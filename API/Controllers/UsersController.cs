using API.Constants;
using API.DTOs.Request;
using API.DTOs.Response;
using API.Services;
using BusinessObject.Models;
using DataAccess.UserRepository;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/users")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserService userService;
        private readonly IUserRepository userRepository;

        public UsersController(UserService userService, IUserRepository userRepository)
        {
            this.userService = userService;
            this.userRepository = userRepository;
        }
        [HttpGet]
        public IEnumerable<User> Get() => userRepository.GetAll()
            .Where(user => user.RoleId != RoleConstant.MANAGER)
            .Select(d =>
            {
                d.Password = "******";
                return d;
            });
        [HttpPost]
        public async Task<IActionResult> Post([FromForm] CreateAccountRequest request)
        {
            ResponseMessage response = new ResponseMessage();
            if (request != null)
            {
                try
                {
                    var user = await userService.CreateUser(request);
                    response.Message = "Register successfully";
                    response.Data = user;
                    return new JsonResult(response) { StatusCode = 200 };
                }
                catch (Exception ex)
                {
                    if (ex.InnerException.Message.Contains("UNIQUE"))
                    {
                        response.Message = "The email is existed";
                        return new JsonResult(response) { StatusCode = 400 };
                    }
                    response.Message = ex.Message;
                    return new JsonResult(response) { StatusCode = 400 };
                }
            }
            response.Message = "Empty request";
            return new JsonResult(response) { StatusCode = 400 };
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(string id, [FromForm] UpdateUserRequest request)
        {
            ResponseMessage response = new ResponseMessage();
            if (request != null)
            {
                try
                {
                    await userService.UpdateUser(id, request);
                    response.Message = "Update successfully";
                    return new JsonResult(response) { StatusCode = 200 };
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                    return new JsonResult(response) { StatusCode = 400 };
                }
            }
            response.Message = "Empty request";
            return new JsonResult(response) { StatusCode = 400 };
        }
    }
}
