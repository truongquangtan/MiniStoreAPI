namespace API.DTOs
{
    public class OrderProcessException : Exception
    {
        public int ProductId { get; set; } = -1;
        
        public OrderProcessException() { }
        public OrderProcessException(int productId, string message) : base(message)
        {
            ProductId = productId;
        }
        public OrderProcessException(string message) : base(message) { }
        public OrderProcessException(string message, Exception inner) : base(message, inner) { }
        protected OrderProcessException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }
    }
}
