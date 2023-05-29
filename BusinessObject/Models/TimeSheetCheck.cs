using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class TimeSheetCheck
{
    public int Id { get; set; }

    public string TimeSheetRegistrationId { get; set; }

    public string UserId { get; set; }

    public DateTime CheckedAt { get; set; }

    public decimal CoefficientAmount { get; set; }

    public string Note { get; set; }

    public virtual TimeSheetRegistration TimeSheetRegistration { get; set; }
}
