using DataAccess.UserRepository;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;

namespace API.Supporters
{
    public class JWTAuthenticationMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IConfiguration configuration;

        public JWTAuthenticationMiddleware(RequestDelegate next, IConfiguration config)
        {
            _next = next;
            configuration = config;
        }

        public async Task Invoke(HttpContext context, IUserRepository userRepository)
        {
            var token = context.Request.Headers.Authorization.ToString().Split(" ").Last();

            if(token != null)
            {
                AttachUserToContext(context, userRepository, token);
            }
            await _next(context);
        }
        private void AttachUserToContext(HttpContext context, IUserRepository userRepository, string token)
        {
            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(configuration["jwt:Key"]);
                tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ClockSkew = TimeSpan.Zero
                }, out SecurityToken validatedToken);

                var jwtToken = (JwtSecurityToken) validatedToken;
                var userId = jwtToken.Claims.First(claim => claim.Type == "id").Value;

                var user = userRepository.GetById(userId);
                context.Items["User"] = user;
                context.Items["Role"] = user!.RoleId;
            }
            catch (Exception ex)
            {

            }
        }
    }
}
