using Microsoft.EntityFrameworkCore;
using TodoApi;
using TodoApi.Data;
using TodoApi.Services;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddTransient<ITodoService, TodoService>();
builder.Services.AddDbContext<TodoGroupDbContext>(options =>
{
    var folder = Environment.SpecialFolder.LocalApplicationData;
    var path = Environment.GetFolderPath(folder);
    var DbPath = System.IO.Path.Join(path, "TodoApi.sqlite");
    options.UseSqlite($"Data Source={DbPath}");
});

var app = builder.Build();
using var scope = app.Services.CreateScope();

var db = scope.ServiceProvider.GetService<TodoGroupDbContext>();
db?.Database.MigrateAsync();

// todoV1 endpoints
app.MapGroup("/todos/v1")
    .MapTodosApiV1()
    .WithTags("Todo Endpoints");

app.Run();

public partial class Program
{ }
