using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using System.Web.SessionState;

namespace TaskManagement
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
    public class AdminFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            
            if (filterContext.HttpContext.Session["Username"] == null || filterContext.HttpContext.Session["Username"].ToString() != "Admin")
            {
                var request = HttpContext.Current.Request;
                var appUrl = HttpRuntime.AppDomainAppVirtualPath;
                var baseUrl = string.Format("{0}://{1}{2}", request.Url.Scheme, request.Url.Authority, appUrl);
                filterContext.HttpContext.Response.Redirect(baseUrl);
                
            }

        }
    }
    public class PJManagerFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session["Username"] == null)
            {
                var request = HttpContext.Current.Request;
                var appUrl = HttpRuntime.AppDomainAppVirtualPath;
                var baseUrl = string.Format("{0}://{1}{2}", request.Url.Scheme, request.Url.Authority, appUrl);
                filterContext.HttpContext.Response.Redirect(baseUrl);
            }

        }
    }
}