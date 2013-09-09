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



        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public void GreetingBtn_Click(Object sender, EventArgs e)
        {
            
                Log.Info("ANDYT" + String.Format("Name {0} Company {1} Email {2}", Name.Value, Company.Value, Email.Value), this);
                Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
                Sitecore.Data.Items.Item parent = master.GetItem("/sitecore/content/Attendees");
                TemplateItem attendeeTemplate = Sitecore.Configuration.Factory.GetDatabase("master").Templates["{AD71F430-184A-4DDE-B84C-E28FA6FCB5D0}"];
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Log.Info("ANDYT" + "CREATING ITEM", this);
                    Item newAttendee = parent.Add(Name.Value.ToString(), attendeeTemplate);
                    newAttendee.Editing.BeginEdit();
                    newAttendee.Fields["Name"].Value = Name.Value;
                    newAttendee.Fields["Company"].Value = Company.Value;
                    newAttendee.Fields["Email"].Value = Email.Value;
                    newAttendee.Editing.EndEdit();
                    Sitecore.Context.ClientData.SetValue("CurrentUser", newAttendee.ID.ToString());
                    Log.Info("ANDYT" + "ITEM CREATED", this);
                }
                Response.Redirect(Sitecore.Context.Item["Link"]);
            
        }
    }
}