using Sitecore.Data;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Globalization;
using Sitecore.Links;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Website.Layout.SubLayout
{
    public partial class QualifierQuestion : System.Web.UI.UserControl
    {
        private Sitecore.Data.Items.Item CurrentUser { get; set; }
        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");


        protected void Page_Load(object sender, EventArgs e)
        {

            //int TotalQs = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='question' or @@templatekey='multianswerquestion']").Count();
            String currentUserId = Sitecore.Context.ClientData.GetValue("CurrentUser").ToString();
            CurrentUser = master.GetItem(currentUserId);
            AnswerRepeater.DataSource = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
            AnswerRepeater.DataBind();
        }

        //private static Item[] GetLinkedItems(Database database, Language language, Item refItem)
        //{
        //   ItemLink[] links = Sitecore.Globals.LinkDatabase.GetReferrers(refItem);
        //    if (links == null)
        //    {
        //        return null;
        //    }
        //    ArrayList result = new ArrayList(links.Length);
        //
        //  foreach (ItemLink link in links)
        //{

        //      Item item = database.Items[link.SourceItemID, language];
        // adding the Item to an array if the Item is not null
        //    if (item != null)
        //  {
        //    result.Add(item);
        //}

        //}
        //return (Item[])result.ToArray(typeof(Item));
        // }

        protected void Restart_Click(object sender, CommandEventArgs e)
        {
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                CurrentUser.Delete();
            }
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }

        protected void Next_Click(object sender, CommandEventArgs e)
        {
            Log.Info("ANDYT ANSWER USERR" + CurrentUser.Name, this);
            Log.Info("ANDYT ANSWER COMMANDARG" + (String)e.CommandArgument, this);

            String radioValue = Request.Form[Sitecore.Context.Item.ID.ToString()];

            if (!String.IsNullOrWhiteSpace(radioValue))
            {

                Sitecore.Data.Items.Item answer = master.GetItem(radioValue);
                Sitecore.Data.Fields.MultilistField multilistField = answer.Fields["Levels"];

                if (multilistField != null)
                {

                    //Iterate over all the selected items by using the property TargetIDs

                    foreach (var id in multilistField.TargetIDs)
                    {

                        Item targetItem = master.Items[id];
                        int value = 0;
                        if (String.IsNullOrEmpty(targetItem["Value"]) == false)
                        {
                            value = System.Convert.ToInt32(targetItem["Value"]);
                        }
                        int oldValue = 0;
                        if (String.IsNullOrEmpty(CurrentUser[targetItem["Type"]]) == false)
                        {
                            oldValue = System.Convert.ToInt32(CurrentUser[targetItem["Type"]]);
                        }
                        using (new Sitecore.SecurityModel.SecurityDisabler())
                        {
                            CurrentUser.Editing.BeginEdit();
                            CurrentUser[targetItem["Type"]] = (oldValue + value).ToString();
                            CurrentUser.Editing.EndEdit();
                        }
                        Log.Info("ANDYT LEVEL: " + CurrentUser[targetItem["Type"]], this);
                    }
                }
                Log.Info("ANDYT ANSWER next" + Sitecore.Context.Item["Next Page"].ToString(), this);
                if (!String.IsNullOrEmpty(Sitecore.Context.Item["Next Page"]))
                {
                    Response.Redirect(Sitecore.Context.Item["Next Page"]);
                }
            }
        }
    }
}