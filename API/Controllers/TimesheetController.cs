using API.Constants;
using API.DTOs.Response;
using API.Services;
using API.Supporters.JwtAuthSupport;
using BusinessObject.Models;
using DataAccess.TimesheetRepository;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/timesheet")]
    [ApiController]
    public class TimesheetController : ControllerBase
    {
        private readonly ITimesheetRepository timesheetRepository;
        private readonly WorksheetService worksheetService;

        public TimesheetController(ITimesheetRepository timesheetRepository, WorksheetService worksheetService)
        {
            this.timesheetRepository = timesheetRepository;
            this.worksheetService = worksheetService;
        }

        // GET: api/timesheet/all
        [HttpGet("all")]
        public IEnumerable<TimeSheet> Get()
        {
            return timesheetRepository.GetAll();
        }

        // GET api/timesheet/abc-abc-abc
        [HttpGet("{id}")]
        public ActionResult Get(string id)
        {
            var entity = timesheetRepository.GetById(id);
            if(entity == null)
            {
                return NotFound();
            }

            return Ok(entity);
        }

        [HttpGet("timesheet-with-salary")]
        [Authorize]
        public async Task<ActionResult> GetWithSalary([FromQuery] DateTime startDate, [FromQuery] int addIn)
        {
            if(startDate.CompareTo(DateTime.Now.Date) < 0)
            {
                return BadRequest("Date must be from now");
            }
            if (addIn <= 0)
            {
                return BadRequest("Add in date must be positive");
            }
            var role = HttpContext.Items["Role"] as int?;
            var user = HttpContext.Items["User"] as BusinessObject.Models.User;

            var response = new TimesheetWithSalaryResponse
            {
                Role = role == RoleConstant.SALES ? "Sales" : "Guard",
                TimeSheets = timesheetRepository.GetByRole(role!.Value)
            };

            var timesheets = new List<TimesheetDTO>();
            for (int i = 0; i < addIn; i++)
            {
                var date = startDate.Date.AddDays(i);
                timesheets.Add(new TimesheetDTO()
                {
                    Date = date,
                    TimesheetData = worksheetService.GetTimesheetWithSalaryByDate(date, role!.Value, user!.Id)
                });
            }

            response.TimesheetsWithSalary = timesheets;

            return Ok(response);
        }

        [HttpGet("timesheet-for-schedule")]
        [ManagerOnly]
        public async Task<ActionResult> GetForSchedule([FromQuery] DateTime startDate, [FromQuery] int addIn, [FromQuery] int roleId)
        {
            if (startDate.CompareTo(DateTime.Now.Date) < 0)
            {
                return BadRequest("Date must be from now");
            }
            if (addIn <= 0)
            {
                return BadRequest("Add in date must be positive");
            }

            var response = new TimesheetWithSalaryForAdminResponse
            {
                Role = roleId == RoleConstant.SALES ? "Sales" : "Guard",
                TimeSheets = timesheetRepository.GetByRole(roleId)
            };

            var timesheets = new List<TimesheetDTOForAdmin>();
            for (int i = 0; i < addIn; i++)
            {
                var date = startDate.Date.AddDays(i);
                timesheets.Add(new TimesheetDTOForAdmin()
                {
                    Date = date,
                    TimesheetData = worksheetService.GetTimesheetForSchedule(date, roleId)
                });
            }

            response.TimesheetsWithSalary = timesheets;

            return Ok(response);
        }

        // POST api/timesheet
        [HttpPost]
        [ManagerOnly]
        public ActionResult Post([FromBody] TimeSheet value)
        {
            var result = timesheetRepository.Save(value);
            return Ok(result);
        }

        // PUT api/timesheet/5
        [HttpPut("{id}")]
        [ManagerOnly]
        public ActionResult Put(string id, [FromBody] TimeSheet value)
        {
            if(id != value.Id)
            {
                return BadRequest("The id is not match");
            }

            timesheetRepository.Update(value);
            return Ok();
        }

        // DELETE api/timesheet/5
        [HttpDelete("{id}")]
        [ManagerOnly]
        public ActionResult Delete(string id)
        {
            timesheetRepository.DeleteById(id);
            return NoContent();
        }
    }
}
