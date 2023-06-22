using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.TimesheetRepository
{
    public interface ITimesheetRepository : ICrudBaseRepository<TimeSheet, string>
    {

    }
}
