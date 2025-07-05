using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SprintoApi.Data;
using SprintoApi.Models;

namespace SprintoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly SprintoDbContext dbContext;
        public LoginController(SprintoDbContext dbContext)
        {
            this.dbContext = dbContext;
        }
        [HttpPost]
        [Route("addUser")]
        public IActionResult addUser(UsersDto usersDto)
        {
            Users newUser = new Users { user_name = usersDto.userName, password = usersDto.password };
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
        [Route("Login")]
        public IActionResult Login(UsersDto usersDto)
        {
            var user = dbContext.users.FirstOrDefault(u => u.user_name == usersDto.userName && u.password == usersDto.password);

            if (user == null)
            {
                return Unauthorized("Invalid username or password");
            }

            return Ok(user);
        }
    }
}
