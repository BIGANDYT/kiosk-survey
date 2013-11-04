<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QualifierQuestion.ascx.cs" Inherits="Website.Layout.SubLayout.QualifierQuestion" %>
<div class="row">
    <div class="col-xs-6">
        <img class="img-responsive" src="/assets/img/arrows.png" />
    </div>
    <div class="col-xs-4 col-xs-offset-2">
        <img class="img-responsive" src="/assets/img/progress.png" />
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
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <div class="btn-group-lg" data-toggle="buttons-radio">
            <% foreach (var answer in items)
               { %>
            <button type="button" id="<%= answer.ID %>" class="btn btn-default btn-lg btn-block"><%= answer["answer"] %></button>
            <%} %>
        </div>
    </div>
</div>
<form id="form1" runat="server">
    <div class="row">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align: right">
            <asp:Button class="btn-xlg btn-success" ID="Next" Text="Next" OnCommand="Next_Click" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>
<div>
    
</div>
<script>
    $(".btn-group-lg button").click(function () {
        $("input[name=buttonvalue]").val(this.id);
        $("button").removeClass("btn-danger");
        $(this).addClass("btn-danger"); 
    });
</script>
