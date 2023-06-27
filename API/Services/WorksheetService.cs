using API.Constants;
using API.DTOs;
using API.DTOs.Response;
using API.Supporters.Utils;
using BusinessObject.Models;
using DataAccess.TimeSheetRegistrationRefRepository;
using DataAccess.TimeSheetRegistrationRepository;
using DataAccess.TimesheetRepository;
using Firebase.Auth;
using System.Globalization;
using System.Text.Json;

namespace API.Services
{
    public class WorksheetService
    {
        private readonly ITimesheetRepository timesheetRepository;
        private readonly ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository;
        private readonly ITimesheetRegistrationRepository timesheetRegistrationRepository;

        public WorksheetService(
            ITimesheetRepository timesheetRepository,
            ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository,
            ITimesheetRegistrationRepository timesheetRegistrationRepository)
        {
            this.timesheetRepository = timesheetRepository;
            this.timesheetRegistrationRefRepository = timesheetRegistrationRefRepository;
            this.timesheetRegistrationRepository = timesheetRegistrationRepository;
        }

        public IEnumerable<TimesheetWithSalary> GetTimesheetWithSalaryByDate(DateTime date, int roleId, string userId)
        {
            var holidays = TimesheetData.GetInstance().Holidays;
            var unitSalary = TimesheetData.GetInstance().UnitSalary;

            var timesheetEntities = timesheetRepository.GetByRole(roleId);
            var timesheetRegisteredRefs = timesheetRegistrationRefRepository.GetByUserIdAndTimeRange(userId, date.Date, date.Date);
            var timesheetRegistered = timesheetRegistrationRepository.GetByUserIdAndTimeRange(userId, date.Date, date.Date);

            var result = timesheetEntities.Select(t =>
            {
                //var (startTime, endTime) = ExtractTheData(t.TimeRange, date);
                //var (salary, note) = CalculateTheSalaryBaseOnDate(startTime, endTime, t.CoefficientAmount, roleId);
                var (salary, note) = CalculateSalaryOfTimesheetInDate(t, date);
                var registerEntity = timesheetRegisteredRefs.Where(d => d.TimeSheetId == t.Id).FirstOrDefault();
                return new TimesheetWithSalary
                {
                    TimesheetId = t.Id,
                    Name = t.Name,
                    StartTime = t.TimeRange.Split("-")[0],
                    EndTime = t.TimeRange.Split("-")[1],
                    Salary = salary.ToString(),
                    Note = note,
                    IsPicked = registerEntity != null,
                    IsScheduled = timesheetRegistered.Where(d => d.TimeSheetId == t.Id).Any(),
                    RegisterId = registerEntity != null ? registerEntity.Id : "",
                };
            });
            return result;
        }

        private static (decimal salary, string note) CalculateSalaryOfTimesheetInDate(TimeSheet timesheet, DateTime date)
        {
            var (startTime, endTime) = ExtractTheData(timesheet.TimeRange, date);
            return CalculateTheSalaryBaseOnDate(startTime, endTime, timesheet.CoefficientAmount, timesheet.RoleId);
        }

        private static (DateTime startTime, DateTime endTime) ExtractTheData(string data, DateTime date)
        {
            // data is like that: 06:00-12:00
            var startHour = int.Parse(data.Split("-")[0].Split(":")[0]);
            var startMinute = int.Parse(data.Split("-")[0].Split(":")[1]);
            var endHour = int.Parse(data.Split("-")[1].Split(":")[0]);
            var endMinute = int.Parse(data.Split("-")[1].Split(":")[1]);

            if(startHour < endHour)
            {
                var startDateTime = new DateTime(date.Year, date.Month, date.Day, startHour, startMinute, 0);
                var endDateTime = new DateTime(date.Year, date.Month, date.Day, endHour, endMinute, 0);
                return (startDateTime, endDateTime);
            }
            else
            {
                var startDateTime = new DateTime(date.Year, date.Month, date.Day, startHour, startMinute, 0);
                var endDateTime = new DateTime(date.Year, date.Month, date.Day, endHour, endMinute, 0).AddDays(1);
                return (startDateTime, endDateTime);
            }
        }
        private static (decimal salary, string note) CalculateTheSalaryBaseOnDate(DateTime startTime, DateTime endTime, decimal coefficient, int role)
        {
            var unitSalary = TimesheetData.GetInstance().UnitSalary;
            var coefficientRule = TimesheetData.GetInstance().CoefficientRule;
            unitSalary *= coefficient;
            // First: Consider the holiday
            var selected = TimesheetData.GetInstance().Holidays
                .Where(h => h.Date.Date.CompareTo(startTime.Date) == 0 || h.Date.Date.CompareTo(endTime.Date) == 0)
                .FirstOrDefault();
            if(selected != null)
            {
                return (role == RoleConstant.SALES ? unitSalary * coefficientRule.Sale.Holiday : unitSalary * coefficientRule.Guard.Holiday, selected.Name);
            }
            // Second: Consider the weekend
            if(startTime.DayOfWeek == DayOfWeek.Sunday || endTime.DayOfWeek == DayOfWeek.Sunday)
            {
                return (role == RoleConstant.SALES ? unitSalary * coefficientRule.Sale.Weekend : unitSalary * coefficientRule.Guard.Weekend, "Weekend");
            }
            // Third: Use default co-efficient
            return (unitSalary, "");
        }

        public IEnumerable<RequestedTimesheetDTO> GetRequestedTimesheets(string userId, DateTime startTime, DateTime endTime)
        {
            var timesheetRegistrationRefEntities = timesheetRegistrationRefRepository.GetByUserIdAndTimeRange(userId, startTime, endTime);
            return timesheetRegistrationRefEntities.Select(entity =>
            {
                var (salary, note) = CalculateSalaryOfTimesheetInDate(entity.TimeSheet, entity.Date);
                return new RequestedTimesheetDTO(entity, salary, note);
            }).ToList();
        }
    }
}
