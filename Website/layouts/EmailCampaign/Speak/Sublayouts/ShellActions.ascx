<%@ Control Language="C#" AutoEventWireup="true" Inherits="Sitecore.Modules.EmailCampaign.Speak.Sublayouts.ShellActions" %>

<%@ Import Namespace="Sitecore" %>
<%@ Import Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.Core" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.UI.WebControls" Assembly="Sitecore.EmailCampaign.App" %>


 
<% if (UIUtil.IsIE()) {
 %>
<script type="text/JavaScript" language="javascript" src="/sitecore/shell/controls/InternetExplorer.js"></script>
<%} else { %>
<script type="text/JavaScript" language="javascript" src="/sitecore/shell/controls/gecko.js"></script>
<% } %>
<script type="text/JavaScript">
    scBrowser.prototype.initialize = function () {
    }

    function updateMyControls(event) {
        $.netajax($('#<%= this.Updater.ClientID %>'), event);
    }
</script>
<% if (UIUtil.IsIE()) { %>
<script type="text/javascript" src="/sitecore modules/shell/emailcampaign/ui/speak/scripts/sc.InternetExplorer.overrides.js"></script>
<% }  %>
<script type="text/JavaScript" language="javascript" src="/sitecore/shell/controls/Sitecore.js"></script>
<script type="text/JavaScript" language="javascript" src="<%=SpeakConstants.ScriptsRoot %>spinner.js"></script>
<script type="text/JavaScript" language="javascript" src="<%=SpeakConstants.ScriptsRoot %>shellactions.js"></script>


<sc:ShellUpdater id="Updater" runat="server" />
<sc:ajaxscriptmanager id="AjaxScriptManager1" runat="server" />
<sc:continuationmanager id="ContinuationManager1" runat="server" />
