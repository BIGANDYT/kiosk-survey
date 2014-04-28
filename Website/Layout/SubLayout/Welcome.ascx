<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row">
    <div class="col-xs-3 pull-right">
        <img class="img-responsive" src="/assets/img/Logo Black with tagline.png" style="padding:30px;" />
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h3><strong>What's your organisation's approach to customer experience management?</strong></h3>
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h2><strong>CUSTOMER EXPERIENCE MATURITY ASSESSMENT</strong></h2>
    </div>
</div>
<div class="row">
    <div class="colxs-12 col-sm-5 col-sm-offset-1" style="padding-top: 2%;">
        <form id="form1" runat="server">
		<asp:Button class="btn-jumbo btn-success btn-block" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" style="height:300px; background-color:#008998;border-color:#008998;"/>
        </form>
    </div>
    <div class="col-xs-12 col-sm-5 col-sm-offset-1">        
        <asp:Image class="img-responsive" ID="PrizeImage" runat="server"/>
    </div>
</div>
