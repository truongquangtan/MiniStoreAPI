using BusinessObject.Models;

namespace DataAccess.TimesheetCheckRepository
{
    public interface ITimesheetCheckRepository : ICrudBaseRepository<TimeSheetCheck, int>
    {
        TimeSheetCheck? GetByRegistrationId(string registrationId);
    }
}
