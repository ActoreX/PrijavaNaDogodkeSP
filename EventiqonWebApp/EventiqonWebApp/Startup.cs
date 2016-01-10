using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Owin;

[assembly: OwinStartupAttribute(typeof(EventiqonWebApp.Startup))]
namespace EventiqonWebApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //ConfigureAuth(app);
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = "EventiqonApplicationCookie",
                LoginPath = new PathString("/Account/Login")
            });
        }
    }
}
