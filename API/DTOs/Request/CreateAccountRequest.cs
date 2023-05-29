namespace API.DTOs.Request
{
    public class CreateAccountRequest
    {
        public string Fullname { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string Phone { get; set; }

        public IFormFile? Avatar { get; set; }

        public string Address { get; set; }

        public DateTime? Dob { get; set; }

        public int RoleId { get; set; }
    }
}
