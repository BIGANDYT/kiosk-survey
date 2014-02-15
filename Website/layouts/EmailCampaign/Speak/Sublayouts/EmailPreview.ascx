<%@ Control Language="c#" AutoEventWireup="true" EnableViewState="false" CodeBehind="EmailPreview.ascx.cs" Inherits="Sitecore.Modules.EmailCampaign.Speak.Sublayouts.EmailPreview" %>

<%@ Import Namespace="Sitecore.Modules.EmailCampaign.Core" %>
<%@ Import Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.Core" %>
<%@ Import Namespace="Sitecore.Web" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Modules.EmailCampaign.Speak.Web.UI.WebControls" Assembly="Sitecore.EmailCampaign.App" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.Controls.Miscellaneous" Assembly="Sitecore.Client.Extensions" %>
<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.WebControls" Assembly="Sitecore.Client.Extensions" %>

<script type="text/javascript">
  function ecmEmailPreviewUpdateSelectedVariant(sender) {
    var parent = sender == null ? $('#emailPreviewTopPanel').find('.abn-button:first').parent() : $(sender).parent();

    var variantToPreview = $('#variantToPreview');
    var preview = variantToPreview.children('div:first');
    preview.empty();
    parent.children('.abn-button-active').each(function () { preview.append($(this).html()); });
    if (preview.is(':empty')) {
      variantToPreview.children('span:first').hide();
    }
    else {
      variantToPreview.children('span:first').show();
    }
  }

  function ecmEmailPreviewSelectAllVariants() {
    var selectVariantGroup = $('#emailPreviewTopPanel').find('.select-variant-group');
    if (selectVariantGroup == null) {
      return;
    }
    selectVariantGroup.find('.abn-button').addClass('abn-button-active');

    var value = '';

    selectVariantGroup.find('.abn-button-active').each(function () { value += (value.length === 0 ? '' : ',') + $(this).index(); });
    selectVariantGroup.find('input:first').val(value);
  }

  function ecmEmailPreviewShowPopup(container, data) {
      if (data.data.image.indexOf('sitecore-loader') < 0 && data.data.image.indexOf('sign_warning') < 0) {
          var popUpRunnerId = $('[id$="EmailPreviewPopupRunner"]').attr('id').toString();
          $.netajax($('#' + popUpRunnerId), container.attr('id') + '|' + data.data.id);
    }
  }

  function ecmEmailPreviewOnButtonCheckClick(buttonClientId, selectEmailClientFirstText) {
      var input = $('input[name$="EmailPreviewOptionsList$Checkboxes"]')[0];

      var button = $('#' + buttonClientId.id);
      if (input) {
          if (!input.value.length != 0) {
              button.spinner('hide');
              $('body').triggerHandler("messagesend", {
                  "text": selectEmailClientFirstText,
                  "type": "info",
                  "sticky": false
              });
              return false;
            } else {
            button.attr('disabled','disabled');
              return true;
          }
      } else {
          button.spinner('hide');
          $('body').triggerHandler("messagesend", {
              "text": selectEmailClientFirstText,
              "type": "info",
              "sticky": false
          });
          return false;
      }
  }

  function ecmEmailPreviewStartUpScript(emailPreviewPanelId, initializeOptionsEmailPreviewId) {
      var parentId = emailPreviewPanelId;
      var controlId = initializeOptionsEmailPreviewId;

      var key = window.location.pathname.toString() + window.location.search.toString();
      var mode = "EmailPreview";

      PreviewUpdater.openAccordions(parentId);
      PreviewUpdater.checkRefresher(parentId, controlId, key, mode);
      ecmEmailPreviewSelectAllVariants();
  }
</script>

<asp:Panel ID="EmailPreviewPanel" runat="server">
  <asp:HiddenField ID="Report" runat="server" Value="" />
  <div id="emailPreviewTopPanel" class="review-top-panel">
    <div id="MessageContainer" runat="server" Visible="False">
        <asp:Label runat="server" ID="MessageLabel"></asp:Label>
    </div>
    <div id="SelectVariantContainer" EnableViewState="False" runat="server">
        <sc:SelectVariantGroup ID="VariantsList" OnClientClick="ecmEmailPreviewUpdateSelectedVariant(this);" CssClass="select-variant-group" runat="server" />
    </div>
    <asp:Panel ID="PreviewPanel" runat="server" CssClass="preview-panel">
      <div>
        <sc:ajaxbutton runat="server" ID="RunTest" OnClick="RunTestClick" UseSubmitBehavior="False" style="float: left;" cssclass="sc-button sc-button-important" />
        <sc:spinner ID="RunPreviewSpinner" runat="server" TargetControlId="RunTest" IsEndless="True" Type="inline" />
        <div id="OptionsContainer" EnableViewState="False" runat="server" style="float: right; margin-right: 5px;">
            <sc:OptionsDropPanel ID="EmailPreviewOptionsList" Name="Name" Value="Id" runat="server" />
        </div>
        <sc:AjaxButton runat="server" ID="OpenReport" Style="display: none" OnClick="OpenReportClicked" />
        <sc:ajaxbutton runat="server" ID="InitializeOptionsEmailPreview" Style="display: none" OnClick="InitializeSacOptionsEmailPreview" />
        <div id="ReportsContainer" runat="server" style="float: right; margin-right: 5px;"></div>
      </div>
      <div id="variantToPreview" class="selcted-variant">
        <span>
          <%=EcmTexts.Localize(EcmSpeakTexts.PreviewVariants)%></span>
        <div style="display: inline;"></div>
      </div>
    </asp:Panel>
  </div>
  <div id="ResultsContainer" EnableViewState="false" runat="server">
      <sc:FastQueryDataSource ID="VariantsSource" runat="server" />
      <sc:ABNPreviewTest ID="PreviewResults" runat="server"/>
  </div>
</asp:Panel>

