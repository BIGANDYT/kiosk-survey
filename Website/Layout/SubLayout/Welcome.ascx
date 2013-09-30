<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row-fluid">
    <div class="span6 text-left">
        <h1 class="welcome">CUSTOMER<br />
            EXPERIENCE<br />
            MATURITY<br />
            ASSESSMENT
        </h1>
    </div>
    <div class="span6 welcomebutton">
        <asp:Button class="welcomeemailbutton emailbutton" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" />
    </div>
</div>
