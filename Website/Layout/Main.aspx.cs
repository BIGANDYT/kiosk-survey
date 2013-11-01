using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website.Layout
{
    public partial class Main : System.Web.UI.Page
    {

        private Boolean activated = false;

        protected string circle(String name)
        {
            String sel = String.Empty;
            if (activated)
            {
                sel = "unsel";
            }
            else
            {
                sel = "sel";
            }
            if (Sitecore.Context.Item["Stage"] == name)
            {
                activated = true;
            }
            return sel;

        }

        protected string line(String name)
        {
            if (name == "Finish")
            {
                return "hider";
            }
            if (Sitecore.Context.Item["Stage"] == name)
            {
                activated = true;
            }
            if (activated)
            {
                return "lineunsel";
            }
            else
            {
                return "linesel";
            }
        }

        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {

            activated = false;
            //ProgressRepeater.DataSource = master.SelectItems(Sitecore.Context.Site.RootPath + "//*[@@templatekey='stage']");
            //ProgressRepeater.DataBind();
        }
    }
}