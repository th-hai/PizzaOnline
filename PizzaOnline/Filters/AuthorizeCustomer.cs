using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PizzaOnline.Filters
{
    public class AuthorizeCustomer : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (HttpContext.Current.Session["CustomerID"] == null)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary
                {
                    {"Controller", "Home"},
                    {"Action", "Login"}
                });
            }
            base.OnActionExecuting(filterContext);
        }
    }
}