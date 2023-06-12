using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class ProductImage
{
    public int Id { get; set; }

    public int ProductId { get; set; }

    public string Image { get; set; }

    [JsonIgnore]
    public virtual Product? Product { get; set; }
}
