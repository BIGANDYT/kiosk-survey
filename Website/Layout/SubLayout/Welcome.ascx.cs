using System;
using Sitecore.Links;
using System.Web.UI;

namespace Website.Layout.SubLayout
{
    public class Welcome : UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Sitecore.Analytics.Tracker.IsActive)
                {
                    Sitecore.Analytics.Tracker.Current.Interaction.CurrentPage.Cancel();
                }
            }
        }
        protected void Buttonlink_Click(object sender, EventArgs e)
        {
            Sitecore.Data.Fields.InternalLinkField lf = Sitecore.Context.Item.Fields["Next Page"];
            Response.Redirect(LinkManager.GetItemUrl(lf.TargetItem));
        }
    }
}