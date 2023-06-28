using BusinessObject.Models;

namespace API.DTOs.Response
{
    public class TimesheetWithSalaryResponse
    {
        public string Role { get; set; }
        public IEnumerable<TimesheetDTO> TimesheetsWithSalary { get; set; }
        public IEnumerable<TimeSheet> TimeSheets { get; set; }
    }
    public class TimesheetWithSalaryForAdminResponse
    {
        public string Role { get; set; }
        public IEnumerable<TimesheetDTOForAdmin> TimesheetsWithSalary { get; set; }
        public IEnumerable<TimeSheet> TimeSheets { get; set; }
    }

    public class TimesheetDTO
    {
        public DateTime Date { get; set; }
        public IEnumerable<TimesheetWithSalary> TimesheetData { get; set; }
    }
    public class TimesheetDTOForAdmin
    {
        public DateTime Date { get; set; }
        public IEnumerable<TimesheetWithSalaryForAdmin> TimesheetData { get; set; }
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

    public class TimesheetWithSalaryForAdmin
    {
        public string TimesheetId { get; set; }
        public string Name { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Salary { get; set; }
        public string Note { get; set; } = "";
        public bool IsPicked { get; set; } = false;
        public bool IsScheduled { get; set; } = false;
        public IEnumerable<RegisterInfo> RegisterData { get; set; } = new List<RegisterInfo>();
        public IEnumerable<RegisterInfo> ScheduleData { get; set;} = new List<RegisterInfo>();
    }
    public class RegisterInfo
    {
        public string Id { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string Avatar { get; set; }
        public DateTime RequestAt { get; set; }
    }
}
