<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="MultiAnswerQuestion.ascx.cs" Inherits="Website.Layout.SubLayout.MultiAnswerQuestion" %>
<div class="row">
    <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3>
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
        </h3>
    </div>
</div>
<form id="form1" runat="server">
    <div class="row">
        <div class="btn-group-lg" data-toggle="buttons-radio">
            <% for (var i = 0; i < items.Length; i++)
               { %>
            <div class="col-xs-12 col-sm-4 col-sm-offset-2">
                <div class="row top-buffer">
                    <div class="col-xs-12">
                        <button type="button" id="<%= items[i].ID %>" class="btn btn-default btn-lg btn-block btn-block-lg">
                            <%= items[i]["answer"] %>
                        </button>
                    </div>
                </div>
            </div>
            <%if (i + 1 < items.Length)
              {%>
            <div class="col-xs-12 col-sm-4">
                <div class="row top-buffer">
                    <div class="col-xs-12">
                        <button type="button" id="<%= items[i].ID %>" class="btn btn-default btn-lg btn-block btn-block-lg">
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
    <div class="row top-buffer">
        <div class="col-xs-6 col-sm-3 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align: right">
            <asp:Button class="btn-xlg btn-success" ID="Next" Text="Next" OnCommand="Next_Click" OnClientClick="getChecked()" runat="server" />
        </div>
    </div>
    <input type="hidden" name="buttonvalue" id="buttonvalue" />
</form>
<div>
</div>
<script>
    $(".btn-group-lg button").click(function () {
        $(this).toggleClass("btn-danger");
    });
    function getChecked() {
        var checkedButtons = new Array();
        $("button").each(function (i) {
            if ($(this).hasClass("btn-danger")) {
                checkedButtons.push(this.id);
            }
        });
        $("input[name=buttonvalue]").val(checkedButtons.toString());
    }
</script>
