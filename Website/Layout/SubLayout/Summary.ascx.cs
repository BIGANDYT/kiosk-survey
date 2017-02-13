using Sitecore.Data.Items;
using System;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.UI;
using System.Text;
using Sitecore.Analytics;
using Sitecore.Analytics.Tracking;
using Sitecore.Common;
using Website.code.repository;
using Sitecore.Links;
using System.Web.UI.HtmlControls;

namespace Website.Layout.SubLayout
{
    public class Summary : System.Web.UI.UserControl
    {
        public System.Web.Script.Serialization.JavaScriptSerializer serializer;
        public List<Item> qualifiers;
        public Item[] masterList;
        public Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
        public MaturityRepository maturityRepo = new MaturityRepository();
        public HtmlGenericControl Heading;
        public HtmlGenericControl Description;
        public HtmlGenericControl SubHeading;
        public HtmlGenericControl SubDescription;
        public HtmlInputHidden stopper;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Sitecore.Data.Fields.InternalLinkField lf = Sitecore.Context.Item.Fields["Profile"];
                Item profile = lf.TargetItem;
                Profile maturity = Tracker.Current.Session.Interaction.Profiles[profile.Name];
                if (maturity != null && maturity.PatternLabel != null)
                {
                    stopper.Value = maturity.PatternLabel;
                    //set the maturity against the contact facet
                    maturityRepo.SetMaturityLevel(Tracker.Current.Contact, maturity.PatternLabel);
                    Item patternItem = Sitecore.Context.Database.GetItem(maturity.PatternId.Value.ToID());
                    if (patternItem != null)
                    {
                        Heading.InnerHtml = "<h2>You are</h2>";
                        Description.InnerHtml = "<h4>" + patternItem["Description"] + "</h4>";
                        SubHeading.InnerHtml = "<h2>" + patternItem["SubHeading"] + "</h2>";
                        SubDescription.InnerHtml = "<h4>" + patternItem["SubDescription"] + "</h4>";
                        masterList = master.SelectItems(profile.Paths.Path + "/Pattern Cards//*[@@templatekey='pattern card']");
                        if (masterList != null)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.Append("<script>");
                            sb.Append("var levels = new Array;");
                            sb.Append("var levelColors = new Array;");
                            string stopperstr = "\"" + patternItem["Name"] + "\"";
                            sb.Append("var stopper = " + stopperstr + ";");
                            foreach (Item item in masterList)
                            {
                                string str = "\"" + item["Name"] + "\"";
                                sb.Append("levels.push(" + str + ");");
                                string colorstr = "\"" + item["Color"] + "\"";
                                sb.Append("levelColors.push(" + colorstr + ");");
                            }
                            sb.Append("</script>");
                            ClientScriptManager cs = Page.ClientScript;
                            cs.RegisterStartupScript(this.GetType(), "LevelsScript", sb.ToString());
                        }
                    }
                    else
                    {
                        Heading.InnerHtml = "<h2>Pattern Item not found</h2>";
                    }
                }
                else
                {
                    Heading.InnerHtml = "<h2>Couldnt find a Maturity profile for the current contact</h2>";
                }
                if (Sitecore.Analytics.Tracker.IsActive)
                {
                    Sitecore.Analytics.Tracker.Current.Interaction.CurrentPage.Cancel();
                }
            }
        }


        public void Next_Click(Object sender, EventArgs e)
        {
            Sitecore.Data.Fields.InternalLinkField lf = Sitecore.Context.Item.Fields["Next Page"];
            Response.Redirect(LinkManager.GetItemUrl(lf.TargetItem));
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }
    }
}