using System.ComponentModel.DataAnnotations;

namespace SprintoApi.Models
{
    public class Users
    {
        [Key]
        public int id { get; set; }
        public string user_name { get; set; }
        public string password { get; set; }

    }

    public class UsersDto
    {
       
        public string userName { get; set; }
        public string password { get; set; }

    }
}
