<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Signup.ascx.cs" Inherits="Website.Layout.SubLayout.Signup" %>
<div class="row-fluid">
    <div class="span10 offset1 text-left">
        <h1 class="signup"><sc:FieldRenderer ID="Title" FieldName="Title" runat="server" />
        </h1>
        <h2 class="signup"><sc:FieldRenderer ID="Subtitle" FieldName="Subtitle" runat="server" />
        </h2>
    </div>
</div>
<div class="row-fluid">
    <div class="span3">
        <div class="row-fluid">
                <img src="/assets/img/amazon-com-logo.png" />
        </div>
    </div>
    <div class="span9">
        <div class="row-fluid">
            <div class="span2 text-right signup">
                    Name
            </div>
            <div class="span6">
                <div class="signupinput">
                    <input class="input-xxlarge" type="text" runat="server" id="Name" autocomplete="off" required>
                </div>
            </div>
            <div class="span2">
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2 text-right signup">
                    Company
            </div>
            <div class="span6">
                <div class="signupinput">
                    <input class="input-xxlarge" type="text" runat="server" id="Company" autocomplete="off" required>
                </div>
            </div>
            <div class="span2">
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2 text-right signup">
                    Job Title
            </div>
            <div class="span6">
                <div class="signupinput">
                    <input class="input-xxlarge" type="text" runat="server" id="JobTitle" autocomplete="off" required>
                </div>
            </div>
            <div class="span2">
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2 text-right signup">
                    Email
            </div>
            <div class="span6">
                <div class="signupinput">
                    <input class="input-xxlarge" runat="server" id="Email" autocomplete="off" type="email" required>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row-fluid">
    <div class="span4 offset2" onclick="forcesubmit()">
        <asp:Button class="emailbutton" ID="Button1" Text="Restart" OnClick="Restart_Click" runat="server" />
    </div>
    <div class="span4 offset1 text-right">
        <asp:Button class="emailbutton" ID="Buttonlink" Text="Start" OnClick="Email_Click" runat="server" />
    </div>
</div>
<script>
    function forcesubmit() {
        $('input').removeAttr("required")
    }
</script>
