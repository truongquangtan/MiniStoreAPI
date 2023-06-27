using API.DTOs.Request;
using API.DTOs.Response;
using API.Services;
using API.Supporters.JwtAuthSupport;
using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/auth")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly UserService userService;

        public AuthenticationController(UserService userService)
        {
            this.userService = userService;
        }

        [HttpPost("login")]
        public IActionResult Login(LoginRequest request)
        {
            ResponseMessage response;
            var (token, user) = userService.Login(request.Email, request.Password);
            if (token == null)
            {
                response = new ResponseMessage() { Message = "Incorrect email or password" };
                return new JsonResult(response) { StatusCode = StatusCodes.Status400BadRequest };
            }
            response = new ResponseMessage() {
                Message = "Login successfully",
                Data = new
                {
                    Token=token,
                    Role=user!.RoleId,
                    user!.Avatar,
                    user.Fullname,
                }
            };
            return new JsonResult(response) { StatusCode = StatusCodes.Status200OK };
        }
        [HttpPut("logout")]
        [Authorize]
        public IActionResult Logout()
        {
            ResponseMessage response;
            var user = (User?) HttpContext.Items["User"];
            if (user != null)
            {
                userService.Logout(user);
                response = new ResponseMessage() { Message = "Logout successfully" };
                return new JsonResult(response) { StatusCode = 200 };
            }
            response = new ResponseMessage() { Message = "Cannot logout, user not existed" };
            return new JsonResult(response) { StatusCode = 400 };
        }
    }
}
