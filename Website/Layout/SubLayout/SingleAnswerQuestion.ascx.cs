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
    public partial class SingleAnswerQuestion : Survey
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            if (!IsPostBack)
            {
                AnswerRepeater.DataSource = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
                AnswerRepeater.DataBind();
            }
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            String radioValue = Request.Form["buttonvalue"];
            if (!String.IsNullOrWhiteSpace(radioValue))
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Item newQuestion = Sitecore.Context.Item.CloneTo(CurrentUser, Sitecore.Context.Item.Name, false);
                    Item answer = master.GetItem(radioValue);
                    answer.CloneTo(newQuestion, answer.Name, false);
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