using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO.Constants
{
    public static class RegexCollector
    {
        public const string EmailRegex = "^.*@.+$";
        public const string PhoneRegex = "^[0-9]{10}$";
    }
}
