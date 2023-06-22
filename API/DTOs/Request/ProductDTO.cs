namespace API.DTOs.Request
{
    public class ProductDTO
    {
        public string Name { get; set; }

        public decimal Price { get; set; }

        public int Quantity { get; set; }

        public string Source { get; set; }

        public int CategoryId { get; set; }

        public string Description { get; set; }

        public IFormFile? Image { get; set; }
    }
}
