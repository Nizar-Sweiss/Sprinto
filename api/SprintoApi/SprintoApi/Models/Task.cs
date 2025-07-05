using System.ComponentModel.DataAnnotations;

namespace SprintoApi.Models
{
    public class Tasks
    {
        [Key]
        public int id { get; set; }
        public int project_id { get; set; }
        public string Description { get; set; }
        public string title { get; set; }
        public int status { get; set; }
        public DateTime due_date { get; set; }
        public int created_by { get; set; }
        public DateTime created_date { get; set; }

    }

    public class TasksDto
    {
        public int id { get; set; }
        public int project_id { get; set; }
        

    }

    public class UpdateTaskStatusRequest
    {
        public int Id { get; set; }
        public int Status { get; set; }
    }
}
