namespace API.DTOs
{
    public class CoefficientRule
    {
        public CoefficientRate Sale { get; set; }
        public CoefficientRate Guard { get; set; }
    }

    public class CoefficientRate
    {
        public decimal Weekend { get; set; }
        public decimal Holiday { get; set; }
    }
}
