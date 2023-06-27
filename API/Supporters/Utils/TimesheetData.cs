using API.DTOs;
using Microsoft.Extensions.Configuration;

namespace API.Supporters.Utils
{
    public class TimesheetData
    {
        public IEnumerable<HolidayDTO> Holidays { get; set; }
        public decimal UnitSalary { get; set; }
        public CoefficientRule CoefficientRule { get; set; }

        private static TimesheetData _instance;
        private static readonly object _instanceLock = new();

        private TimesheetData()
        {
            
        }
        public static TimesheetData GetInstance()
        {
            if(_instance == null)
            {
                lock(_instanceLock)
                {
                    _instance ??= new TimesheetData() { Holidays = GetHolidays(), UnitSalary = GetUnitSalary(), CoefficientRule = GetCoefficientRule() };
                }
            }

            return _instance;
        }

        private static IEnumerable<HolidayDTO> GetHolidays()
        {
            var builder = new ConfigurationBuilder()
           .SetBasePath(Directory.GetCurrentDirectory())
           .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
            var configuration = builder.Build();

            IEnumerable<HolidayDTO> result = new List<HolidayDTO>();

            var year = DateTime.Now.Year;
            var solarHolidays = configuration.GetSection("holidays:solar").Get<List<HolidayInConfig>>();
            var lunarHolidays = configuration.GetSection("holidays:lunar").Get<List<HolidayInConfig>>();

            foreach (var holiday in solarHolidays!)
            {
                DateTime date = new(year: year, month: holiday.Month, day: holiday.Day);
                result = result.Append(new HolidayDTO()
                {
                    Date = date,
                    Name = holiday.Name,
                });
            }

            foreach (var holiday in lunarHolidays!)
            {

                DateTime date;
                if (holiday.Day == 30 && holiday.Month == 12)
                {
                    date = LunarDateHelper.ConvertLunarDateToSolarDateTime(year - 1, holiday.Month, holiday.Day);
                }
                else
                {
                    date = LunarDateHelper.ConvertLunarDateToSolarDateTime(year, holiday.Month, holiday.Day);
                }
                result = result.Append(new HolidayDTO()
                {
                    Date = date,
                    Name = holiday.Name,
                });
            }

            return result;
        }
        private static decimal GetUnitSalary()
        {
            var builder = new ConfigurationBuilder()
           .SetBasePath(Directory.GetCurrentDirectory())
           .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
            var configuration = builder.Build();

            var result = configuration.GetSection("worksheet:unitSalary").Get<decimal>();
            return result;
        }

        private static CoefficientRule GetCoefficientRule()
        {
            var builder = new ConfigurationBuilder()
           .SetBasePath(Directory.GetCurrentDirectory())
           .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
            var configuration = builder.Build();

            var result = configuration.GetSection("worksheet:coefficientRule").Get<CoefficientRule>();
            return result;
        }
    }
}
