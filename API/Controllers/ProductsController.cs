using BusinessObject.Models;
using DataAccess.ProductRepository;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/products")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly IProductRepository productRepository;

        public ProductsController(IProductRepository productRepository)
        {
            this.productRepository = productRepository;
        }

        // GET: api/products
        [HttpGet]
        public IEnumerable<Product> Get()
        {
            return productRepository.GetAll();
        }

        // GET api/products/5
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var product = productRepository.GetById(id);
            if(product == null)
            {
                return NotFound();
            }

            return Ok(product);
        }

        // POST api/products
        [HttpPost]
        public IActionResult Post([FromBody] Product product)
        {
            productRepository.Save(product);
            return Ok();
        }

        // PUT api/products/5
        [HttpPut("{id}")]
        public IActionResult Put(int id, [FromBody] Product product)
        {
            if(product.Id != id)
            {
                return BadRequest("Product is not match");
            }
            productRepository.Update(product);
            return Ok();
        }

        // DELETE api/products/5
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            var product = productRepository.GetById(id);
            if(product == null)
            {
                return NotFound();
            }

            productRepository.DeleteById(id);
            return Ok();
        }
    }
}
