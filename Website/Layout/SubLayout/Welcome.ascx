<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>


<div class="row-fluid">
    <div class="span6 welcomealign">
        <h1 class="welcome">CUSTOMER<br />
            EXPERIENCE<br />
            MATURITY<br />
            ASSESSMENT
        </h1>
    </div>
    <div class="span6 welcomebutton">
        <asp:Button class="emailbutton" ID="Buttonlink" Text="Start &raquo;" OnClick="Buttonlink_Click" runat="server" />
    </div>
</div>
