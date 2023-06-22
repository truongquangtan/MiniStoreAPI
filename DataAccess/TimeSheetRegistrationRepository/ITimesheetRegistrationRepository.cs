using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.TimeSheetRegistrationRepository
{
    public interface ITimesheetRegistrationRepository : ICrudBaseRepository<TimeSheetRegistration, string>
    {
        void AddRange(IEnumerable<TimeSheetRegistration> records);
        IEnumerable<TimeSheetRegistration> GetByUserId(string userId);
        IEnumerable<TimeSheetRegistration> GetByTimeSheetId(string timeSheetId);
        IEnumerable<TimeSheetRegistration> GetByUserIdAndTimeRange(string userId, DateTime startDate, DateTime endDate);
        IEnumerable<TimeSheetRegistration> GetAllByTimeRange(DateTime startDate, DateTime endDate);
    }
}
