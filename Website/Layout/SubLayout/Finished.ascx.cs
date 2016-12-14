using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Sitecore.Data.Items;
using Sitecore.Diagnostics;
//using Sitecore.Modules.EmailCampaign;
using Website.model;
using System.Web.UI.WebControls;
using Website.code;
using System.Web.Security;

namespace Website.Layout.SubLayout
{
    public partial class Finished : Survey
    {
        // TODO: move this to do a lookup on the folder item, add a property to the emails and then match in the method.
        private String[] Survey = { "{AF16E079-3565-4AC1-A8A8-8A1B73506C7D}","{A3E4831C-C36C-4539-B4CA-968F17620513}","{2E89CD57-426E-4E24-A71A-81FD1D901C26}","{7210D193-AE45-4F05-95CA-43B670EFC4C5}","{C37B7713-769E-4C93-AF89-11CA35CE241D}","{64716F69-EC72-4E3D-857C-CB015CDB5252}","{2AB56DDC-B4F9-4FE2-AE89-E7341E79B97E}" };
        private String[] Sweden = { "{30C0E079-F9ED-464E-AEF1-D7D91B7408B8}","{E310B220-E46E-48F7-B6C7-D812DD4578DB}","{294552B5-4C4C-4E7B-ACCB-F8ADE0B32BD4}","{40593D5D-9343-4E6C-9273-C4EC31605486}","{C7DFC2F2-EB4E-4ED2-B259-D84EDDC07077}","{30C0E079-F9ED-464E-AEF1-D7D91B7408B8}","{B78C00BB-AED4-4990-95FA-6F8500EC54D9}" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Sitecore.Data.Items.Item PrizeTexttext = master.GetItem(Sitecore.Context.Item["PrizeText"]);
                if (PrizeTexttext != null)
                {
                    PrizeText.InnerHtml = PrizeTexttext.Fields["Text"].Value;
                }
                //Sitecore.Data.Fields.ImageField imageField = Sitecore.Context.Item.Fields["PrizeImage"];
                //if (imageField != null && imageField.MediaItem != null)
                //{
                //    Sitecore.Data.Items.MediaItem image = new Sitecore.Data.Items.MediaItem(imageField.MediaItem);
                //    PrizeImage.ImageUrl = Sitecore.StringUtil.EnsurePrefix('/', Sitecore.Resources.Media.MediaManager.GetMediaUrl(image));
                //}
                //else
                //{
                //    PrizeImage.Visible = false;
               // }
                SetCurrentUser();
                var currentUserMaturity = CurrentUser["Qualifier"].ToString();
                var currentUserEmailAdd = CurrentUser["Email"].ToString();
                var currentUserName = CurrentUser["Name"].ToString();
                Item emailId = null;
                switch (MultiRegion.GetRegion().ToLower())
                {
                    case "survey":
                        emailId = GetLevel(currentUserMaturity, currentUserEmailAdd, currentUserName, Survey);
                        break;
                    case "benelux":
                        emailId = GetLevel(currentUserMaturity, currentUserEmailAdd, currentUserName, Survey);
                        break;
                    case "sweden":
                        emailId = GetLevel(currentUserMaturity, currentUserEmailAdd, currentUserName, Sweden);
                        break;
                    default:
                        emailId = GetLevel(currentUserMaturity, currentUserEmailAdd, currentUserName, Survey);
                        break;
                }
                SendEmail(emailId, currentUserEmailAdd, currentUserName);
            }
        }

        private Item GetLevel(string currentUserMaturity, string currentUserEmailAdd, string currentUserName, String[] EmailIDs)
        {
            switch (currentUserMaturity)
            {
                case "Initiator": //Initiate
                    return Sitecore.Context.Database.GetItem(EmailIDs[0]);
                case "Promoter": //Radiate
                    return Sitecore.Context.Database.GetItem(EmailIDs[1]);
                case "Aligner": //Align
                    return Sitecore.Context.Database.GetItem(EmailIDs[2]);
                case "Optimizer": //Optimise
                    return Sitecore.Context.Database.GetItem(EmailIDs[3]);
                case "Nurturer": //Nurture
                    return Sitecore.Context.Database.GetItem(EmailIDs[4]);
                case "Engager": //Engage
                    return Sitecore.Context.Database.GetItem(EmailIDs[5]);
                case "Lifetime Customer Champion": //Lifetime
                    return Sitecore.Context.Database.GetItem(EmailIDs[6]);
                default:
                    return Sitecore.Context.Database.GetItem(EmailIDs[0]);
            }
        }

        private void SendEmail(Item emailId, string EmailAddress, string emailName)
        {
            // Define the manager root LIVE: {8021493A-C5FE-4582-BE97-3F137295C432}
            //var managerRootItem = Sitecore.Context.Database.GetItem("{8021493A-C5FE-4582-BE97-3F137295C432}");
            //var managerRoot = Factory.GetManagerRootFromItem(managerRootItem);
            //Contact contact = null;
            // Get a fake account on the go and pass in the email address
            //MembershipUserCollection users = Membership.FindUsersByEmail(EmailAddress);
            //if (users.Count > 0)
            //{
            //    foreach (MembershipUser m in users)
            //    {
            //         contact = Contact.FromName(m.UserName);
            //         break;
            //    }
            //}
            //else
            //{
            //    contact = Sitecore.Modules.EmailCampaign.Contact.GetAnonymousFromEmail(EmailAddress, managerRoot);
            //}
            //if (contact != null && contact.Profile != null)
            //{
                //contact.Profile.FullName = emailName;

                //Fetch message and get message item
                //var itmMessage = emailId;
                //var mi = Factory.GetMessage(itmMessage);

                //get sending manager
                //var sm = new AsyncSendingManager(mi);

                //SendStandardmessage for triggered message
                //var result = sm.SendStandardMessage(contact);
            //}
            //else
            //{
                //Log.Error(String.Format("Error Sending Email, contact or profile was null, Email: {0}, EmailName: {1}", EmailAddress, emailName), this);
            //}
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            Restart();
        }

    }
}