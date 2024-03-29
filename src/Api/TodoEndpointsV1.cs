using Microsoft.EntityFrameworkCore;
using TodoApi.Data;

namespace TodoApi;

public static class TodoEndpointsV1
{
    public static RouteGroupBuilder MapTodosApiV1(this RouteGroupBuilder group)
    {
        group.MapGet("/", GetAllTodos);
        group.MapGet("/{id}", GetTodo);
        group.MapPost("/", CreateTodo)
            .AddEndpointFilter(async (efiContext, next) =>
            {
                var param = efiContext.GetArgument<TodoDto>(0);
                var validationErrors = Utilities.IsValid(param);

                if (validationErrors.Any())
                {
                    return Results.ValidationProblem(validationErrors);
                }

                return await next(efiContext);
            });

        group.MapPut("/{id}", UpdateTodo);
        group.MapDelete("/{id}", DeleteTodo);
        return group;
    }

    public static async Task<IResult> GetAllTodos(TodoGroupDbContext database)
    {
        var todos = await database.Todos.ToListAsync();
        return TypedResults.Ok(todos);
    }

    public static async Task<IResult> GetTodo(int id, TodoGroupDbContext database)
    {
        var todo = await database.Todos.FindAsync(id);

        if (todo != null)
        {
            return TypedResults.Ok(todo);
        }

        return TypedResults.NotFound();
    }

    public static async Task<IResult> CreateTodo(TodoDto todo, TodoGroupDbContext database)
    {
        var newTodo = new Todo
        {
            Title = todo.Title,
            Description = todo.Description,
            IsDone = todo.IsDone
        };

        await database.Todos.AddAsync(newTodo);
        await database.SaveChangesAsync();
        return TypedResults.Created($"/todos/v1/{newTodo.Id}", newTodo);
    }

    public static async Task<IResult> UpdateTodo(Todo todo, TodoGroupDbContext database)
    {
        var existingTodo = await database.Todos.FindAsync(todo.Id);

        if (existingTodo != null)
        {
            existingTodo.Title = todo.Title;
            existingTodo.Description = todo.Description;
            existingTodo.IsDone = todo.IsDone;

            await database.SaveChangesAsync();
            return TypedResults.Created($"/todos/v1/{existingTodo.Id}", existingTodo);
        }
        return TypedResults.NotFound();
    }

    public static async Task<IResult> DeleteTodo(int id, TodoGroupDbContext database)
    {
        var todo = await database.Todos.FindAsync(id);

        if (todo != null)
        {
            database.Todos.Remove(todo);
            await database.SaveChangesAsync();

            return TypedResults.NoContent();
        }
        return TypedResults.NotFound();
    }
}
