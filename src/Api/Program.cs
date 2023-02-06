using Microsoft.EntityFrameworkCore;
using TodoApi;
using TodoApi.Data;
using TodoApi.Services;

var builder = WebApplication.CreateBuilder(args);

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddTransient<ITodoService, TodoService>();
builder.Services.AddDbContext<TodoGroupDbContext>(options =>
{
  var pgDbname = Environment.GetEnvironmentVariable("PG_DBNAME");
  var pgHost = Environment.GetEnvironmentVariable("PG_HOST");
  var pgUser = Environment.GetEnvironmentVariable("PG_USER");
  var pgPassword = Environment.GetEnvironmentVariable("PG_PASSWORD");
  options.UseNpgsql($"Host={pgHost};Database={pgDbname};Username={pgUser};Password={pgPassword}");
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
  app.UseDeveloperExceptionPage();
  app.UseSwagger();
  app.UseSwaggerUI();
}

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
