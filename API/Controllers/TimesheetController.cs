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

        public TimesheetController(ITimesheetRepository timesheetRepository)
        {
            this.timesheetRepository = timesheetRepository;
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

        // POST api/timesheet
        [HttpPost]
        public ActionResult Post([FromBody] TimeSheet value)
        {
            var result = timesheetRepository.Save(value);
            return Ok(result);
        }

        // PUT api/timesheet/5
        [HttpPut("{id}")]
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
        public ActionResult Delete(string id)
        {
            timesheetRepository.DeleteById(id);
            return NoContent();
        }
    }
}
