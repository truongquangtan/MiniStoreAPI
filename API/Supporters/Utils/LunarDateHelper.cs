using System.Globalization;

namespace API.Supporters.Utils
{
    public static class LunarDateHelper
    {
        public static DateTime ConvertLunarDateToSolarDateTime(int year, int month, int day)
        {
            ChineseLunisolarCalendar chineseLunisolarCalendar = new();
            return chineseLunisolarCalendar.ToDateTime(year, month, day, 1, 0, 0, 0);
        }
    }
}
