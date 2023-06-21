using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class TimeSheetRegistration
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string UserId { get; set; }

    public string TimeSheetId { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.Now;

    public DateTime? Date { get; set; }

    public virtual TimeSheet TimeSheet { get; set; }

    [JsonIgnore]
    public virtual ICollection<TimeSheetCheck> TimeSheetChecks { get; set; } = new List<TimeSheetCheck>();

    public virtual User User { get; set; }
}
