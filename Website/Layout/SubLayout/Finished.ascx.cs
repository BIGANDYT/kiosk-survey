using System;
using System.Web;
using Sitecore.Analytics;
using Sitecore.Analytics.Outcome.Extensions;
using Sitecore.Analytics.Outcome.Model;
using Sitecore.Common;

namespace Website.Layout.SubLayout
{
    public class Finished : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                //Force a fluish to the XDB
                // Register an outcome in the session. It will only be saved to the database on session end
                // and only in case the contact itself is saved.
                ContactOutcome outcome = new ContactOutcome(Sitecore.Data.ID.NewID, new Sitecore.Data.ID("{81140665-3C4C-43BC-8DC9-CAFDE51263BF}"), Tracker.Current.Contact.ContactId.ToID());
                Tracker.Current.RegisterContactOutcome(outcome);
                Sitecore.Analytics.Tracker.Current.EndTracking();
                HttpContext.Current.Session.Abandon();  
            } else
            {
                if (Sitecore.Analytics.Tracker.IsActive)
                {
                    Sitecore.Analytics.Tracker.Current.Interaction.CurrentPage.Cancel();
                }
            }
        }
        

        protected void Restart_Click(object sender, EventArgs e)
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }

    }
}