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
using Website.model;

namespace Website.Layout.SubLayout
{
    public partial class QualifierQuestion : Survey
    {
        public Item[] items = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            if (!IsPostBack)
            {
                items = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
            }
        }

        protected void Next_Click(object sender, CommandEventArgs e)
        {
            Log.Info("ANDYT ANSWER USERR" + CurrentUser.Name, this);
            Log.Info("ANDYT ANSWER COMMANDARG" + (String)e.CommandArgument, this);

            String radioValue = Request.Form["buttonvalue"];

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
                //now save the qestion and asnwer
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    CurrentUser.Editing.BeginEdit();
                    Item newQuestion = Sitecore.Context.Item.CloneTo(CurrentUser, Sitecore.Context.Item.Name, false);
                    answer.CloneTo(newQuestion, answer.Name, false);
                    CurrentUser.Editing.EndEdit();
                }
                Log.Info("ANDYT ANSWER next" + Sitecore.Context.Item["Next Page"].ToString(), this);
                if (!String.IsNullOrEmpty(Sitecore.Context.Item["Next Page"]))
                {
                    NextPage();
                }
            }
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Restart();
        }
    }
}