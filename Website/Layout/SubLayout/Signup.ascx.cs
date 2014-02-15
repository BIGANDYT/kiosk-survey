using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Website.code;
using Website.model;

namespace Website.Layout.SubLayout
{
    public partial class Signup : Survey
    {
        public List<String> errors = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Item tt = Sitecore.Context.Item["Title"];
            Sitecore.Data.Items.Item titletext = master.GetItem(Sitecore.Context.Item["Title"]);
            if (titletext != null)
            {
                SignupTitle.InnerHtml = titletext.Fields["Text"].Value;
            }
            Sitecore.Data.Items.Item PrizeTexttext = master.GetItem(Sitecore.Context.Item["PrizeText"]);
            if (PrizeTexttext != null)
            {
                PrizeText.InnerHtml = PrizeTexttext.Fields["Text"].Value;
            }
            Sitecore.Data.Items.Item Subtitletext = master.GetItem(Sitecore.Context.Item["Subtitle"]);
            if (Subtitletext != null)
            {
                Subtitle.InnerHtml = Subtitletext.Fields["Text"].Value;
            }
            Sitecore.Data.Fields.ImageField imageField = Sitecore.Context.Item.Fields["PrizeImage"];
            if (imageField != null && imageField.MediaItem != null)
            {
                Sitecore.Data.Items.MediaItem image = new Sitecore.Data.Items.MediaItem(imageField.MediaItem);
                PrizeImage.ImageUrl = Sitecore.StringUtil.EnsurePrefix('/', Sitecore.Resources.Media.MediaManager.GetMediaUrl(image));
            }
            else
            {
                PrizeImage.Visible = false;
            }
            SetCurrentUser();
        }

        public void Email_Click(Object sender, EventArgs e)
        {
            Log.Info(String.Format("Name {0} Company {1} JobTitle {2} Email {3} SitecoreRegion {4}" , Name.Value, Company.Value, JobTitle.Value, Email.Value, MultiRegion.GetRegion()), this);
            if (validate().Count == 0)
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Log.Info("updating atendee", this);
                    CurrentUser.Editing.BeginEdit();
                    CurrentUser.Fields["Name"].Value = Name.Value;
                    CurrentUser.Fields["Company"].Value = Company.Value;
                    CurrentUser.Fields["Email"].Value = Email.Value;
                    CurrentUser.Fields["JobTitle"].Value = JobTitle.Value;
                    CurrentUser.Fields["SitecoreRegion"].Value = MultiRegion.GetRegion();
                    CurrentUser.Editing.EndEdit();
                    Log.Info("attendee updated", this);
                }

                NextPage();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openErrorModal();", true);

            }
        }

        private List<String> validate()
        {
            if (String.IsNullOrWhiteSpace(Name.Value)) { errors.Add("Please enter a Name"); }
            if (String.IsNullOrWhiteSpace(Company.Value)) { errors.Add("Please enter a Company"); }
            if (String.IsNullOrWhiteSpace(JobTitle.Value)) { errors.Add("Please enter a JobTitle"); }
            if (String.IsNullOrWhiteSpace(Email.Value)) { errors.Add("Please enter an Email"); }
            else if (!Regex.IsMatch(Email.Value, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z")) { errors.Add("Please enter a valid email address"); }
            return errors;
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            Restart();
        }
    }
}