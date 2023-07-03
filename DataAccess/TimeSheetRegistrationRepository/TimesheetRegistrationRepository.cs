using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;
using System.Transactions;

namespace DataAccess.TimeSheetRegistrationRepository
{
    public class TimesheetRegistrationRepository : ITimesheetRegistrationRepository, IDisposable
    {
        private readonly MiniStoreContext context = new ();

        public void Dispose()
        {
            context?.Dispose();
        }

        public IEnumerable<TimeSheetRegistration> GetAll()
        {
            return context.TimeSheetRegistrations.ToList();
        }

        public TimeSheetRegistration? GetById(string id)
        {
            return context.TimeSheetRegistrations.Where(t => t.Id == id).Include(t => t.TimeSheet).FirstOrDefault();
        }

        public TimeSheetRegistration? Save(TimeSheetRegistration entity)
        {
            var entitySaved = context.TimeSheetRegistrations.Add(entity);
            context.SaveChanges();
            return entitySaved.Entity;
        }

        public void Update(TimeSheetRegistration entity)
        {
            context.TimeSheetRegistrations.Update(entity);
            context.SaveChanges();
        }

        public void DeleteById(string id)
        {
            var entity = context.TimeSheetRegistrations.Find(id);
            if(entity != null)
            {
                context.TimeSheetRegistrations.Remove(entity);
                context.SaveChanges();
            }
        }

        public void AddRange(IEnumerable<TimeSheetRegistration> records)
        {
            foreach (var record in records)
            {
                bool isEntityExisted = context.TimeSheetRegistrations
                    .Where(t => t.UserId == record.UserId && t.TimeSheetId == record.TimeSheetId && t.Date == record.Date)
                    .Any();
                if (!isEntityExisted)
                {
                    context.Add(record);
                }
            }

            context.SaveChanges();
        }

        public IEnumerable<TimeSheetRegistration> GetByUserId(string userId)
        {
            return context.TimeSheetRegistrations.Where(t => t.UserId == userId).Include(t => t.TimeSheet).OrderBy(t => t.Date).ToList();
        }

        public IEnumerable<TimeSheetRegistration> GetByTimeSheetId(string timeSheetId)
            => context.TimeSheetRegistrations.Where(t => t.TimeSheetId == timeSheetId).Include(t => t.TimeSheet).ToList();

        public IEnumerable<TimeSheetRegistration> GetByUserIdAndTimeRange(string userId, DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrations
            .Where(t => t.UserId == userId && t.Date >= startDate && t.Date <= endDate)
            .Include(t => t.TimeSheet)
            .OrderBy(t => t.Date)
            .ToList();

        public IEnumerable<TimeSheetRegistration> GetAllByTimeRange(DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrations
            .Where(t => t.Date >= startDate && t.Date <= endDate)
            .Include(t => t.TimeSheet)
            .Include(t => t.User)
            .OrderBy(t => t.Date)
            .ThenBy(t => t.TimeSheet.TimeRange)
            .ToList();

        public IEnumerable<TimeSheetRegistration> GetByRoleIdAndTimeRange(int roleId, DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrations
            .Include(t => t.TimeSheet)
            .Include(t => t.User)
            .Where(t => t.Date >= startDate && t.Date <= endDate && t.User.RoleId == roleId)
            .ToList();

        public IEnumerable<TimeSheetRegistration> GetByTimesheetIdAndDate(string timesheetId, DateTime date)
        {
            return context.TimeSheetRegistrations
                .Where(t => t.TimeSheetId == timesheetId && t.Date == date)
                .Include(t => t.User)
                .Include(t => t.TimeSheet)
                .ToList();
        }

        public void DeleteRange(IEnumerable<TimeSheetRegistration> registrations)
        {
            context.TimeSheetRegistrations.RemoveRange(registrations);
            context.SaveChanges();
        }
    }
}
