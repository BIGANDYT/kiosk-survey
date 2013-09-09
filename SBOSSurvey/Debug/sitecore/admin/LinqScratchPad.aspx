﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LinqScratchPad.aspx.cs" Inherits="Sitecore.Buckets.Client.sitecore.admin.LinqScratchPad" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Linq to Sitecore ScratchPad</title>
    <link href="/sitecore/shell/themes/standard/default/WebFramework.css" rel="Stylesheet" />
    <link href="/sitecore/admin/Wizard/UpdateInstallationWizard.css" rel="Stylesheet" />

    <script type="text/javascript" src="/sitecore/shell/Controls/lib/jQuery/jquery.js"></script>

    <script type="text/javascript" src="/sitecore/shell/controls/webframework/webframework.js"></script>
    	<script src="../../sitecore/shell/Applications/Buckets/Scripts/jquery-linedtextarea.js"></script>
	<link href="../../sitecore/shell/Applications/Buckets/Styles/jquery-linedtextarea.css" type="text/css" rel="stylesheet" />

 
</head>
<body>

    <form id="form1" class="wf-container" runat="server">
        <div>
            <div>
                <asp:TextBox ID="LinqQuery" runat="server" Class="lined" Height="659px" Width="851px" TextMode="MultiLine" Font-Size="11px">
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Linq;
    using System.Web;
    using Sitecore.ContentSearch.SearchTypes;
    using Sitecore.Buckets.Extensions;
    using Sitecore.Buckets.Interfaces;
    using Sitecore.Buckets.Search;
    using Sitecore.Buckets.Search.Tags;
    using Sitecore.Configuration;
    using Sitecore.ContentSearch;
    using Sitecore.ContentSearch.Utilities;
    using Sitecore.Data;
    using Sitecore.Data.Fields;
    using Sitecore.Data.Items;
    using Sitecore.Globalization;
    using Sitecore.SecurityModel;
    using Sitecore.Sites;
    using Sitecore.Web;
    using Sitecore;


    using Constants = Sitecore.Buckets.Util.Constants;
    using ContentSearchManager = Sitecore.ContentSearch.ContentSearchManager;
                     
    namespace Test {
                    
       class Program {
                       private static Stopwatch stopWatch = new Stopwatch();
                        public static IEnumerable&lt;SearchResultItem&gt; Main(string str)
                        {
                            using (var context = ContentSearchManager.GetIndex(&quot;sitecore_master_index&quot;).CreateSearchContext())
                            {
                                return context.GetQueryable&lt;SearchResultItem&gt;().Take(10).ToList();
                            }
                        }
                    
                        public static string RunTimer(string str) {
                        return stopWatch.ElapsedMilliseconds.ToString();
                        }
                    }
                  }
                </asp:TextBox>
            </div>
            <div class="wf-footer">
                <asp:Button ID="btnBack" CssClass="wf-backbutton" Text="Reset" runat="server" />
                    <asp:Button ID="clrButton" Text="Clear" runat="server" OnClick="clrButton_Click" />
                <asp:Button ID="btnNext" Text="Run" runat="server" OnClick="btnNext_Click" />
            </div>
            <div class="wf-footer">
                <asp:Literal ID="Output" runat="server"></asp:Literal>
                <asp:Label ID="Error" runat="server"></asp:Label>
            </div>
        </div>
        <div>
        </div>
        <div class="wf-content" style="padding: 2em 100px 0 32px;">
            <asp:Label ID="lblError" CssClass="Error" Visible="false" runat="server"></asp:Label>
            <h1 runat="server" id="lblHeader"></h1>
            <asp:GridView ID="GridResults" runat="server" BackColor="White" BorderColor="Gray" Width="800">
                <AlternatingRowStyle BackColor="Silver" />
                <HeaderStyle BackColor="Gray" />
                <RowStyle Width="600px" />
            </asp:GridView>

        </div>

    </form>
</body>
    
    <script>
        jQuery(function () {
            jQuery(".lined").linedtextarea(
                { selectedLine: 1 }
            );
        });
</script>

</html>
