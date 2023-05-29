using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class TimeSheetRegistration
{
    public string Id { get; set; }

    public string UserId { get; set; }

    public string TimeSheetId { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual TimeSheet TimeSheet { get; set; }

    public virtual ICollection<TimeSheetCheck> TimeSheetChecks { get; set; } = new List<TimeSheetCheck>();

    public virtual User User { get; set; }
}
