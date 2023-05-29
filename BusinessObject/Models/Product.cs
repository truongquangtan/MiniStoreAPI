using System;
using System.Collections.Generic;

namespace BusinessObject.Models;

public partial class Product
{
    public int Id { get; set; }

    public string Name { get; set; }

    public decimal Price { get; set; }

    public int Quantity { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime LastUpdatedAt { get; set; }

    public string Source { get; set; }

    public int CategoryId { get; set; }

    public bool IsSelling { get; set; }

    public decimal OriginalPrice { get; set; }

    public bool IsActive { get; set; }

    public bool IsDeleted { get; set; }

    public string Description { get; set; }

    public virtual Category Category { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<ProductImage> ProductImages { get; set; } = new List<ProductImage>();
}
