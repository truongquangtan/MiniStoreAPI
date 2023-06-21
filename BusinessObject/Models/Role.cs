using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class Role
{
    public int Id { get; set; }

    public string Name { get; set; }

    [JsonIgnore]
    public virtual ICollection<TimeSheet> TimeSheets { get; set; } = new List<TimeSheet>();

    [JsonIgnore]
    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
