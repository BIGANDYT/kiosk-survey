using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Links;
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
            if (Sitecore.Context.ClientData.GetValue("CurrentUser") != null)
            {
                String currentUserId = Sitecore.Context.ClientData.GetValue("CurrentUser").ToString();
                CurrentUser = master.GetItem(currentUserId);
            }
            else
            {
                // possbile session timeout so redirect to the start
                Response.Redirect(Sitecore.Context.Site.StartPath);
            }
        }

        public void Restart()
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }


        public void CreateUser()
        {
            Sitecore.Data.Items.Item parent = master.GetItem("/sitecore/content/Attendees");
            TemplateItem attendeeTemplate = Sitecore.Configuration.Factory.GetDatabase("master").Templates["{AD71F430-184A-4DDE-B84C-E28FA6FCB5D0}"];
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                Log.Info("ANDYT" + "CREATING USER", this);
                Item newAttendee = parent.Add(Guid.NewGuid().ToString(), attendeeTemplate);
                Sitecore.Context.ClientData.SetValue("CurrentUser", newAttendee.ID.ToString());
                Log.Info("ANDYT" + "USER CREATED", this);
            }
        }

        public void NextPage() {
            Sitecore.Data.Items.Item item = master.GetItem(Sitecore.Context.Item["Next Page"]);
            Response.Redirect(LinkManager.GetItemUrl(item));
        }
    }
}