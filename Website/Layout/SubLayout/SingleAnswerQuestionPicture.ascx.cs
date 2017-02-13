using Sitecore.Analytics;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Links;
using System;
using System.Web.UI.WebControls;
using Website.code.facet;
using Website.code.repository;

namespace Website.Layout.SubLayout
{
    public class SingleAnswerQuestionPicture : System.Web.UI.UserControl
    {
        public Item[] items = null;
        String answerId;
        public Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
        public SurveyRepository answerRepo = new SurveyRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            answerId = Request.Form["buttonvalue"];
            if (!IsPostBack || String.IsNullOrWhiteSpace(answerId))
            {                
                items = master.SelectItems("/sitecore/system/Marketing Control Panel/Profiles/Survey/Maturity/Pattern Cards//*[@@templatekey='pattern card']");
                if (Sitecore.Analytics.Tracker.IsActive)
                {
                    Sitecore.Analytics.Tracker.Current.Interaction.CurrentPage.Cancel();
                }
            }
        }

        public void Next_Click(Object sender, EventArgs e)
        {
            answerId = Request.Form["buttonvalue"];

            if (!String.IsNullOrWhiteSpace(answerId))
            {
                Sitecore.Data.Items.Item answer = master.GetItem(answerId);
                SurveyFacetModel answerModel = new SurveyFacetModel(Sitecore.Context.Item.Fields["Question"].Value, answer.Fields["Name"].Value);
                answerRepo.SetAnswer(Tracker.Current.Contact, answerModel);
            }
            Log.Info("ANDYT ANSWER next" + Sitecore.Context.Item["Next Page"].ToString(), this);
            if (!String.IsNullOrEmpty(Sitecore.Context.Item["Next Page"]))
            {
                Sitecore.Data.Fields.InternalLinkField lf = Sitecore.Context.Item.Fields["Next Page"];
                Response.Redirect(LinkManager.GetItemUrl(lf.TargetItem));
            }
        }

        public void Restart_Click(object sender, CommandEventArgs e)
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }
    }
}