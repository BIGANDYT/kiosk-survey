<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Finished.ascx.cs" Inherits="Website.Layout.SubLayout.Finished" %>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h2>
            <sc:FieldRenderer ID="Title" FieldName="Title" runat="server" />
        </h2>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="Subtitle" FieldName="Subtitle" runat="server" />
        </h3>
    </div>
</div>
 <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2" ID="PrizeText" runat="server">
        </div>
    </div>
<div class="row top-buffer">
    <div class="col-xs-12 col-sm-3 col-sm-offset-2">
        <asp:Image class="img-responsive" ID="PrizeImage" runat="server"/>
    </div>
    <div class="col-xs-12 col-sm-6">
        <form id="form1" runat="server">
            <asp:Button class="btn-xlg btn-success btn-block btn-jumbo" ID="Buttonlink" Text="Next User Click Here" OnClick="Restart_Click" runat="server" />
        </form>
    </div>
</div>
