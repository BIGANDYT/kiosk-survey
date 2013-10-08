<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row-fluid">
    <div class="span12 text-left">
        <img src="/assets/img/sitecore-red.png" style="padding-bottom: 30px!important;" height="160" />
        <h1 class="welcome">CUSTOMER EXPERIENCE<br />
            MATURITY ASSESSMENT
        </h1>
        <h2 class="welcome">What's your organisation's approach to customer experience management?
        </h2>
    </div>
</div>
<div class="row-fluid text-left">   
        <div style="float:left; margin-top:100px; margin-right:150px;">
            <asp:Button class="welcomeemailbutton emailbutton" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" />
        </div>
        <div>
            <img src="/assets/img/amazon-com-logo.png" style="width: 25%; height: 25%" />
        </div>
    
</div>
