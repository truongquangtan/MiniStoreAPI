using System.Text;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using DataAccess.UserRepository;
using BusinessObject.Models;

namespace API.Supporters.JwtAuthSupport
{
    public class JwtTokenSupporter
    {
        IConfiguration config;
        IUserRepository userRepository;

        public JwtTokenSupporter(IConfiguration config, IUserRepository userRepo)
        {
            this.config = config;
            userRepository = userRepo;
        }

        public string CreateToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(config["jwt:Key"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", user.Id) }),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public User? ValidateToken(string token)
        {
            try
            {
                 var tokenHandler = new JwtSecurityTokenHandler();
                 var key = Encoding.ASCII.GetBytes(config["jwt:Key"]);
                 tokenHandler.ValidateToken(token, new TokenValidationParameters
                 {
                     ValidateIssuerSigningKey = true,
                     IssuerSigningKey = new SymmetricSecurityKey(key),
                     ValidateIssuer = false,
                     ValidateAudience = false,
                     ValidateLifetime = false
                 }, out SecurityToken validatedToken);

                 var jwtToken = (JwtSecurityToken)validatedToken;
                 var userId = jwtToken.Claims.First(claim => claim.Type == "id").Value;

                var user = userRepository.GetById(userId);
                if(user == null || user.IsLogout.Value)
                {
                    return null;
                }
                return userRepository.GetById(userId);
            } catch (Exception)
            {
                return null;
            }
        }
        public User? ExtractUserFromRequestToken(HttpContext context)
        {
            var token = context.Request.Headers.Authorization.ToString().Split(" ").Last();
            if (token == null)
            {
                return null;
            }
            return ValidateToken(token);
        }
    }
}
