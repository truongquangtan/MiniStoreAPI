using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class TimeSheetRegistrationReference
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string UserId { get; set; }

    public DateTime Date { get; set; }

    public DateTime? CreatedAt { get; set; } = DateTime.Now;

    public string TimeSheetId { get; set; }

    public virtual TimeSheet TimeSheet { get; set; }

    public virtual User User { get; set; }
}
