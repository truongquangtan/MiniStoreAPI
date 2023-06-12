using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class Product
{
    public int Id { get; set; }

    public string Name { get; set; }

    public decimal Price { get; set; }

    public int Quantity { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.Now;

    public DateTime LastUpdatedAt { get; set; } = DateTime.Now;

    public string Source { get; set; }

    public int CategoryId { get; set; }

    [JsonIgnore]
    public bool IsActive { get; set; } = true;

    [JsonIgnore]
    public bool IsDeleted { get; set; } = false;

    public string Description { get; set; }

    public virtual Category? Category { get; set; }
    [JsonIgnore]

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<ProductImage> ProductImages { get; set; } = new List<ProductImage>();
}
