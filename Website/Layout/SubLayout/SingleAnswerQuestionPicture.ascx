<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="SingleAnswerQuestionPicture.ascx.cs" Inherits="Website.Layout.SubLayout.SingleAnswerQuestionPicture" %>
<div class="row question">
    <div class="col-xs-12 col-sm-10 col-sm-offset-1">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="btn-group-lg" data-toggle="buttons-radio">
    <% foreach (var answer in items)
       { %>
    <div id="<%= answer.ID %>" class="row answer top-buffer-xs">        
        <div style="background-color: <%= answer["color"] %>;" class="col-xs-12 col-sm-<%= Convert.ToInt32(answer["height"]) - 2 %> mmodelheader">
            <span><%= answer["AlternateHeading"] %></span>
        </div>
        <div class="col-xs-12 col-sm-<%= 14 - Convert.ToInt32(answer["height"]) %> mmodelcontent">
            <span><%= answer["ModelText"] %></span>
        </div>
    </div>
    <%} %>
</div>
<form id="form1" runat="server">
    <div class="row top-buffer-sm">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-survey" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-6" style="text-align: right">
            <asp:Button class="btn-xlg btn-survey" ID="Next" Text="Next" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>
<div>
</div>
<script>
    $(".answer").click(function () {
        $("input[name=buttonvalue]").val(this.id);
        $(".mmodelcontent").css("color", "black");
        $(".mmodelcontent").css("background-color", "white");
        $(this).find(".mmodelcontent").css("background-color", "rgb(101, 31, 118)");
        $(this).find(".mmodelcontent").css("color", "white");
    });
</script>
