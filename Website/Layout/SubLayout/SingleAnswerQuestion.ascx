<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SingleAnswerQuestion.ascx.cs" Inherits="Website.Layout.SubLayout.SingleAnswerQuestion" %>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<div class="row top-buffer">
    <div class="btn-group-lg" data-toggle="buttons-radio">
        <% for (var i = 0; i < items.Length; i++)
           { %>
        <div class="col-xs-12 col-sm-5 col-sm-offset-1">
            <div class="row top-buffer">
                <div class="col-xs-12">
                    <button type="button" id="<%= items[i].ID %>" class="btn btn-default btn-lg btn-block btn-block-sm">
                        <%= items[i]["answer"] %>
                    </button>
                </div>
            </div>
        </div>
        <%if (i + 1 < items.Length)
          {%>
        <div class="col-xs-12 col-sm-5">
            <div class="row top-buffer">
                <div class="col-xs-12">
                    <button type="button" id="<%= items[i+1].ID %>" class="btn btn-default btn-lg btn-block btn-block-sm">
                        <%= items[i+1]["answer"] %>
                    </button>
                </div>
            </div>
        </div>

        <%i++;
          }
           } %>
    </div>
</div>
<form id="form1" runat="server">
     <div class="row top-buffer">
        <div class="col-xs-6 col-sm-3 col-sm-offset-1">
            <asp:Button class="btn-xlg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-7" style="text-align: right">
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
