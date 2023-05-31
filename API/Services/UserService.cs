using API.Constants;
using API.DTOs;
using API.DTOs.Request;
using API.Supporters.JwtAuthSupport;
using BLL.Services;
using BusinessObject.Models;
using DataAccess.UserRepository;
using DTO.Constants;
using System.Text.RegularExpressions;

namespace API.Services
{
    public class UserService
    {
        private readonly IUserRepository userRepository;
        private readonly JwtTokenSupporter jwtTokenSupporter;
        private readonly FirebaseService firebaseService;
        private readonly IConfiguration configuration;
        public UserService(IUserRepository userRepository, JwtTokenSupporter jwtTokenSupporter, FirebaseService firebaseService, IConfiguration configuration)
        {
            this.userRepository = userRepository;
            this.jwtTokenSupporter = jwtTokenSupporter;
            this.firebaseService = firebaseService;
            this.configuration = configuration;
        }
        public User? GetById(string id)
        {
            return userRepository.GetById(id);
        }

        public string? Login(string email, string password)
        {
            var user = userRepository.GetByEmailAndPassword(email, password);
            if (user != null)
            {
                if (IsUserAlreadyLogin(user))
                {
                    return user.Token;
                }

                var token = jwtTokenSupporter.CreateToken(user);
                UpdateTokenForUser(user, token);
                return token;
            }
            return null;
        }
        private static bool IsUserAlreadyLogin(User user)
        {
            return user.IsLogout != null && user.IsLogout == false;
        }
        private void UpdateTokenForUser(User user, string token)
        {
            user.Token = token;
            user.IsLogout = false;
            userRepository.Update(user);
        }
        public void Logout(User user)
        {
            user.IsLogout = true;
            userRepository.Update(user);
        }
        public async Task<User?> CreateUser(CreateAccountRequest request)
        {
            TryValidateRegisterRequest(request);

            string imageUrl;
            if (request.Avatar != null)
            {
                var imageName = request.Fullname + "-" + Guid.NewGuid().ToString();
                imageUrl = await firebaseService.Upload(request.Avatar.OpenReadStream(), imageName);
            } else
            {
                imageUrl = configuration["firebase:defaultAvatar"]!;
            }

            var user = new User()
            {
                Address = request.Address,
                Avatar = imageUrl,
                Dob = request.Dob,
                Email = request.Email,
                Fullname = request.Fullname,
                Password = request.Password,
                Phone = request.Phone,
                RoleId = request.RoleId
            };

            var userCreated = userRepository.Save(user);
            return userCreated;
        }
        
        private void TryValidateRegisterRequest(CreateAccountRequest request)
        {
            if (new Regex(RegexCollector.PhoneRegex).IsMatch(request.Phone) == false)
            {
                throw new Exception("Phone is not a valid phone");
            }
            if (new Regex(RegexCollector.EmailRegex).IsMatch(request.Email) == false)
            {
                throw new Exception("Email is not valid.");
            }

            if (string.IsNullOrEmpty(request.Fullname))
            {
                throw new Exception("Fullname must not be null or empty");
            }
            if (string.IsNullOrEmpty(request.Address))
            {
                throw new Exception("Address must not be null or empty");
            }

            if(request.RoleId == RoleConstant.MANAGER)
            {
                throw new Exception("Cannot create manager-role account");
            }
        }
        public async Task UpdateUser(string userId, UpdateUserRequest request)
        {
            var user = userRepository.GetById(userId) ?? throw new Exception("User not existed");
            if(request.RoleId == RoleConstant.MANAGER)
            {
                throw new Exception("Cannot change to manager role");
            }

            if(request.Avatar != null)
            {
                var imageName = request.Fullname + "-" + Guid.NewGuid().ToString();
                if (user.Avatar != configuration["firebase:defaultAvatar"])
                {
                    firebaseService.Delete(user.Avatar);
                }
                var imageUrl = await firebaseService.Upload(request.Avatar.OpenReadStream(), imageName);
                user.Avatar = imageUrl;
            }

            user.Address = request.Address ?? user.Address;
            user.Dob = request.Dob ?? user.Dob;
            user.Phone = request.Phone ?? user.Phone;
            user.Fullname = request.Fullname ?? user.Fullname;
            user.RoleId = request.RoleId;

            userRepository.Update(user);
        }
    }
}
