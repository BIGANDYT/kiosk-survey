using Sitecore;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Text;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Website.model;

namespace Website.Layout.SubLayout
{
    public partial class MultiAnswerQuestion : Survey
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            AnswerRepeater.DataSource = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
            AnswerRepeater.DataBind();
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            String radioValue = Request.Form[Sitecore.Context.Item.ID.ToString()];
            if (!String.IsNullOrWhiteSpace(radioValue))
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Item newQuestion = Sitecore.Context.Item.CloneTo(CurrentUser, Sitecore.Context.Item.Name, false);
                    String[] checkedAns = radioValue.Split(',');
                    foreach (String answer in checkedAns)
                    {
                        Item answerItem = master.GetItem(answer);
                        answerItem.CloneTo(newQuestion, answerItem.Name, false);
                    }
                    Response.Redirect(Sitecore.Context.Item["Next Page"]);
                }
            }
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Restart();
        }
    }
}