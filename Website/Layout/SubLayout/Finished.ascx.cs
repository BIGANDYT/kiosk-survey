using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;

namespace Website.Layout.SubLayout
{
    public partial class Finished : System.Web.UI.UserControl
    {
        private Sitecore.Data.Items.Item CurrentUser { get; set; }
        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        public void Restart_Click(Object sender, EventArgs e)
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }
    }
}