using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.TimeSheetRegistrationRefRepository
{
    public interface ITimesheetRegistrationRefRepository : ICrudBaseRepository<TimeSheetRegistrationReference, string>
    {
        void AddRange(IEnumerable<TimeSheetRegistrationReference> records);
        IEnumerable<TimeSheetRegistrationReference> GetByUserId(string userId);
        IEnumerable<TimeSheetRegistrationReference> GetByTimeSheetId(string timeSheetId);
        IEnumerable<TimeSheetRegistrationReference> GetByUserIdAndTimeRange(string userId, DateTime startDate, DateTime endDate);
        IEnumerable<TimeSheetRegistrationReference> GetAllByTimeRange(DateTime startDate, DateTime endDate);
    }
}
