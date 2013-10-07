using Sitecore.Data.Items;
using System;
using System.Web.UI.WebControls;
using Website.model;

namespace Website.Layout.SubLayout
{
    public partial class Summary : Survey
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            Item qulaifier = GetQualifier();
            stopper.Value = qulaifier.Name;
            Heading.InnerText = qulaifier["Heading"];
            Description.InnerText = qulaifier["Description"];
            SubHeading.InnerText = qulaifier["SubHeading"];
            SubDescription.InnerText = qulaifier["SubDescription"];
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                CurrentUser.Editing.BeginEdit();
                CurrentUser["Qualifier"] = qulaifier.Name;
                CurrentUser.Editing.EndEdit();
            }
        }

        private Sitecore.Data.Items.Item GetQualifier()
        {
            Item[] qualifiers = master.SelectItems("/sitecore/content/Qualifiers//*[@@templatekey='qualifier']");           
            Array.Reverse(qualifiers);
            foreach (Item qualifier in qualifiers)
            {
                if (Equals(qualifier, CurrentUser))
                {
                    return qualifier;
                }
            }
            // return default  initiate
            return master.GetItem("{EC712628-FA63-45B7-8AFB-039F53500457}");
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
            Response.Redirect(Sitecore.Context.Item["Next Page"]);
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Restart();
        }
    }
}