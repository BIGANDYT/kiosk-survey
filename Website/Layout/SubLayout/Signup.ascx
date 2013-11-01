<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Signup.ascx.cs" Inherits="Website.Layout.SubLayout.Signup" %>
<form id="form1" runat="server">
    <div class="row">
        <div class="col-xs-6">
            <img class="img-responsive" src="/assets/img/arrows.png" />
        </div>
        <div class="col-xs-4 col-xs-offset-2">
            <img class="img-responsive" src="/assets/img/amazon-com-logo-small.png" />
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-10 col-sm-offset-2">
            <h2>
                <sc:FieldRenderer ID="Title" FieldName="Title" runat="server" />
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-10 col-sm-offset-2">
            <h4>
                <sc:FieldRenderer ID="Subtitle" FieldName="Subtitle" runat="server" />
            </h4>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2 labeltext">
            Name
        </div>
        <div class="col-xs-12 col-sm-5">
            <input class="form-control" type="text" id="Name" autocomplete="off" runat="server" clientidmode="Static" required>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2 labeltext">
            Company
        </div>
        <div class="col-xs-12 col-sm-5">
            <input class="form-control" type="text" runat="server" id="Company" autocomplete="off" required>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2 labeltext">
            Job Title
        </div>
        <div class="col-xs-12 col-sm-5">
            <input class="form-control" type="text" runat="server" id="JobTitle" autocomplete="off" required>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2 labeltext">
            Email
        </div>
        <div class="col-xs-12 col-sm-5">
            <input class="form-control" runat="server" id="Email" autocomplete="off" type="email" required>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success" ID="Button1" Text="Restart" OnClick="Restart_Click" OnClientClick="forcesubmit()" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align:right">
            <asp:Button class="btn-xlg btn-success" ID="Buttonlink" Text="Start" OnClick="Email_Click" runat="server" />
        </div>
    </div>
</form>
<script>
    function forcesubmit() {
        $('input').removeAttr("required")
    }
</script>
