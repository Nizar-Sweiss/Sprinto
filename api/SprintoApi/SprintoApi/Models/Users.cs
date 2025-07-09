using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SprintoApi.Models
{
    public class Users
    {
        [Key]
        public int id { get; set; }
        public string user_name { get; set; }
        public string password { get; set; }
        [NotMapped]
        public string token  { get; set; }

    }

    public class UsersDto
    {
       
        public string userName { get; set; }
        public string password { get; set; }

    }
}
