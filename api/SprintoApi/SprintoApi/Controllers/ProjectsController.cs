using Microsoft.AspNetCore.Mvc;
using SprintoApi.Data;
using SprintoApi.Models;

namespace SprintoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectsController : ControllerBase
    {
        private readonly SprintoDbContext dbContext;
        public ProjectsController(SprintoDbContext dbContext)
        {
            this.dbContext = dbContext;
        }
        [HttpPost]
        [Route("getUserProjects")]
        public IActionResult getUserProjects(ProjectsDto projectsDto)
        {
            List<Projects> projects = dbContext.projects.ToList().Where(e => e.created_by == projectsDto.created_by).ToList();

            return Ok(projects);

        }

        [HttpPost]
        [Route("addProject")]
        public IActionResult addProjectd(Projects project)
        {
            Projects newproject = new Projects { created_by = project.created_by, created_date = DateTime.Now, description = project.description, title = project.title };
            dbContext.projects.Add(newproject);
            dbContext.SaveChanges();

            return Ok(newproject);

        }

        [HttpPost]
        [Route("editProject")]
        public IActionResult EditProject([FromBody] Projects project)
        {
            var existingProject = dbContext.projects.FirstOrDefault(p => p.id == project.id);
            if (existingProject == null)
            {
                return NotFound("Project not found");
            }

            existingProject.title = project.title;
            existingProject.description = project.description;

            dbContext.SaveChanges();

            return Ok(existingProject);
        }
    }
}
