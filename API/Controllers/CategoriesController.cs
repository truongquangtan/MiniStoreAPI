using BusinessObject.Models;
using DataAccess.CategoryRepository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/categories")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ICategoryRepository categoryRepository;

        public CategoriesController(ICategoryRepository categoryRepository)
        {
            this.categoryRepository = categoryRepository;
        }

        [HttpGet]
        public IEnumerable<Category> Get()
        {
            return categoryRepository.GetAll();
        }

        [HttpPost]
        public IActionResult Post([FromBody] Category category)
        {
            var categorySaved = categoryRepository.Save(category);
            return Ok(categorySaved);
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            categoryRepository.Delete(id);
            return NoContent();
        }
    }
}
