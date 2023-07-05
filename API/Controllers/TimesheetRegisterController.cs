using API.Constants;
using API.DTOs;
using API.DTOs.Request;
using API.Services;
using API.Supporters.JwtAuthSupport;
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
        [Authorize]
        public IActionResult Get([FromQuery] DateTime? startDate, [FromQuery] DateTime? endDate)
        {
            var start = startDate == null ? DateTime.Now : startDate.Value;
            var end = endDate == null ? DateTime.Now.AddYears(10) : endDate.Value;
            var user = HttpContext.Items["User"] as User;
            return Ok(worksheetService.GetTimesheetScheduledForUser(user!.Id, start, end));
        }

        // GET api/timesheet/register/all?startDate=2023-01-01&endDate=2023-02-01
        [HttpGet("all")]
        [ManagerOnly]
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
        [ManagerOnly]
        public IActionResult Post([FromBody] IEnumerable<TimesheetRegisterRequest> requests)
        {
            try
            {
                var errors = worksheetService.ScheduleTimesheet(requests);
                return Ok(new
                {
                    IsContainErrors = errors.Count > 0,
                    ErrorsData = errors,
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // DELETE api/timesheet/register/uid
        [HttpDelete("{id}")]
        [ManagerOnly]
        public IActionResult Delete(string id)
        {
            timesheetRegistrationRepository.DeleteById(id);
            return NoContent();
        }

        [HttpPost("delete-range")]
        [ManagerOnly]
        public IActionResult DeleteRange([FromBody] ArrayRequest requests)
        {
            foreach(var request in requests.Items)
            {
                timesheetRegistrationRepository.DeleteById(request);
            }
            return NoContent();
        }

        [HttpPut]
        [ManagerOnly]
        public ActionResult UpdateTimesheetScheduled([FromBody] UpdateScheduleTimesheetRequest request)
        {
            try
            {
                worksheetService.UpdateScheduledTimesheet(request);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
