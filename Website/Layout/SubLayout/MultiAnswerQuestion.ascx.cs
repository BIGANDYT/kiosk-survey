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
        public Item[] items = null;
        String radioValue;
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            if (!IsPostBack || String.IsNullOrWhiteSpace(radioValue))
            {
                items = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
            }
        }
        
        public void Next_Click(Object sender, EventArgs e)
        {
            radioValue = Request.Form["buttonvalue"];
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