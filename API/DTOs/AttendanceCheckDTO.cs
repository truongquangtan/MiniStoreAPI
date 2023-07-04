using BusinessObject.Models;

namespace API.DTOs
{
    public class AttendanceCheckDTO
    {
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string UserId { get; set; }
        public string RegistrationId { get; set; }
        public TimeSheet TimeSheet { get; set; }
        public bool IsChecked { get; set; }
        public string CheckStatus { get; set; } = "NOT YET";
        public int? CheckId { get; set; }
        public TimeSheetCheck? CheckData { get; set; }
        public decimal Salary { get; set; }
    }
}
