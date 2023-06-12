using System.Text.Json.Serialization;

namespace BusinessObject.Models;

public partial class Category
{
    public int Id { get; set; }

    public string Name { get; set; }

    [JsonIgnore]
    public bool IsDeleted { get; set; } = false;

    [JsonIgnore]
    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
