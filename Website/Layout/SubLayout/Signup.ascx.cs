using Sitecore.Analytics;
using Sitecore.Analytics.Tracking;
using Sitecore.Diagnostics;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.UI;
using Website.code;
using Sitecore.Analytics.Model.Entities;
using Sitecore.Analytics.Model.Framework;
using Sitecore.Links;
using System.Web.UI.HtmlControls;

namespace Website.Layout.SubLayout
{
    public class Signup : System.Web.UI.UserControl
    {
        public List<String> errors = new List<string>();
        public Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
        public HtmlInputText Firstname;
        public HtmlInputText Surname;
        public HtmlInputText Company;
        public HtmlInputText JobTitle;
        public HtmlInputGenericControl Email;
        public HtmlGenericControl SignupTitle;
        public HtmlGenericControl PrizeText;
        public HtmlGenericControl Subtitle;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                if (Sitecore.Analytics.Tracker.IsActive)
                {
                    Sitecore.Analytics.Tracker.Current.Interaction.CurrentPage.Cancel();
                }
            }
        }

        public void Email_Click(Object sender, EventArgs e)
        {
            string EncodedResponse = Request.Form["g-Recaptcha-Response"];
            bool IsCaptchaValid = (ReCaptchaClass.Validate(EncodedResponse) == "True" ? true : false);

            if (validate().Count == 0 && IsCaptchaValid)
            {
                Log.Info("updating contact", this);
                Sitecore.Analytics.Tracker.Current.Session.Identify(Email.Value);
                UpdatePersonalInfo();
                UpdateEmail();
                Log.Info("contact updated", this);
                Sitecore.Data.Fields.InternalLinkField lf = Sitecore.Context.Item.Fields["Next Page"];
                Response.Redirect(LinkManager.GetItemUrl(lf.TargetItem));
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openErrorModal();", true);

            }
        }


        private List<String> validate()
        {
            if (String.IsNullOrWhiteSpace(Firstname.Value)) { errors.Add("Please enter a Firstname"); }
            if (String.IsNullOrWhiteSpace(Surname.Value)) { errors.Add("Please enter a Surname"); }
            if (String.IsNullOrWhiteSpace(Company.Value)) { errors.Add("Please enter a Company"); }
            if (String.IsNullOrWhiteSpace(JobTitle.Value)) { errors.Add("Please enter a JobTitle"); }
            if (String.IsNullOrWhiteSpace(Email.Value)) { errors.Add("Please enter an Email"); }
            else if (!Regex.IsMatch(Email.Value, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z")) { errors.Add("Please enter a valid email address"); }
            return errors;
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            Response.Redirect(Sitecore.Context.Site.StartPath);
        }

        internal void UpdatePersonalInfo()
        {
            if ((Tracker.Current != null) && (Tracker.Current.Contact != null))
            {
                try
                {
                    Contact contact = Tracker.Current.Contact;
                    IContactPersonalInfo personal = contact.GetFacet<IContactPersonalInfo>("Personal");
                    personal.FirstName = Firstname.Value;
                    personal.Surname = Surname.Value;
                }
                catch (FacetNotAvailableException ex)
                {
                    Log.Warn("The 'Personal' facet is not available.", ex);
                }
            }
        }

        internal void UpdateEmail()
        {
            if ((Tracker.Current != null) && (Tracker.Current.Contact != null))
            {
                try
                {
                    Contact contact = Tracker.Current.Contact;
                    IContactEmailAddresses contactEmail = contact.GetFacet<IContactEmailAddresses>("Emails");
                    if (!contactEmail.Entries.Contains("Personal"))
                    {
                        contactEmail.Entries.Create("Personal");
                    }

                    // set the email
                    var email = contactEmail.Entries["Personal"];
                    email.SmtpAddress = Email.Value;
                    contactEmail.Preferred = "Personal";
                }
                catch (FacetNotAvailableException ex)
                {
                    Log.Warn("The 'Emails' facet is not available.", ex);
                }
            }
        }
    }
}

