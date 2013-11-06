<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Finished.ascx.cs" Inherits="Website.Layout.SubLayout.Finished" %>
<div class="row">
    <div class="col-xs-6">
        <img class="img-responsive" src="/assets/img/arrows.png" />
    </div>
    <div class="col-xs-4 col-xs-offset-2">
        <img class="img-responsive" src="/assets/img/progress_f.png" />
    </div>
</div>
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
    <div class="col-xs-12 col-sm-3 col-sm-offset-2">
        <img class="img-responsive" src="/assets/img/amazon-com-logo.png" />
    </div>
    <div class="col-xs-12 col-sm-6">
        <form id="form1" runat="server">
            <asp:Button class="btn-xlg btn-success" ID="Buttonlink" Text="Next User Click Here" OnClick="Restart_Click" runat="server" />
        </form>
    </div>
</div>
