using BusinessObject.Models;

namespace API.DTOs
{
    public class RequestedTimesheetDTO
    {
        public string Id { get; set; }

        public string UserId { get; set; }

        public DateTime Date { get; set; }

        public DateTime? CreatedAt { get; set; }

        public string TimeSheetId { get; set; }

        public TimeSheet TimeSheet { get; set; }

        public decimal Salary { get; set; }
        public string Note { get; set; }

        public RequestedTimesheetDTO(TimeSheetRegistrationReference timesheet, decimal salary, string note)
        {
            Id = timesheet.Id;
            UserId = timesheet.UserId;
            Date = timesheet.Date;
            CreatedAt = timesheet.CreatedAt;
            TimeSheetId = timesheet.TimeSheetId;
            TimeSheet = timesheet.TimeSheet;
            Salary = salary;
            Note = note;
        }
    }
}
