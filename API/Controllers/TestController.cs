using BLL.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/test")]
    [ApiController]
    public class TestController : ControllerBase
    {
        private readonly FirebaseService firebaseService;
        public TestController(FirebaseService firebaseService)
        {
            this.firebaseService = firebaseService;
        }
        [HttpPost("firebase")]
        public async Task<IActionResult> TestFirebase(IFormFile anh)
        {
            await firebaseService.Upload(anh.OpenReadStream(), "anh");
            return Ok();
        }
    }
}
