using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.TimesheetRepository
{
    public class TimesheetRepository : ITimesheetRepository, IDisposable
    {
        private readonly MiniStoreContext context = new ();

        public void DeleteById(string id)
        {
            var deleteItem = context.TimeSheets.Where(t => t.Id == id).FirstOrDefault();
            if (deleteItem != null)
            {
                deleteItem.IsActive = false;
                context.SaveChanges();
            }
        }

        public void Dispose()
        {
            context?.Dispose();
        }

        public IEnumerable<TimeSheet> GetAll()
        {
            return context.TimeSheets.Where(t => t.IsActive == true).Include(t => t.Role).ToList();
        }

        public TimeSheet? GetById(string id)
        {
            return context.TimeSheets.Where(t => t.Id == id).Include(t => t.Role).FirstOrDefault();
        }

        public TimeSheet? Save(TimeSheet entity)
        {
            var timesheet = context.TimeSheets.Add(entity);
            context.SaveChanges();
            return timesheet.Entity;
        }

        public void Update(TimeSheet entity)
        {
            context.TimeSheets.Update(entity);
            context.SaveChanges();
        }

        public IEnumerable<TimeSheet> GetByRole(int roleId)
        {
            return context.TimeSheets.Where(t => t.RoleId == roleId && t.IsActive == true).Include(t => t.Role).ToList().OrderBy(t => t.TimeRange).ToList();
        }
    }
}
