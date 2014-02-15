<%@ Control Language="c#" AutoEventWireup="true" EnableViewState="false" CodeBehind="SpamCheck.ascx.cs" Inherits="Sitecore.Modules.EmailCampaign.Speak.Sublayouts.SpamCheck" %>
<%@ Import Namespace="Sitecore.Modules.EmailCampaign.Core" %>
<%@ Import Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.Core" %>
<%@ Import Namespace="Sitecore.Web" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.UI.WebControls" Assembly="Sitecore.EmailCampaign.App" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.Controls.Miscellaneous" Assembly="Sitecore.Client.Extensions" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.WebControls" Assembly="Sitecore.Client.Extensions" %>

<script type="text/javascript">
    function ecmSpamCheckUpdateSelectedVariant(sender) {
        var parent = sender == null ? $('#spamCheckTopPanel').find('.abn-button:first').parent() : $(sender).parent();

        var variantToCheck = $('#spamCheckVariantToPreview');
        var preview = variantToCheck.children('div:first');
        preview.empty();
        parent.children('.abn-button-active').each(function () { preview.append($(this).html()); });
        if (preview.is(':empty')) {
            variantToCheck.children('span:first').hide();
        }
        else {
            variantToCheck.children('span:first').show();
        }
    }
    function ecmSpamCheckSelectAllVariants() {
        var selectVariantGroup = $('#spamCheckTopPanel').find('.select-variant-group');
        if (selectVariantGroup == null) {
            return;
        }
        selectVariantGroup.find('.abn-button').addClass('abn-button-active');

        var value = '';

        selectVariantGroup.find('.abn-button-active').each(function () { value += (value.length === 0 ? '' : ',') + $(this).index(); });
        selectVariantGroup.find('input:first').val(value);
    }

    function ecmSpamCheckOptionsSelected() {
        var input = $('input[name^="<%= this.UniqueID %>"][name$="Checkboxes"]')[0];
      return input.value.length != 0;
  }

  $(document).ready(function () {
      var parentId = "<%= this.SpamCheckPanel.ClientID %>";
      var controlId = "<%= this.InitializeOptions.ClientID %>";
      var key = "<%= WebUtil.GetRawUrl() %>";
      var mode = "<%= this.CurrentMode %>";
      PreviewUpdater.openAccordions(parentId);
      PreviewUpdater.checkRefresher(parentId, controlId, key, mode);

      var button = $('#' + "<%= this.RunTest.ClientID %>");
      button.on('click', function () {
          if (!ecmSpamCheckOptionsSelected()) {
              button.spinner('hide');
              $('body').triggerHandler("messagesend", {
                  "text": "<%= EcmTexts.Localize(EcmTexts.SelectSpamFilterFirst) %>",
                  "type": "info",
                  "sticky": false
              });
          }
      });
      ecmSpamCheckSelectAllVariants();
  });
</script>

<asp:Panel runat="server" ID="SpamCheckPanel">
    <asp:HiddenField ID="SpamCheckProcessingMarker" runat="server" />
    <asp:HiddenField ID="Report" Value="" runat="server" />
    <div id="spamCheckTopPanel" class="review-top-panel">
        <div id="MessageContainer" runat="server" visible="False">
            <asp:Label runat="server" ID="MessageLabel"></asp:Label>
        </div>
        <div id="SelectVariantContainer" enableviewstate="False" runat="server">
            <sc:SelectVariantGroup ID="VariantsList" OnClientClick="ecmSpamCheckUpdateSelectedVariant(this);" CssClass="select-variant-group" runat="server" />
        </div>
        <asp:Panel runat="server" ID="PreviewPanel" class="preview-panel">
            <div>
                <sc:AjaxButton ID="RunTest" CssClass="sc-button sc-button-important" OnClientClick="if(!ecmSpamCheckOptionsSelected()) return false;$('#' + this.id).attr('disabled','disabled');" OnClick="RunTestClick" Style="float: left;" runat="server" />
                <sc:Spinner ID="RunTestSpinner" runat="server" TargetControlId="RunTest" IsEndless="True" Type="inline" />
                <sc:AjaxButton runat="server" ID="InitializeOptions" Style="display: none" OnClick="InitializeSacOptions" />
                <sc:AjaxButton runat="server" ID="OpenReport" Style="display: none" OnClick="OpenReportClicked" />
                <div id="OptionsContainer" enableviewstate="False" runat="server" style="float: right; margin-right: 5px;">
                    <sc:OptionsDropPanel ID="OptionsList" Name="Name" Value="Id" runat="server" />
                </div>
                <div id="ReportsContainer" runat="server" style="float: right; margin-right: 5px;"></div>
            </div>
            <div id="spamCheckVariantToPreview" class="selcted-variant">
                <span><%=EcmTexts.Localize(EcmSpeakTexts.CheckVariants)%></span>
                <div style="display: inline;"></div>
            </div>
        </asp:Panel>
    </div>
    <div id="ResultsContainer" enableviewstate="False" runat="server">
        <sc:FastQueryDataSource ID="VariantsSource" runat="server" />
        <sc:ABNPreviewTest ID="CheckResults" runat="server" />
    </div>
</asp:Panel>

