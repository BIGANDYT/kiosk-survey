<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="SingleAnswerQuestionPicture.ascx.cs" Inherits="Website.Layout.SubLayout.SingleAnswerQuestionPicture" %>

<div class="row">
    <div class="col-xs-6">
        <img class="img-responsive" src="/assets/img/arrows.png" />
    </div>
    <div class="col-xs-4 col-xs-offset-2">
        <img class="img-responsive" src="/assets/img/progress_b.png" />
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-10 col-sm-offset-1">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="btn-group-lg" data-toggle="buttons-radio">
    <% foreach (var answer in items)
       { %>
    <div id="<%= answer.ID %>" style="border:3px solid <%= answer["color"] %>; color:<%= answer["color"] %>" class="row answer">
        <div style="background-color: <%= answer["color"] %>;" class="col-xs-12 col-sm-<%= Convert.ToInt32(answer["height"]) - 2 %> mmodelheader">
            <span style="font-weight:bold; display: inline-block;  vertical-align: middle; line-height: normal;"><%= answer["AlternateHeading"] %></span>
        </div>
        <div style="color: <%= answer["color"] %>;" class="col-xs-12 col-sm-<%= 14 - Convert.ToInt32(answer["height"]) %> mmodelcontent">
            <span style="display: inline-block;  vertical-align: middle; line-height: normal;"><%= answer["ModelText"] %></span>
        </div>
    </div>
    <%} %>
</div>
<form id="form1" runat="server">
    <div class="row">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-lg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-6" style="text-align: right">
            <asp:Button class="btn-lg btn-success" ID="Next" Text="Next" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>
<div>
</div>
<script>
    $(".answer").click(function () {
        $("input[name=buttonvalue]").val(this.id);
        $(".mmodelcontent").css("color", "inherit");
        $(".mmodelcontent").css("background-color", "white");
        $(this).find(".mmodelcontent").css("font-weight", "bolder");
        $(this).find(".mmodelcontent").css("background-color", "red");
        $(this).find(".mmodelcontent").css("color", "white");
    });
</script>
