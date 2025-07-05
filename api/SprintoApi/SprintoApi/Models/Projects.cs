using System.ComponentModel.DataAnnotations;

namespace SprintoApi.Models
{
    public class Projects
    {
        [Key]
        public int id { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public DateTime created_date { get; set; }
        public int created_by { get; set; }

    }
    public class ProjectsDto
    {
        public int created_by { get; set; }

    }

}
