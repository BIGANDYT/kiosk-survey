﻿<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Welcome.ascx.cs" Inherits="Website.Layout.SubLayout.Welcome" %>
<div class="row">
    <div class="col-xs-12">
        <img class="img-responsive" src="/assets/img/rowfit.png" />
    </div>
</div>
<div class="row">
    <div class="col-xs-6 col-xs-offset-1">
        <img class="img-responsive" src="/assets/img/sitecore-red.png" />
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h1><strong>CUSTOMER EXPERIENCE MATURITY ASSESSMENT</strong></h1>
    </div>
</div>
<div class="row">
    <div class="col-xs-11 col-xs-offset-1">
        <h3><strong>What's your organisation's approach to customer experience management?</strong></h3>
    </div>
</div>
<div class="row">
    <div class="colxs-12 col-sm-5 col-sm-offset-1" style="padding-top: 5%; ">
        <form id="form1" runat="server">
        <asp:Button class="btn-xlg btn-success btn-block btn-jumbo" ID="Buttonlink" Text="Take it now" OnClick="Buttonlink_Click" runat="server" />
        </form>
    </div>
    <div class="col-xs-12 col-sm-5 col-sm-offset-1">        
        <asp:Image class="img-responsive" ID="PrizeImage" runat="server"/>
    </div>
</div>
