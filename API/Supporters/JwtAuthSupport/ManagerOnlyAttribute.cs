using API.Constants;
using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace API.Supporters.JwtAuthSupport
{
    public class ManagerOnlyAttribute : Attribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var user = (User?) context.HttpContext.Items["User"];
            if(user == null || user.RoleId != RoleConstant.MANAGER)
            {
                context.Result = new JsonResult(new { Message = "Only customer can access!" }) { StatusCode = StatusCodes.Status403Forbidden };
            }
        }
    }
}
