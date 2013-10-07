using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Website.model
{
    public class Survey : System.Web.UI.UserControl
    {
        public Sitecore.Data.Items.Item CurrentUser { get; set; }
        public Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");


        public void SetCurrentUser()
        {
            String currentUserId = Sitecore.Context.ClientData.GetValue("CurrentUser").ToString();
            if (String.IsNullOrEmpty(currentUserId))
            {
                // possbile session timeout so redirect to the start
                Response.Redirect(Sitecore.Context.Site.StartPath);
            }
            else
            {
                CurrentUser = master.GetItem(currentUserId);
            }
        }

        public void Restart()
        {
              Sitecore.Context.ClientData.RemoveAll();
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }
    }
}