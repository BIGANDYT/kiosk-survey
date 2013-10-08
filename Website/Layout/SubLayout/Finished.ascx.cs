using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.Modules.EmailCampaign;
using Website.model;
using System.Web.UI.WebControls;

namespace Website.Layout.SubLayout
{
    public partial class Finished : Survey
    {

        // Email Constants
        private Item Email1Init = Sitecore.Context.Database.GetItem("{AF16E079-3565-4AC1-A8A8-8A1B73506C7D}");
        private Item Email2Radi = Sitecore.Context.Database.GetItem("{A3E4831C-C36C-4539-B4CA-968F17620513}");
        private Item Email3Alig = Sitecore.Context.Database.GetItem("{2E89CD57-426E-4E24-A71A-81FD1D901C26}");
        private Item Email4Opti = Sitecore.Context.Database.GetItem("{7210D193-AE45-4F05-95CA-43B670EFC4C5}");
        private Item Email5Nurt = Sitecore.Context.Database.GetItem("{C37B7713-769E-4C93-AF89-11CA35CE241D}");
        private Item Email6Enga = Sitecore.Context.Database.GetItem("{64716F69-EC72-4E3D-857C-CB015CDB5252}");
        private Item Email7Life = Sitecore.Context.Database.GetItem("{2AB56DDC-B4F9-4FE2-AE89-E7341E79B97E}");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetCurrentUser();
                var currentUserMaturity = CurrentUser["Qualifier"].ToString();
                var currentUserEmailAdd = CurrentUser["Email"].ToString();
                var currentUserName = CurrentUser["Name"].ToString();

                switch (currentUserMaturity)
                {
                    case "Initiator": //Initiate
                        SendEmail(Email1Init, currentUserEmailAdd, currentUserName);
                        break;
                    case "Promoter": //Radiate
                        SendEmail(Email2Radi, currentUserEmailAdd, currentUserName);
                        break;
                    case "Aligner": //Align
                        SendEmail(Email3Alig, currentUserEmailAdd, currentUserName);
                        break;
                    case "Optimizer": //Optimise
                        SendEmail(Email4Opti, currentUserEmailAdd, currentUserName);
                        break;
                    case "Nurturer": //Nurture
                        SendEmail(Email5Nurt, currentUserEmailAdd, currentUserName);
                        break;
                    case "Engager": //Engage
                        SendEmail(Email6Enga, currentUserEmailAdd, currentUserName);
                        break;
                    case "Lifetime Customer Champion": //Lifetime
                        SendEmail(Email7Life, currentUserEmailAdd, currentUserName);
                        break;
                    default:
                        break;
                }
            }
        }

        private void SendEmail(Item emailId, string EmailAddress, string emailName)
        {
            // Define the manager root LIVE: {8021493A-C5FE-4582-BE97-3F137295C432}
            var managerRootItem = Sitecore.Context.Database.GetItem("{8021493A-C5FE-4582-BE97-3F137295C432}");
            var managerRoot = Factory.GetManagerRootFromItem(managerRootItem);

            // Get a fake account on the go and pass in the email address
            var contact = Sitecore.Modules.EmailCampaign.Contact.GetAnonymousFromEmail(EmailAddress, managerRoot);
            if (contact != null && contact.Profile != null)
            {
                contact.Profile.FullName = emailName;

                //Fetch message and get message item
                var itmMessage = emailId;
                var mi = Factory.GetMessage(itmMessage);

                //get sending manager
                var sm = new AsyncSendingManager(mi);

                //SendStandardmessage for triggered message
                var result = sm.SendStandardMessage(contact);
            }
            else
            {
                Log.Error(String.Format("Error Sending Email, contact or profile was null, Email: {0}, EmailName: {1}", EmailAddress, emailName), this);
            }
        }

        protected void Restart_Click(object sender, EventArgs e)
        {
            Restart();
        }

    }
}