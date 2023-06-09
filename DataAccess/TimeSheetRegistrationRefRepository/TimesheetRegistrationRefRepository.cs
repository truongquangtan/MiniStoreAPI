﻿using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.TimeSheetRegistrationRefRepository
{
    public class TimesheetRegistrationRefRepository : ITimesheetRegistrationRefRepository, IDisposable
    {
        private readonly MiniStoreContext context = new ();

        public void Dispose()
        {
            context?.Dispose();
        }

        public IEnumerable<TimeSheetRegistrationReference> GetAll()
        {
            return context.TimeSheetRegistrationReferences.ToList();
        }

        public TimeSheetRegistrationReference? GetById(string id)
        {
            return context.TimeSheetRegistrationReferences.Find(id);
        }

        public TimeSheetRegistrationReference? Save(TimeSheetRegistrationReference entity)
        {
            var timesheetRegistrationRefEntity = context.TimeSheetRegistrationReferences.Add(entity);
            context.SaveChanges();
            return timesheetRegistrationRefEntity.Entity;
        }

        public void DeleteById(string id)
        {
            var timesheetRegistrationRefEntity = context.TimeSheetRegistrationReferences.Find(id);
            if (timesheetRegistrationRefEntity != null)
            {
                context.TimeSheetRegistrationReferences.Remove(timesheetRegistrationRefEntity);
                context.SaveChanges();
            }
        }

        public void Update(TimeSheetRegistrationReference entity)
        {
            context.TimeSheetRegistrationReferences.Update(entity);
            context.SaveChanges();
        }

        public void AddRange(IEnumerable<TimeSheetRegistrationReference> records)
        {
            foreach (var record in records)
            {
                bool isEntityExisted = context.TimeSheetRegistrationReferences
                    .Where(t => t.UserId == record.UserId && t.TimeSheetId == record.TimeSheetId && t.Date == record.Date)
                    .Any();
                if (!isEntityExisted)
                {
                    context.Add(record);
                }
            }

            context.SaveChanges();
        }

        public IEnumerable<TimeSheetRegistrationReference> GetByUserId(string userId)
        {
            return context.TimeSheetRegistrationReferences.Where(t => t.UserId == userId).Include(t => t.TimeSheet).OrderBy(t => t.Date).ToList();
        }

        public IEnumerable<TimeSheetRegistrationReference> GetByTimeSheetId(string timeSheetId)
            => context.TimeSheetRegistrationReferences.Where(t => t.TimeSheetId == timeSheetId).Include(t => t.TimeSheet).ToList();

        public IEnumerable<TimeSheetRegistrationReference> GetByUserIdAndTimeRange(string userId, DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrationReferences
            .Where(t => t.UserId == userId && t.Date >= startDate && t.Date <= endDate)
            .Include(t => t.TimeSheet)
            .OrderBy(t => t.Date)
            .ThenBy(t => t.TimeSheet.TimeRange)
            .ToList();

        public IEnumerable<TimeSheetRegistrationReference> GetAllByTimeRange(DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrationReferences
            .Where(t => t.Date >= startDate && t.Date <= endDate)
            .Include(t => t.TimeSheet)
            .ToList();

        public IEnumerable<TimeSheetRegistrationReference> GetByRoleIdAndTimeRange(int roleId, DateTime startDate, DateTime endDate)
            => context.TimeSheetRegistrationReferences
            .Include(t => t.TimeSheet)
            .Include(t => t.User)
            .Where(t => t.Date >= startDate && t.Date <= endDate && t.User.RoleId == roleId)
            .ToList();
    }
}
