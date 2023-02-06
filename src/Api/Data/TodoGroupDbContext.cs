using Microsoft.EntityFrameworkCore;

namespace TodoApi.Data;

public class TodoGroupDbContext : DbContext
{
    public DbSet<Todo> Todos => Set<Todo>();

    public TodoGroupDbContext(DbContextOptions<TodoGroupDbContext> options)
        : base(options)
    {
    }
}
