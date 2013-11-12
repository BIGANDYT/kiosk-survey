using Sitecore.Data.Items;
using System;
using System.Web.UI.WebControls;
using Website.model;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Web.UI;
using System.Text;

namespace Website.Layout.SubLayout
{
    public partial class Summary : Survey
    {
        public System.Web.Script.Serialization.JavaScriptSerializer serializer;
        public List<Item> qualifiers;

        protected void Page_Load(object sender, EventArgs e)
        {
            ClientScriptManager cs = Page.ClientScript;
            SetCurrentUser();
            qualifiers = GetQualifier(master.SelectItems("/sitecore/content/Qualifiers//*[@@templatekey='qualifier']"));
            Item qualifier = qualifiers[0];
            stopper.Value = qualifier.Name;
            Heading.InnerHtml = "<h2>You are</h2>";
            Description.InnerHtml = "<h4>" + qualifier["Description"] + "</h4>";
            SubHeading.InnerHtml = "<h2>" + qualifier["SubHeading"] + "</h2>";
            SubDescription.InnerHtml = "<h4>" + qualifier["SubDescription"] + "</h4>";
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                CurrentUser.Editing.BeginEdit();
                CurrentUser["Qualifier"] = qualifier.Name;
                CurrentUser.Editing.EndEdit();
            }
            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var levels = new Array;");
            qualifiers.Reverse();
            foreach (Item item in qualifiers)
            {
                sb.Append("levels.push('" + item["Heading"] + "');");
            }
            sb.Append("</script>");
            cs.RegisterStartupScript(this.GetType(), "LevelsScript", sb.ToString());
        }

        private List<Item> GetQualifier(Item[] qualifiers)
        {
            Array.Reverse(qualifiers);
            List<Item> items = new List<Item>();
            items.AddRange(qualifiers);
            foreach (Item qualifier in qualifiers)
            {
                if (Equals(qualifier, CurrentUser) || qualifier.ID.ToString() == "{EC712628-FA63-45B7-8AFB-039F53500457}")
                {
                    break;
                }
                items.Remove(qualifier);
            }
            return items;
        }

        public bool Equals(Item obj, Item obj2)
        {
            if (obj == null || obj2 == null)
            {
                return false;
            }
            if (obj.ID.ToString() == "{EB751B9C-8982-428B-968A-48DD72EB3ABD}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]) && obj["Align"].Equals(obj2["Align"]) && obj["Optimize"].Equals(obj2["Optimize"]) && obj["Nurture"].Equals(obj2["Nurture"]) && obj["Engage"].Equals(obj2["Engage"]) && obj["Lifetime Customers"].Equals(obj2["Lifetime Customers"]));
            }
            if (obj.ID.ToString() == "{A5A38E6B-9F70-44BE-9F29-D7620AF6F49C}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]) && obj["Align"].Equals(obj2["Align"]) && obj["Optimize"].Equals(obj2["Optimize"]) && obj["Nurture"].Equals(obj2["Nurture"]) && obj["Engage"].Equals(obj2["Engage"]));
            }
            if (obj.ID.ToString() == "{278A9A5B-E756-440E-B138-CD5FE1191CB5}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]) && obj["Align"].Equals(obj2["Align"]) && obj["Optimize"].Equals(obj2["Optimize"]) && obj["Nurture"].Equals(obj2["Nurture"]));
            }
            if (obj.ID.ToString() == "{8183C228-0C9B-4DDD-A8BD-367C4689B122}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]) && obj["Align"].Equals(obj2["Align"]) && obj["Optimize"].Equals(obj2["Optimize"]));
            }
            if (obj.ID.ToString() == "{6A8B2DBE-3645-4A96-8BAA-225FC9CB126E}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]) && obj["Align"].Equals(obj2["Align"]));
            }
            if (obj.ID.ToString() == "{BD394A85-4097-41CE-94FC-C8B276840C3C}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]) && obj["Radiate"].Equals(obj2["Radiate"]));
            }
            if (obj.ID.ToString() == "{EC712628-FA63-45B7-8AFB-039F53500457}")
            {
                return (obj["Initiate"].Equals(obj2["Initiate"]));
            }
            return false;
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            NextPage();
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Restart();
        }
    }
}