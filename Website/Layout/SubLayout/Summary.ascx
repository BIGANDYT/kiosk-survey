<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Summary.ascx.cs" Inherits="Website.Layout.SubLayout.Summary" %>
<head>
    <script src="/assets/js/attendee/attendee.js"></script>
</head>
<div class="row">
    <div class="col-xs-6">
        <img class="img-responsive" src="/assets/img/arrows.png" />
    </div>
    <div class="col-xs-4 col-xs-offset-2">
        <img class="img-responsive" src="/assets/img/progress_f.png" />
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-2 col-sm-offset-1">
         <input type="text" class="dial">
         <input id="stopper" type="hidden" runat="server">
    </div>
    <div class="col-xs-12  col-sm-8">
        <div class="col-xs-12">
            <div id="Heading" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="Description" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="SubHeading" runat="server"></div>
        </div>
        <div class="col-xs-12">
            <div id="SubDescription" runat="server"></div>
        </div>
    </div>
</div>
<form id="form2" runat="server">
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-lg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-12 col-sm-5 col-md-5">
            <asp:Button class="btn-lg btn-success" ID="Next" Text="Give Me My Full Report" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
    <script>
        $(function () {
            $(".dial").knob();
        });        
    </script>
</form>






