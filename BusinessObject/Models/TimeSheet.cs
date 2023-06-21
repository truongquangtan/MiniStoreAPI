using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class TimeSheet
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public int RoleId { get; set; }

    public string TimeRange { get; set; }
    public string Name { get; set; }

    public bool IsActive { get; set; } = true;

    public virtual Role? Role { get; set; }

    [JsonIgnore]
    public virtual ICollection<TimeSheetRegistrationReference> TimeSheetRegistrationReferences { get; set; } = new List<TimeSheetRegistrationReference>();

    [JsonIgnore]
    public virtual ICollection<TimeSheetRegistration> TimeSheetRegistrations { get; set; } = new List<TimeSheetRegistration>();
}
