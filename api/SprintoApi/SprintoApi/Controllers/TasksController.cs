using Microsoft.AspNetCore.Mvc;
using SprintoApi.Data;
using SprintoApi.Models;

namespace SprintoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TasksController : ControllerBase
    {
        private readonly SprintoDbContext dbContext;
        public TasksController(SprintoDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpPost]
        [Route("getProjectTasks")]
        public IActionResult GetProjectTasks([FromBody] TasksDto tasksDto)
        {
            var tasks = dbContext.tasks
                .Where(t => t.project_id == tasksDto.project_id)
                .ToList();

            return Ok(tasks);
        }
        [HttpPost]
        [Route("addTask")]
        public IActionResult AddTask([FromBody] Tasks task)
        {
            if (task == null)
            {
                return BadRequest("Invalid task data");
            }

            task.created_date = DateTime.Now;

            dbContext.tasks.Add(task);
            dbContext.SaveChanges();

            return Ok(task);
        }



    }
}
