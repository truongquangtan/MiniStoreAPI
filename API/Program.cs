using API.Services;
using API.Supporters;
using API.Supporters.JwtAuthSupport;
using BLL.Services;
using DataAccess.CategoryRepository;
using DataAccess.OrderDetailRepository;
using DataAccess.OrderRepository;
using DataAccess.ProductRepository;
using DataAccess.RoleRepository;
using DataAccess.TimesheetCheckRepository;
using DataAccess.TimeSheetRegistrationRefRepository;
using DataAccess.TimeSheetRegistrationRepository;
using DataAccess.TimesheetRepository;
using DataAccess.UserRepository;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("allow", policy => { policy.AllowAnyHeader().AllowAnyOrigin().AllowAnyMethod(); });
});

builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IRoleRepository, RoleRepository>();
builder.Services.AddScoped<ICategoryRepository, CategoryRepository>();
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IOrderRepository, OrderRepository>();
builder.Services.AddScoped<IOrderDetailRepository, OrderDetailRepository>();
builder.Services.AddScoped<ITimesheetRepository, TimesheetRepository>();
builder.Services.AddScoped<ITimesheetRegistrationRefRepository, TimesheetRegistrationRefRepository>();
builder.Services.AddScoped<ITimesheetRegistrationRepository, TimesheetRegistrationRepository>();
builder.Services.AddScoped<ITimesheetCheckRepository, TimesheetCheckRepository>();

builder.Services.AddScoped<FirebaseService, FirebaseService>();
builder.Services.AddScoped<JwtTokenSupporter, JwtTokenSupporter>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<WorksheetService>();

builder.Services.AddHttpClient();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("allow");

app.UseAuthorization();

app.UseMiddleware<JWTAuthenticationMiddleware>();

app.MapControllers();

app.Run();
