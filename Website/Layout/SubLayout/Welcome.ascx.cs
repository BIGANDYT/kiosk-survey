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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Sitecore.Data.Fields.ImageField imageField = Sitecore.Context.Item.Fields["PrizeImage"];
                if (imageField != null && imageField.MediaItem != null)
                {
                    Sitecore.Data.Items.MediaItem image = new Sitecore.Data.Items.MediaItem(imageField.MediaItem);
                    PrizeImage.ImageUrl = Sitecore.StringUtil.EnsurePrefix('/', Sitecore.Resources.Media.MediaManager.GetMediaUrl(image));
                }
            }
        }

        protected void Buttonlink_Click(object sender, EventArgs e)
        {
            CreateUser();
            NextPage();
        }
    }
}