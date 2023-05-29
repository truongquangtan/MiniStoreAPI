using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API.DTOs.Response
{
    public class ResponseMessage
    {
        public string? Message { get; set; }
        public object? Data { get; set; }
    }
}
