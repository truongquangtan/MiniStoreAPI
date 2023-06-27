using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class User
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string Fullname { get; set; }

    public string Email { get; set; }

    public string Password { get; set; }

    public string Phone { get; set; }

    public string Avatar { get; set; }

    public string Address { get; set; }

    public DateTime? Dob { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.Now;

    public decimal? AmountSelled { get; set; }

    public bool IsActive { get; set; } = true;

    public bool IsDeleted { get; set; } = false;

    public bool IsConfirmed { get; set; } = true;

    public string? Token { get; set; }

    public bool? IsLogout { get; set; } = true;

    public int? RoleId { get; set; }

    public decimal? Salary { get; set; }

    [JsonIgnore]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Role Role { get; set; }

    [JsonIgnore]
    public virtual ICollection<TimeSheetRegistrationReference> TimeSheetRegistrationReferences { get; set; } = new List<TimeSheetRegistrationReference>();

    [JsonIgnore]
    public virtual ICollection<TimeSheetRegistration> TimeSheetRegistrations { get; set; } = new List<TimeSheetRegistration>();
}
