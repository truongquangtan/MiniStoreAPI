using API.DTOs.Request;
using API.Services;
using API.Supporters.JwtAuthSupport;
using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata.Ecma335;

namespace API.Controllers
{
    [Route("api/attendance-check")]
    [ApiController]
    [Authorize]
    public class AttendanceCheckController : ControllerBase
    {
        private readonly WorksheetService worksheetService;

        public AttendanceCheckController(WorksheetService worksheetService)
        {
            this.worksheetService = worksheetService;
        }

        [HttpGet]
        public ActionResult GetWorksheetToCheck()
        {
            var user = HttpContext.Items["User"] as BusinessObject.Models.User;
            return Ok(worksheetService.GetTimesheetCheckDataBySpecifiedTime(user!.Id, DateTime.Now));
        }

        [HttpGet("checked")]
        public ActionResult GetChecked([FromQuery] int? monthBefore)
        {
            var user = HttpContext.Items["User"] as BusinessObject.Models.User;
            return Ok(worksheetService.GetAllTimesheetCheckDataBeforeSomeMonth(user!.Id, monthBefore ?? 1));
        }

        [HttpPost]
        public ActionResult Check(CheckAttendanceRequest request)
        {
            try
            {
                var user = HttpContext.Items["User"] as BusinessObject.Models.User;
                worksheetService.CheckAttendance(request.RegistrationId, user!.Id);
                return Ok();
            } catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
