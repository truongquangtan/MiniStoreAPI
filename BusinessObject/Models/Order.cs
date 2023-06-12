using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class Order
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string? UserId { get; set; }

    public decimal Amount { get; set; }

    public DateTime? CreatedAt { get; set; } = DateTime.Now;

    public string ShipAddress { get; set; }

    public string Status { get; set; }

    public string Payment { get; set; }

    public DateTime? ShippedAt { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    [JsonIgnore]
    public virtual User? User { get; set; }
}
