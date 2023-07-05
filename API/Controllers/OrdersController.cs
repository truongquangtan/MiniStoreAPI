using API.DTOs;
using API.Services;
using API.Supporters.JwtAuthSupport;
using BusinessObject.Models;
using DataAccess.OrderRepository;
using DataAccess.ProductRepository;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/orders")]
    [ApiController]
    [AuthorizeExceptGuard]
    public class OrdersController : ControllerBase
    {
        private readonly IOrderRepository orderRepository;
        private readonly IProductRepository productRepository;

        public OrdersController(IOrderRepository orderRepository, IProductRepository productRepository)
        {
            this.orderRepository = orderRepository;
            this.productRepository = productRepository;
        }

        [HttpGet]
        public IEnumerable<Order> Get()
        {
            return orderRepository.GetAll();
        }

        // GET api/orders/uid-uid-uid-uid
        [HttpGet("{id}")]
        public IActionResult Get(string id)
        {
            var order = orderRepository.GetById(id);
            if(order == null)
            {
                return NotFound();
            }

            return Ok(order);
        }

        // POST api/orders
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Order order)
        {
            var user = HttpContext.Items["User"] as User;
            order.UserId = user!.Id;
            try
            {
                var orderInfo = await orderRepository.SaveOrderWithTransaction(order);
                return Ok(orderInfo);
            }
            catch (OrderProcessException orderProcessException)
            {
                if(orderProcessException.ProductId != -1)
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                        Product = productRepository.GetById(orderProcessException.ProductId)
                    });
                } else
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                    });
                }
            }
        }

        // PUT api/orders/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(string id, [FromBody] Order order)
        {
            if(id != order.Id)
            {
                return BadRequest(new
                {
                    Error = "Order is not match"
                });
            }

            try
            {
                await orderRepository.UpdateOrderWithTransaction(order);
                return Ok();
            }
            catch (OrderProcessException orderProcessException)
            {
                if (orderProcessException.ProductId != -1)
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                        Product = productRepository.GetById(orderProcessException.ProductId)
                    });
                }
                else
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                    });
                }
            }
        }

        // DELETE api/orders/uid-uid-uid-uid
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(string id)
        {
            try
            {
                await orderRepository.DeleteOrderWithTransaction(id);
                return Ok();
            }
            catch (OrderProcessException orderProcessException)
            {
                if (orderProcessException.ProductId != -1)
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                        Product = productRepository.GetById(orderProcessException.ProductId)
                    });
                }
                else
                {
                    return BadRequest(new
                    {
                        Error = orderProcessException.Message,
                    });
                }
            }
        }
    }
}
