using BusinessObject.Models;

namespace DataAccess.TimeSheetRegistrationRepository
{
    public interface ITimesheetRegistrationRepository : ICrudBaseRepository<TimeSheetRegistration, string>
    {
        void AddRange(IEnumerable<TimeSheetRegistration> records);
        IEnumerable<TimeSheetRegistration> GetByUserId(string userId);
        IEnumerable<TimeSheetRegistration> GetByTimeSheetId(string timeSheetId);
        IEnumerable<TimeSheetRegistration> GetByUserIdAndTimeRange(string userId, DateTime startDate, DateTime endDate);
        IEnumerable<TimeSheetRegistration> GetAllByTimeRange(DateTime startDate, DateTime endDate);
        IEnumerable<TimeSheetRegistration> GetByRoleIdAndTimeRange(int roleId, DateTime startDate, DateTime endDate);
        IEnumerable<TimeSheetRegistration> GetByTimesheetIdAndDate(string timesheetId, DateTime date);
        void DeleteRange(IEnumerable<TimeSheetRegistration> records);
    }
}
