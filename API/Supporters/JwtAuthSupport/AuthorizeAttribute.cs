using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace API.Supporters.JwtAuthSupport
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class AuthorizeAttribute : Attribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var user = (User?)context.HttpContext.Items["User"];
            if (user == null)
            {
                context.Result = new JsonResult(new { Message = "Unauthorized" }) { StatusCode = StatusCodes.Status401Unauthorized };
            }
            else if(user!.IsLogout != null && user.IsLogout == true)
            {
                context.Result = new JsonResult(new { Message = "The user is logged out" }) { StatusCode = StatusCodes.Status401Unauthorized };
            }
            else if(user!.IsActive == false || user!.IsDeleted == true)
            {
                context.Result = new JsonResult(new { Message = "The user is not active" }) { StatusCode = StatusCodes.Status401Unauthorized };
            } else if(user!.IsConfirmed == false)
            {
                context.Result = new JsonResult(new { Message = "The account of user is not be confirmed" }) { StatusCode = StatusCodes.Status401Unauthorized };
            }    
        }
    }
}
