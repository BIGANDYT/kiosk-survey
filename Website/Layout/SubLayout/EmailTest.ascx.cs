using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using Sitecore.Modules.EmailCampaign;

namespace Website.Layout.SubLayout
{
    public class EmailTest : System.Web.UI.UserControl
    {
        protected void SendEmail_Click(object sender, EventArgs e)
        {
            //Fetch message and get message item
            //var itmMessage = Sitecore.Context.Database.GetItem("{AF16E079-3565-4AC1-A8A8-8A1B73506C7D}");
            //var mi = Factory.GetMessage(itmMessage);

            // CREAT VIRTUAL USER
            //Sitecore.Security.Accounts.User virtualUser = Sitecore.Security.Authentication.AuthenticationManager.BuildVirtualUser("anthony", true);
            //virtualUser.Profile.Email = "anthonyhook55@gmail.com";
            
            //Fetch contact
            //var managerRootID = Sitecore.Context.Data.Database.GetItem("{8021493A-C5FE-4582-BE97-3F137295C432}");

            //ManagerRoot managerRoot = Sitecore.Modules.EmailCampaign.ManagerRoot.FromItem(managerRootID);
            //var contact = Sitecore.Modules.EmailCampaign.Contact.GetAnonymousFromEmail("anthonyhook55@gmail.com", managerRoot);

            //get sending manager
            //var sm = new AsyncSendingManager(mi);

            //add custom replacement tokens, in this example the $custommsg$ in the mail will be replaced with "dit is een test"
            //mi.CustomPersonTokens.Add("custommsg","replacemnttext");

            //SendStandardmessage for triggered message
            //var result = sm.SendStandardMessage(contact);
        }
    }
}