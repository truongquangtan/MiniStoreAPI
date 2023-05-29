using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class Role
{
    public int Id { get; set; }

    public string Name { get; set; }

    public virtual ICollection<TimeSheet> TimeSheets { get; set; } = new List<TimeSheet>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
