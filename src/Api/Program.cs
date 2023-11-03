using EFCore.NamingConventions.Internal;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using TodoApi;
using TodoApi.Data;
using TodoApi.Services;

var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING");
var builder = WebApplication.CreateBuilder(args);

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks();

builder.Services.AddTransient<ITodoService, TodoService>();
builder.Services.AddDbContext<TodoGroupDbContext>(options =>
    options.UseNpgsql(connectionString));
//    options.UseNpgsql(connectionString).UseSnakeCaseNamingConvention());

builder.Services.AddCors(options =>
{
  options.AddPolicy(
      name: "AllowAll",
      policy =>
      {
          policy
              .AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
      });
});

var app = builder.Build();
app.MapHealthChecks("/healthz", new HealthCheckOptions
{
    AllowCachingResponses = false
});

if (app.Environment.IsDevelopment())
{
  app.UseDeveloperExceptionPage();
  app.UseSwagger();
  app.UseSwaggerUI();
}
app.UseCors("AllowAll");

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
