using Microsoft.EntityFrameworkCore;
using TodoApi.Data;

namespace TodoApi.Services;

public class TodoService : ITodoService
{
    private readonly TodoGroupDbContext _dbContext;

    public TodoService(TodoGroupDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async ValueTask<Todo?> Find(int id)
    {
        return await _dbContext.Todos.FindAsync(id);
    }

    public async Task<List<Todo>> GetAll()
    {
        return await _dbContext.Todos.ToListAsync();
    }

    public async Task Add(Todo todo)
    {
        await _dbContext.Todos.AddAsync(todo);

        if (await _dbContext.SaveChangesAsync() > 0)
          Console.WriteLine($"New todo has been added: {todo.Title}");
    }

    public async Task Update(Todo todo)
    {
        _dbContext.Todos.Update(todo);
        await _dbContext.SaveChangesAsync();
    }

    public async Task Remove(Todo todo)
    {
        _dbContext.Todos.Remove(todo);
        await _dbContext.SaveChangesAsync();
    }

    public Task<List<Todo>> GetIncompleteTodos()
    {
        return _dbContext.Todos.Where(t => t.IsDone == false).ToListAsync();
    }
}
