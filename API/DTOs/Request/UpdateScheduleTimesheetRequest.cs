namespace API.DTOs.Request
{
    public class UpdateScheduleTimesheetRequest
    {
        public string TimesheetId { get; set; }
        public DateTime Date { get; set; }
        public IEnumerable<string> UserIds { get; set; }
        public decimal Salary { get; set; }
    }
}
