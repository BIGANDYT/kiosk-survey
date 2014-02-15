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

            // Grabs the context from the requesting session
            HttpContext context = HttpContext.Current;

            // Works on the current domain name minus http:// etc.
            var incomingDomain = context.Request.Url.DnsSafeHost.ToString();
            var detectedRegion = incomingDomain.Split('.')[0];
           
            // returns a split of the region, if no specific region it just returns "survey" in the reports.
            return detectedRegion;
        }


    }
}