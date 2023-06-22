using API.DTOs.Request;
using BLL.Services;
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
        private readonly FirebaseService firebaseService;
        private readonly IConfiguration configuration;

        public ProductsController(IProductRepository productRepository, FirebaseService firebaseService, IConfiguration configuration)
        {
            this.productRepository = productRepository;
            this.firebaseService = firebaseService;
            this.configuration = configuration;
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
        public async Task<IActionResult> Post([FromForm] ProductDTO product)
        {
            // upload image
            string imageUrl;
            if(product.Image == null)
            {
                imageUrl = configuration["defaultItemImage"]!;
            }
            else
            {
                var imageName = product.Name + " " + Guid.NewGuid().ToString();
                imageUrl = await firebaseService.Upload(product.Image.OpenReadStream(), imageName);
            }

            var entity = new Product()
            {
                CategoryId = product.CategoryId,
                Description = product.Description,
                Name = product.Name,
                Price = product.Price,
                Quantity = product.Quantity,
                Source = product.Source,
            };
            var productSaved = productRepository.Save(entity);
            productRepository.AddImageToProduct(productSaved!.Id, imageUrl);
            return Ok();
        }

        // PUT api/products/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromForm] ProductDTO product)
        {
            var productEntity = productRepository.GetById(id);
            if(productEntity == null)
            {
                return BadRequest("Product not found");
            }

            // Update other field
            productEntity.Source = product.Source;
            productEntity.Price = product.Price;
            productEntity.Quantity = product.Quantity;
            productEntity.CategoryId = product.CategoryId;
            productEntity.Description = product.Description;
            productEntity.Name = product.Name;

            productRepository.Update(productEntity);

            // Update image field
            try 
            {
                if (product.Image != null)
                {
                    //Delete previous images
                    foreach (var image in productEntity.ProductImages)
                    {
                        firebaseService.Delete(image.Image[7..]);
                    }
                    productRepository.DeleteAllImagesOfProduct(id);
                    //Add new image
                    var imageName = product.Name + " " + Guid.NewGuid().ToString();
                    var imageUrl = await firebaseService.Upload(product.Image.OpenReadStream(), imageName);
                    productRepository.AddImageToProduct(id, imageUrl);
                }
            }
            finally
            {
                return Ok();
            }
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
