using API.Constants;
using API.DTOs;
using API.DTOs.Request;
using API.DTOs.Response;
using API.Supporters.Utils;
using BusinessObject.Models;
using DataAccess.TimesheetCheckRepository;
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
        private const int SOON_ACCEPTED_IN_MINUTE = 30;
        private const int LATE_ACCEPTED_IN_MINUTE = 30;

        private readonly ITimesheetRepository timesheetRepository;
        private readonly ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository;
        private readonly ITimesheetRegistrationRepository timesheetRegistrationRepository;
        private readonly ITimesheetCheckRepository timesheetCheckRepository;

        public WorksheetService(
            ITimesheetRepository timesheetRepository,
            ITimesheetRegistrationRefRepository timesheetRegistrationRefRepository,
            ITimesheetRegistrationRepository timesheetRegistrationRepository,
            ITimesheetCheckRepository timesheetCheckRepository)
        {
            this.timesheetRepository = timesheetRepository;
            this.timesheetRegistrationRefRepository = timesheetRegistrationRefRepository;
            this.timesheetRegistrationRepository = timesheetRegistrationRepository;
            this.timesheetCheckRepository = timesheetCheckRepository;
        }

        public void UpdateScheduledTimesheet(UpdateScheduleTimesheetRequest request)
        {
            var registrationEntities = timesheetRegistrationRepository.GetByTimesheetIdAndDate(request.TimesheetId, request.Date);

            // Delete the user not in the request list
            var registrationEntitiesToRemove = registrationEntities.Where(d => !request.UserIds.Contains(d.UserId)).ToList();
            timesheetRegistrationRepository.DeleteRange(registrationEntitiesToRemove);

            // Add the user in request list but not in entities
            var userIdsExisted = registrationEntities.Select(d => d.UserId).ToList();

            var userIdsToAdd = request.UserIds.Except(userIdsExisted).ToList();
            if(userIdsToAdd != null && userIdsToAdd.Count == 0)
            {
                return;
            }

            userIdsToAdd!.ForEach(userId =>
            {
                var registrationEntity = new TimeSheetRegistration()
                {
                    UserId = userId,
                    TimeSheetId = request.TimesheetId,
                    Date = request.Date,
                    Salary = request.Salary,
                };
                timesheetRegistrationRepository.Save(registrationEntity);
            });
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

        public IEnumerable<TimesheetWithSalaryForAdmin> GetTimesheetForSchedule(DateTime date, int roleId)
        {
            var holidays = TimesheetData.GetInstance().Holidays;
            var unitSalary = TimesheetData.GetInstance().UnitSalary;

            var timesheetEntities = timesheetRepository.GetByRole(roleId);
            var timesheetRegisteredRefs = timesheetRegistrationRefRepository.GetByRoleIdAndTimeRange(roleId, date.Date, date.Date);
            var timesheetRegistered = timesheetRegistrationRepository.GetByRoleIdAndTimeRange(roleId, date.Date, date.Date);

            var result = timesheetEntities.Select(t =>
            {
                var (salary, note) = CalculateSalaryOfTimesheetInDate(t, date);
                var pickedEntity = timesheetRegisteredRefs.Where(d => d.TimeSheetId == t.Id).ToList();
                var scheduledEntity = timesheetRegistered.Where(d => d.TimeSheetId == t.Id).ToList();
                return new TimesheetWithSalaryForAdmin
                {
                    TimesheetId = t.Id,
                    Name = t.Name,
                    StartTime = t.TimeRange.Split("-")[0],
                    EndTime = t.TimeRange.Split("-")[1],
                    Salary = salary.ToString(),
                    Note = note,
                    IsPicked = pickedEntity != null && pickedEntity.Count > 0,
                    IsScheduled = scheduledEntity != null && scheduledEntity.Count > 0,
                    RegisterData = pickedEntity == null || pickedEntity.Count == 0 ? new List<RegisterInfo>() 
                                                                                   : pickedEntity.Select(entity => new RegisterInfo()
                                                                                   {
                                                                                       Avatar = entity.User.Avatar,
                                                                                       Id = entity.Id,
                                                                                       RequestAt = entity.CreatedAt!.Value,
                                                                                       UserId = entity.UserId,
                                                                                       UserName = entity.User.Fullname
                                                                                   }),
                    ScheduleData = scheduledEntity == null || scheduledEntity.Count == 0 ? new List<RegisterInfo>()
                                                                                   : scheduledEntity.Select(entity => new RegisterInfo()
                                                                                   {
                                                                                       Avatar = entity.User.Avatar,
                                                                                       Id = entity.Id,
                                                                                       RequestAt = entity.CreatedAt,
                                                                                       UserId = entity.UserId,
                                                                                       UserName = entity.User.Fullname
                                                                                   })
                };
            }).ToList();
            return result;
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
            }).ToList();
            return result;
        }

        public IEnumerable<TimesheetScheduledResponse> GetTimesheetScheduledForUser(string userId, DateTime startTime, DateTime endTime)
        {
            var timesheetScheduledEntities = timesheetRegistrationRepository.GetByUserIdAndTimeRange(userId, startTime, endTime).ToList();
            var dataResult = new List<TimesheetScheduledResponse>();
            for(int i = 0; i < timesheetScheduledEntities.Count; ++i)
            {
                var timesheetScheduledEntity = timesheetScheduledEntities[i];
                var (start, end) = ExtractTheData(timesheetScheduledEntity.TimeSheet.TimeRange, timesheetScheduledEntity.Date!.Value);
                dataResult.Add(new TimesheetScheduledResponse()
                {
                    Id = timesheetScheduledEntity.Id,
                    IntId = i,
                    TimesheetName = timesheetScheduledEntity.TimeSheet.Name,
                    Start = start,
                    End = end,
                });
            }

            return dataResult;
        }

        public IEnumerable<AttendanceCheckDTO> GetTimesheetCheckDataBySpecifiedTime(string userId, DateTime time)
        {
            var timesheetRegistrationEntities = timesheetRegistrationRepository.GetByUserIdAndTimeRange(userId, time.Date, time.AddYears(10)).ToList();
            var resultData = new List<AttendanceCheckDTO>();
            foreach(var timesheetRegistrationEntity in timesheetRegistrationEntities)
            {
                var (startTime, endTime) = ExtractTheData(timesheetRegistrationEntity.TimeSheet.TimeRange, timesheetRegistrationEntity.Date!.Value);
                var checkEntity = timesheetCheckRepository.GetByRegistrationId(timesheetRegistrationEntity.Id);
                if (startTime.AddMinutes(SOON_ACCEPTED_IN_MINUTE * (-1)) <= time && endTime.AddMinutes(LATE_ACCEPTED_IN_MINUTE) >= time)
                {
                    resultData.Add(new AttendanceCheckDTO()
                    {
                        UserId = timesheetRegistrationEntity.UserId,
                        Salary = timesheetRegistrationEntity.Salary,
                        RegistrationId = timesheetRegistrationEntity.Id,
                        StartTime = startTime,
                        EndTime = endTime,
                        TimeSheet = timesheetRegistrationEntity.TimeSheet,
                        IsChecked = checkEntity != null,
                        CheckId = checkEntity?.Id,
                        CheckData = checkEntity,
                    });
                }
            }
            return resultData;
        }

        public void CheckAttendance(string registrationId, string userId)
        {
            var registrationEntity = timesheetRegistrationRepository.GetById(registrationId) ?? throw new Exception("Registration entity not existed");
            if(registrationEntity.UserId != userId)
            {
                throw new Exception("The registration is not scheduled for this user");
            }

            var checkEntity = new TimeSheetCheck()
            {
                CheckedAt = DateTime.Now,
                CoefficientAmount = registrationEntity.TimeSheet.CoefficientAmount,
                TimeSheetRegistrationId = registrationId,
                UserId = userId,
                Note = "",
            };
            timesheetCheckRepository.Save(checkEntity);
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
    }
}
