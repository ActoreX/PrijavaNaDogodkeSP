using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EventiqonWebApp.Startup))]
namespace EventiqonWebApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
