using API.Constants;
using API.DTOs;
using API.DTOs.Request;
using API.Services;
using BusinessObject.Models;
using DataAccess.RoleRepository;
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
        private readonly IRoleRepository roleRepository;
        private readonly WorksheetService worksheetService;

        public TimesheetRegisterController(ITimesheetRegistrationRepository timesheetRegistrationRepository, IRoleRepository roleRepository, WorksheetService worksheetService)
        {
            this.timesheetRegistrationRepository = timesheetRegistrationRepository;
            this.roleRepository = roleRepository;
            this.worksheetService = worksheetService;
        }

        // GET api/timesheet/register?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet]
        public IActionResult Get([FromQuery] DateTime? startDate, [FromQuery] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            var user = HttpContext.Items["User"] as User;
            return Ok(worksheetService.GetTimesheetScheduledForUser(user!.Id, start, end));
        }

        // GET api/timesheet/register/all?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet("all")]
        public IActionResult GetForAdmin([FromQuery] DateTime? startDate, [FromQuery] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            var registrationEntities = timesheetRegistrationRepository.GetAllByTimeRange(start, end);
            var roleEntities = roleRepository.GetAll();
            var response = roleEntities.Where(role => role.Id != RoleConstant.MANAGER)
                                                        .Select(role =>
                                                        {
                                                            return new RegistrationData()
                                                            {
                                                                RoleId = role.Id,
                                                                RoleName = role.Name,
                                                                Registrations = registrationEntities.Where(d => d.User.RoleId == role.Id)
                                                            };
                                                        }).ToList();
            return Ok(response);
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
                Salary = request.Salary!.Value,
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

        [HttpPost("delete-range")]
        public IActionResult DeleteRange([FromBody] ArrayRequest requests)
        {
            foreach(var request in requests.Items)
            {
                timesheetRegistrationRepository.DeleteById(request);
            }
            return NoContent();
        }

        [HttpPut]
        public ActionResult UpdateTimesheetScheduled([FromBody] UpdateScheduleTimesheetRequest request)
        {
            worksheetService.UpdateScheduledTimesheet(request);
            return Ok();
        }
    }
}
