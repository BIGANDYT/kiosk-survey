<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Signup.ascx.cs" Inherits="Website.Layout.SubLayout.Signup" %>
<div class="row-fluid">
    <div class="span10 offset1">
        <div class="title">
            Give your full details to email a comprehensive report that is tailored to you.
        </div>
    </div>
</div>
<div class="row-fluid">
    <div class="span2 offset1">
        <div class="signup">
            Name
        </div>
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
    <div class="span2 offset1">
        <div class="signup">
            Company
        </div>
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
    <div class="span2 offset1">
        <div class="signup">
            Job Title
        </div>
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
    <div class="span2 offset1">
        <div class="signup">
            Email
        </div>
    </div>
    <div class="span6">
        <div class="signupinput">
            <input class="input-xxlarge" runat="server" id="Email" autocomplete="off" type="email" required>
        </div>
    </div>
    <div class="span2">
        <asp:Button class="emailbutton" ID="Buttonlink" Text="Email Report" OnClick="Email_Click" runat="server" />
    </div>
    <div class="row-fluid">
        <div class="span4">
            <a class="emailbutton" href="<%=Sitecore.Context.Site.StartPath %>">Restart</a>
        </div>
    </div>
</div>