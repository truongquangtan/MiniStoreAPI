using API.DTOs.Request;
using BusinessObject.Models;
using DataAccess.TimeSheetRegistrationRepository;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/timesheet/register")]
    [ApiController]
    public class TimesheetRegisterController : ControllerBase
    {
        private readonly ITimesheetRegistrationRepository timesheetRegistrationRepository;

        public TimesheetRegisterController(ITimesheetRegistrationRepository timesheetRegistrationRepository)
        {
            this.timesheetRegistrationRepository = timesheetRegistrationRepository;
        }

        // GET api/timesheet/register?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet]
        public IActionResult Get([FromRoute] DateTime? startDate, [FromRoute] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            var user = HttpContext.Items["User"] as User;
            return Ok(timesheetRegistrationRepository.GetByUserIdAndTimeRange(user!.Id, start, end));
        }

        // GET api/timesheet/register/all?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet("all")]
        public IActionResult GetForAdmin([FromRoute] DateTime? startDate, [FromRoute] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            return Ok(timesheetRegistrationRepository.GetAllByTimeRange(start, end));
        }


        // POST api/timesheet/register
        [HttpPost]
        public IActionResult Post([FromBody] IEnumerable<TimesheetRegisterRequest> requests)
        {
            var user = HttpContext.Items["User"] as User;

            foreach(var request in requests)
            {
                if (request.UserId == null)
                {
                    return BadRequest("There are some requests do not provide userId");
                }
            }

            var entities = requests.Select(request => new TimeSheetRegistration()
            {
                Date = request.Date,
                TimeSheetId = request.TimeSheetId,
                UserId = request.UserId!,
            }).ToList();

            timesheetRegistrationRepository.AddRange(entities);
            return Ok();
        }

        // DELETE api/timesheet/register/uid
        [HttpDelete("{id}")]
        public IActionResult Delete(string id)
        {
            timesheetRegistrationRepository.DeleteById(id);
            return NoContent();
        }

        [HttpDelete]
        public IActionResult DeleteRange([FromBody] ArrayRequest requests)
        {
            foreach(var request in requests.Items)
            {
                timesheetRegistrationRepository.DeleteById(request);
            }
            return NoContent();
        }
    }
}
