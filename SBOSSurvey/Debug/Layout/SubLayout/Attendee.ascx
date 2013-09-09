<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attendee.ascx.cs" Inherits="Website.Layout.SubLayout.Attendee" %>
<body style="background-color: white">
    <div style="z-index: 3; position: absolute; left: 146px; top: 260px">
        <div>
            <input id="andythompson" style="text-align: center; width: 225px; border: none; color: red; font-family: 'Fjalla One', sans-serif; font-size: 60px;" type="text">
            <input id="stopper" type="hidden" runat="server">
        </div>
    </div>
    <div style="z-index: 2; position: absolute; left: 52px; top: 48px">
        <input id="dial" type="text" class="dial">
    </div>
    <div style="z-index: 1; position: absolute; left: 10px; top: 0px">
        <img style="min-width: 600px; height: 600px;" src="/assets/img/lgo.png" />
    </div>
    <div id="andythompson2" style="z-index: 1; position: absolute; left: 600px; top: 20px; height: 800px; width: 800px;">
        <div style="height:50px; width:650px; font-size: 30px; line-height: 30px; margin:5px; ">
            <div id="Heading" runat="server"></div>
        </div>
        <div style="height:100px; width:650px; font-size: 20px; line-height: 30px; margin:5px; ">
            <div id="Description" runat="server"></div>
        </div>
        <div style="height:50px; width:650px; font-size: 30px; line-height: 30px; margin:5px; ">
            <div id="SubHeading" runat="server"></div>
        </div>
        <div style="height:200px; width:650px; font-size: 20px; line-height: 30px; margin:5px; ">
            <div id="SubDescription" runat="server"></div>
        </div>
    </div>
</body>
