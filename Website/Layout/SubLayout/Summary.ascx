<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Summary.ascx.cs" Inherits="Website.Layout.SubLayout.Summary" %>
<script src="/assets/js/knob/summary.js"></script>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-3 col-sm-offset-1 dialwrapper">
        <div class="dialwrapper-inner">
            <input id="knob" class="knob" data-width="100%">
        </div>
        <input id="stopper" type="hidden" runat="server">
    </div>
    <div class="col-xs-12  col-sm-7 summarytext">
        <div class="col-xs-12">
            <div id="Heading" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="Description" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="SubHeading" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="SubDescription" runat="server"></div>
        </div>
    </div>
</div>
<form id="form2" runat="server">
    <div class="row top-buffer">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success btn-block" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-12 col-sm-5 col-sm-offset-1">
            <asp:Button class="btn-xlg btn-success btn-block " ID="Next" Text="Give Me My Full Report" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>