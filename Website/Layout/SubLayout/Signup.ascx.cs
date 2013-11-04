using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Website.model;

namespace Website.Layout.SubLayout
{
    public partial class Signup : Survey
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                SetCurrentUser();
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
                NextPage();
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            Restart();
        }
    }
}