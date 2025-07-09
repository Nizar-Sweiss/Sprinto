using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SprintoApi.Data;
using SprintoApi.Models;
using SprintoApi.Services; // Import the JWT service

namespace SprintoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly SprintoDbContext dbContext;
        private readonly JwtTokenService _jwtTokenService;  // Inject JWT Token Service

        public LoginController(SprintoDbContext dbContext, JwtTokenService jwtTokenService)
        {
            this.dbContext = dbContext;
            _jwtTokenService = jwtTokenService;
        }

        [HttpPost]
        [Route("addUser")]
        public IActionResult addUser(UsersDto usersDto)
        {
            Users newUser = new Users
            {
                user_name = usersDto.userName,
                password = usersDto.password
            };
            dbContext.users.Add(newUser);
            dbContext.SaveChanges();

            return Ok(newUser);
        }

      
        [HttpGet]
        [Route("getAllUser")]
        public IActionResult getAllUser()
        {
            List<Users> allUsers = dbContext.users.ToList();
            return Ok(allUsers);
        }


        [HttpPost]
        [Route("login")]
        public IActionResult Login(UsersDto usersDto)
        {
            var user = dbContext.users
                .FirstOrDefault(u => u.user_name == usersDto.userName && u.password == usersDto.password);

            if (user == null)
            {
                return Unauthorized("Invalid username or password");
            }

            // ✅ Generate JWT Token for the logged-in user
            var token = _jwtTokenService.GenerateToken(user.user_name, user.id);
            user.token = token;
            return Ok(user);
        }
    }
}
