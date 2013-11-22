<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Signup.ascx.cs" Inherits="Website.Layout.SubLayout.Signup" %>
<form id="form1" runat="server">    
    <div class="row">
        <div class="col-xs-12 col-sm-10 col-sm-offset-2" id="SignupTitle" runat="server">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2" id="Subtitle" runat="server">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2" id="PrizeText" runat="server">
        </div>
    </div>
    <div class="row top-buffer">
        <div class="col-xs-12 col-sm-3 col-sm-offset-1">
            <asp:Image class="img-responsive" ID="PrizeImage" runat="server"/>
        </div>
        <div class="col-xs-12 col-sm-8">
            <div class="row">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Name
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" id="Name" autocomplete="off" runat="server" clientidmode="Static" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Company
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" runat="server" id="Company" autocomplete="off" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Job Title
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" runat="server" id="JobTitle" autocomplete="off" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Email
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" runat="server" id="Email" autocomplete="off" type="email" required>
                </div>
            </div>
        </div>
    </div>
    <div class="row top-buffer">
        <div class="col-xs-6 col-sm-4 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success" ID="Button1" Text="Restart" OnClick="Restart_Click" OnClientClick="forcesubmit()" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align: right">
            <asp:Button class="btn-xlg btn-success" ID="Buttonlink" Text="Start" OnClick="Email_Click" runat="server" />
        </div>
    </div>
</form>
<script>
    function forcesubmit() {
        $('input').removeAttr("required")
    }
</script>
