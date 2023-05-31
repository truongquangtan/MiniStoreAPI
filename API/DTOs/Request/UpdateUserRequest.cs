namespace API.DTOs.Request
{
    public class UpdateUserRequest
    {
        public string? Fullname { get; set; }

        public string? Phone { get; set; }

        public IFormFile? Avatar { get; set; }

        public string? Address { get; set; }

        public DateTime? Dob { get; set; }

        public int? RoleId { get; set; }
    }
}
