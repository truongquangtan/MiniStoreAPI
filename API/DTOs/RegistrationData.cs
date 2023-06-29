using BusinessObject.Models;

namespace API.DTOs
{
    public class RegistrationData
    {
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public IEnumerable<TimeSheetRegistration> Registrations { get; set; }
    }
}
