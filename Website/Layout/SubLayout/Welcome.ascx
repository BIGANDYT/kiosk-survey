<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row-fluid">
    <div class="span6 text-left">
        <img src="/assets/img/sitecore-red.png" style="padding-bottom:30px!important;" height="160" />
        <h1 class="welcome">
            CUSTOMER EXPERIENCE<br />
            MATURITY ASSESSMENT
        </h1>
        <h2 class="welcome">
            What's your organisation's approach to customer experience management?
        </h2>
    </div>
    <div class="span6 welcomebutton">
        <asp:Button class="welcomeemailbutton emailbutton" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" />
    </div>
</div>
