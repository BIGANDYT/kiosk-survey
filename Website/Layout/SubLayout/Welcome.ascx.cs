using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;

namespace Website.Layout.SubLayout
{
    public partial class Welcome : System.Web.UI.UserControl
    {
        private Sitecore.Data.Items.Item CurrentUser { get; set; }
        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Buttonlink_Click(object sender, EventArgs e)
        {
            Sitecore.Data.Items.Item parent = master.GetItem("/sitecore/content/Attendees");
            TemplateItem attendeeTemplate = Sitecore.Configuration.Factory.GetDatabase("master").Templates["{AD71F430-184A-4DDE-B84C-E28FA6FCB5D0}"];
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                Log.Info("ANDYT" + "CREATING ITEM", this);
                Item newAttendee = parent.Add(new Guid().ToString(), attendeeTemplate);               
                Sitecore.Context.ClientData.SetValue("CurrentUser", newAttendee.ID.ToString());
                Log.Info("ANDYT" + "ITEM CREATED", this);
            }  
            Response.Redirect(Sitecore.Context.Item["Link"]);
        }
    }
}