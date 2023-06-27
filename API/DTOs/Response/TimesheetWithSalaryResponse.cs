using BusinessObject.Models;

namespace API.DTOs.Response
{
    public class TimesheetWithSalaryResponse
    {
        public string Role { get; set; }
        public IEnumerable<TimesheetDTO> TimesheetsWithSalary { get; set; }
        public IEnumerable<TimeSheet> TimeSheets { get; set; }
    }

    public class TimesheetDTO
    {
        public DateTime Date { get; set; }
        public IEnumerable<TimesheetWithSalary> TimesheetData { get; set; }
    }

    public class TimesheetWithSalary
    {
        public string TimesheetId { get; set; }
        public string Name { get; set;}
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Salary { get; set; }
        public string Note { get; set; } = "";
        public bool IsPicked { get; set; } = false;
        public bool IsScheduled { get; set; } = false;
        public string RegisterId { get; set; } = "";
    }
}
