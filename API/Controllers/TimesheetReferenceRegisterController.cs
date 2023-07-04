using API.DTOs.Request;
using API.Services;
using API.Supporters.JwtAuthSupport;
using BusinessObject.Models;
using DataAccess.TimeSheetRegistrationRefRepository;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/timesheet/register-reference")]
    [ApiController]
    [Authorize]
    public class TimesheetRegisterReferenceController : ControllerBase
    {
        private readonly ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository;
        private readonly WorksheetService worksheetService;

        public TimesheetRegisterReferenceController(
            ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository,
            WorksheetService worksheetService
         )
        {
            this.timesheetRegistrationRefRepository = timesheetRegistrationRefRepository;
            this.worksheetService = worksheetService;
        }

        // GET api/timesheet/register-reference?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet]
        public IActionResult Get([FromQuery] DateTime? startDate, [FromQuery] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now.Date : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            var user = HttpContext.Items["User"] as User;
            return Ok(worksheetService.GetRequestedTimesheets(user!.Id, start, end));
        }

        // POST api/timesheet/register
        [HttpPost]
        public IActionResult Post([FromBody] IEnumerable<TimesheetRegisterRequest> requests)
        {
            var user = HttpContext.Items["User"] as User;

            var entities = requests.Select(request => new TimeSheetRegistrationReference()
            {
                Date = request.Date,
                TimeSheetId = request.TimeSheetId,
                UserId = user!.Id,
            }).ToList();

            timesheetRegistrationRefRepository.AddRange(entities);
            return Ok();
        }

        // DELETE api/timesheet/register/uid
        [HttpDelete("{id}")]
        public IActionResult Delete(string id)
        {
            timesheetRegistrationRefRepository.DeleteById(id);
            return NoContent();
        }

        [HttpPost("delete-range")]
        public IActionResult DeleteRange([FromBody] ArrayRequest requests)
        {
            foreach(var request in requests.Items)
            {
                timesheetRegistrationRefRepository.DeleteById(request);
            }
            return NoContent();
        }
    }
}
