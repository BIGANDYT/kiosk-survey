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
    public partial class SingleAnswerQuestionPicture : Survey
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCurrentUser();
            AnswerRepeater.DataSource = master.SelectItems("/sitecore/content/Qualifiers//*[@@templatekey='qualifier']");
            AnswerRepeater.DataBind();
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            String radioValue = Request.Form[Sitecore.Context.Item.ID.ToString()];
            if (!String.IsNullOrWhiteSpace(radioValue))
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    // should really check here to see if it exists and update if it does
                    Item newQuestion = Sitecore.Context.Item.CloneTo(CurrentUser, Sitecore.Context.Item.Name, false);                    
                    Item answer = master.GetItem(radioValue);
                    answer.CloneTo(newQuestion, answer.Name, false);                   
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