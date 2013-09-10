using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Links;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Website.Layout.SubLayout
{
    public partial class QuestionSubLayout : System.Web.UI.UserControl
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

        protected void GreetingBtn_Click(object sender, CommandEventArgs e)
        {
            Log.Info("ANDYT ANSWER USERR" + CurrentUser.Name, this);
            Log.Info("ANDYT ANSWER COMMANDARG" + (String)e.CommandArgument, this);

            String radioValue = Request.Form[Sitecore.Context.Item.ID.ToString()];         

            if (!String.IsNullOrWhiteSpace(radioValue)) {
            
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
                        value = Convert.ToInt32(targetItem["Value"]);
                    }
                    int oldValue = 0;
                    if (String.IsNullOrEmpty(CurrentUser[targetItem["Type"]]) == false)
                    {
                        oldValue = Convert.ToInt32(CurrentUser[targetItem["Type"]]);
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
            Log.Info("ANDYT ANSWER next" + Sitecore.Context.Item["Next Question"].ToString(), this);
            if (!String.IsNullOrEmpty(Sitecore.Context.Item["Next Question"]))
            {
                Response.Redirect(Sitecore.Context.Item["Next Question"]);
            }
            }
        }
    }
}