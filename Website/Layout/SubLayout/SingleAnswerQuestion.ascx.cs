﻿using Sitecore;
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

namespace Website.Layout.SubLayout
{
    public partial class SingleAnswerQuestion : System.Web.UI.UserControl
    {

        private Sitecore.Data.Items.Item CurrentUser { get; set; }
        private Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {
            String currentUserId = Sitecore.Context.ClientData.GetValue("CurrentUser").ToString();
            CurrentUser = master.GetItem(currentUserId);
            AnswerRepeater.DataSource = master.SelectItems(Sitecore.Context.Item.Paths.Path + "//*[@@templatekey='answer']");
            AnswerRepeater.DataBind();
        }

        protected void Restart_Click(object sender, CommandEventArgs e)
        {
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                CurrentUser.Delete();
            }
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            String radioValue = Request.Form[Sitecore.Context.Item.ID.ToString()];
            if (!String.IsNullOrWhiteSpace(radioValue))
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Item newQuestion = Sitecore.Context.Item.CloneTo(CurrentUser, Sitecore.Context.Item.Name, false);                    
                    Item answer = master.GetItem(radioValue);
                    answer.CloneTo(newQuestion, answer.Name, false);                   
                    Response.Redirect(Sitecore.Context.Item["Next Page"]);                  
                }
            }
        }
    }
}