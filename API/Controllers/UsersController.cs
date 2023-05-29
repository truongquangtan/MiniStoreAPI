using API.DTOs.Request;
using API.DTOs.Response;
using API.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/users")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserService userService;

        public UsersController(UserService userService)
        {
            this.userService = userService;
        }

        [HttpPost]
        public async Task<IActionResult> Post(CreateAccountRequest request)
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
                    response.Message = ex.Message;
                    return new JsonResult(response) { StatusCode = 400 };
                }
            }
            response.Message = "Empty request";
            return new JsonResult(response) { StatusCode = 400 };
        }
    }
}
