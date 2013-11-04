<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="SingleAnswerQuestionPicture.ascx.cs" Inherits="Website.Layout.SubLayout.SingleAnswerQuestionPicture" %>

<div class="row">
    <div class="col-xs-6">
        <img class="img-responsive" src="/assets/img/arrows.png" />
    </div>
    <div class="col-xs-4 col-xs-offset-2">
        <img class="img-responsive" src="/assets/img/progress.png" />
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-10 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="btn-group-lg" data-toggle="buttons-radio">
    <% foreach (var answer in items)
       { %>
    <div class="row">
        <div class="col-xs-12 col-sm-<%= answer["height"] %> col-sm-offset-2">
            <div id="<%= answer.ID %>" style="color: <%= answer["color"] %>; margin-bottom: 0em; " class="panel panel-default">
                <div style="color:white;background-color: <%= answer["color"] %>;" class="panel-heading"><%= answer["AlternateHeading"] %></div>
                <div class="panel-body">
                    <%= answer["ModelText"] %>
                </div>
            </div>
        </div>
    </div>
    <%} %>
</div>
<form id="form1" runat="server">
    <div class="row">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-lg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align: right">
            <asp:Button class="btn-lg btn-success" ID="Next" Text="Next" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>
<div>
</div>
<script>
    $(".panel").click(function () {
        $("input[name=buttonvalue]").val(this.id);
        $(".panel-body").css("background-color", "white");
        $(".panel-body").css("color", "inherit");
        $(".panel-heading").css("color", "white");
        $(".panel-heading").css("font-weight", "normal");
        $(this).find(".panel-heading").css("color", "black");
        $(this).find(".panel-heading").css("font-weight", "bolder");
        $(this).find(".panel-body").css("background-color", "red");
        $(this).find(".panel-body").css("color", "white");
    });
</script>
