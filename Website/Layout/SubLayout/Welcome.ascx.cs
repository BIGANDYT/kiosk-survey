using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Website.model;
using Sitecore.Links;

namespace Website.Layout.SubLayout
{
    public partial class Welcome : Survey
    {
        protected void Buttonlink_Click(object sender, EventArgs e)
        {
            CreateUser();
            NextPage();
        }
    }
}