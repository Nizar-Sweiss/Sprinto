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


        [HttpPost]
        [Route("updateTaskStatus")]
        public IActionResult UpdateTaskStatus([FromBody] UpdateTaskStatusRequest request)
        {
            var task = dbContext.tasks.FirstOrDefault(t => t.id == request.Id);
            if (task == null) return NotFound("Task not found.");

            task.status = request.Status;
            dbContext.SaveChanges();

            return Ok(task);
        }
        [HttpPost]
        [Route("editTask")]
        public IActionResult EditTask([FromBody] Tasks request)
        {
            var task = dbContext.tasks.FirstOrDefault(t => t.id == request.id);
            if (task == null) return NotFound("Task not found.");

            task.title = request.title;
            task.Description = request.Description;
            task.status = request.status;
            task.due_date = request.due_date;
            dbContext.SaveChanges();

            return Ok(task);
        }

        [HttpPost]
        [Route("deleteTask")]
        public IActionResult DeleteTask([FromBody] TasksDto request)
        {
            var task = dbContext.tasks.FirstOrDefault(t => t.id == request.id && t.project_id == request.project_id);
            if (task == null) return NotFound("Task not found.");

            dbContext.tasks.Remove(task);
            dbContext.SaveChanges();

            return Ok(new { message = "Task deleted successfully." });
        }



    }
}
