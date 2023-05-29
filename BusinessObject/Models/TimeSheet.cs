using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class TimeSheet
{
    public string Id { get; set; }

    public int RoleId { get; set; }

    public string TimeRange { get; set; }

    public bool IsActive { get; set; }

    public virtual Role Role { get; set; }

    public virtual ICollection<TimeSheetRegistration> TimeSheetRegistrations { get; set; } = new List<TimeSheetRegistration>();
}
