using Microsoft.EntityFrameworkCore;
using SprintoApi.Models;

namespace SprintoApi.Data
{
    public class SprintoDbContext : DbContext
    {
        public SprintoDbContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Users> users { get; set; }
        public DbSet<Projects> projects { get; set; }
        public DbSet<Tasks> tasks { get; set; }
    }
}
