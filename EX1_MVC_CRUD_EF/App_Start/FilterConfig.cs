using System.Web;
using System.Web.Mvc;

namespace EX1_MVC_CRUD_EF
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
