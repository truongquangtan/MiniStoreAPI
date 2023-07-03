using API.DTOs.Request;
using API.Services;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/attendance-check")]
    [ApiController]
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
