using System.ComponentModel.DataAnnotations;

namespace API.DTOs.Request
{
    public class TimesheetRegisterRequest
    {
        [Required]
        public DateTime Date { get; set; }
        [Required]
        public string TimeSheetId { get; set; }
        public string? UserId { get; set; }
        public decimal? Salary { get; set; }
    }
}
