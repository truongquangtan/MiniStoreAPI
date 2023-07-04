using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.TimesheetCheckRepository
{
    public class TimesheetCheckRepository : ITimesheetCheckRepository, IDisposable
    {
        private readonly MiniStoreContext context = new();

        public void Dispose()
        {
            context?.Dispose();
        }

        public IEnumerable<TimeSheetCheck> GetAll() => context.TimeSheetChecks.ToList();
        public IEnumerable<TimeSheetCheck> GetAllByUserId(string userId) => context.TimeSheetChecks.Where(t => t.UserId == userId).OrderBy(t => t.CheckedAt)
            .Include(t => t.TimeSheetRegistration)
            .ThenInclude(t => t.TimeSheet)
            .ToList();
        public TimeSheetCheck? GetByRegistrationId(string registrationId) => context.TimeSheetChecks.FirstOrDefault(t => t.TimeSheetRegistrationId == registrationId);
        public TimeSheetCheck? GetById(int id) => context.TimeSheetChecks.FirstOrDefault(t => t.Id == id);
        public TimeSheetCheck? Save(TimeSheetCheck timeSheetCheck)
        {
            var entitySaved = context.TimeSheetChecks.Add(timeSheetCheck);
            context.SaveChanges();
            return entitySaved.Entity;
        }
        public void DeleteById(int id)
        {
            var entity = context.TimeSheetChecks.FirstOrDefault(t => t.Id == id);
            if(entity != null)
            {
                context.TimeSheetChecks.Remove(entity);
                context.SaveChanges();
            }
        }
        public void Update(TimeSheetCheck timeSheetCheck)
        {
            context.TimeSheetChecks.Update(timeSheetCheck);
            context.SaveChanges();
        }
    }
}
