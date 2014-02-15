using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website.code
{
    public class MultiRegion
    {
       

        public static string GetRegion(){

            HttpContext context = HttpContext.Current;

            var incomingDomain = context.Request.Url.DnsSafeHost.ToString();
            var detectedRegion = incomingDomain.Split('.')[0];
           
            return detectedRegion;
        }


    }
}