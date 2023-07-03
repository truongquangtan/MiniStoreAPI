namespace API.DTOs.Response
{
    public class TimesheetScheduledResponse
    {
        public string Id { get; set; }
        public int  IntId { get; set; }
        public string TimesheetName { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
    }
}
