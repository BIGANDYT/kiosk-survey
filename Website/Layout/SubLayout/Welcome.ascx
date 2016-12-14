<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row">
    <div class="col-xs-12">
        <img class="img-responsive" src="/assets/img/logo.svg" style="padding:30px;" />
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h2>What's your organisation's approach to customer experience management?</h2>
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h1>CUSTOMER EXPERIENCE MATURITY ASSESSMENT</h1>
    </div>
</div>
<div class="row">
    <div class="colxs-12 col-sm-5 col-sm-offset-1" style="padding-top: 2%;">
        <form id="form1" runat="server">
		<asp:Button class="btn-jumbo btn-success btn-block btn-survey" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" style="height:300px;"/>
        </form>
    </div>
    <div class="col-xs-12 col-sm-5 col-sm-offset-1">        
        <asp:Image class="img-responsive" ID="PrizeImage" runat="server"/>
    </div>
</div>
