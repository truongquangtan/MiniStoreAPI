using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class Order
{
    public string Id { get; set; }

    public string UserId { get; set; }

    public decimal Amount { get; set; }

    public DateTime CreatedAt { get; set; }

    public string ShipAddress { get; set; }

    public string Status { get; set; }

    public string Payment { get; set; }

    public DateTime? ShippedAt { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual User User { get; set; }
}
