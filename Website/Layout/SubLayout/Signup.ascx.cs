using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website.Layout.SubLayout
{
    public partial class Signup : System.Web.UI.UserControl
    {

        private Sitecore.Data.Items.Item CurrentUser { get; set; }
        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {
            String currentUserId = Sitecore.Context.ClientData.GetValue("CurrentUser").ToString();
            CurrentUser = master.GetItem(currentUserId);
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                CurrentUser.Delete();
            }
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }

        public void Email_Click(Object sender, EventArgs e)
        {            
                Log.Info(String.Format("Name {0} Company {1} JobTitle {2} Email {3}", Name.Value, Company.Value, JobTitle.Value, Email.Value), this);
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Log.Info("updating atendee", this);
                    CurrentUser.Editing.BeginEdit();
                    CurrentUser.Fields["Name"].Value = Name.Value;
                    CurrentUser.Fields["Company"].Value = Company.Value;
                    CurrentUser.Fields["Email"].Value = Email.Value;
                    CurrentUser.Fields["JobTitle"].Value = JobTitle.Value;
                    CurrentUser.Editing.EndEdit();
                    Log.Info("attendee updated", this);
                }
                Response.Redirect(Sitecore.Context.Item["Next Page"]);
        }
    }
}