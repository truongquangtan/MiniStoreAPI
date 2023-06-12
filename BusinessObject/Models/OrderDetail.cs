using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class OrderDetail
{
    public string? Id { get; set; } = Guid.NewGuid().ToString();

    public string? OrderId { get; set; }

    public int ProductId { get; set; }

    public int Quantity { get; set; }

    public decimal Price { get; set; }

    [JsonIgnore]
    public virtual Order? Order { get; set; }

    public virtual Product? Product { get; set; }

    public override bool Equals(object? obj)
    {
        if ((obj == null) || !this.GetType().Equals(obj.GetType()))
        {
            return false;
        }
        OrderDetail orderDetail = obj as OrderDetail;
        return this.Id == orderDetail!.Id;
    }
}
