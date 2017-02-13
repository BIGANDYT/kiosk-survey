<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Signup.ascx.cs" Inherits="Website.Layout.SubLayout.Signup" %>

<form id="form1" runat="server">
    <div class="row">
        <div class="col-xs-12 col-sm-10 col-sm-offset-2" id="SignupTitle" runat="server">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2" id="Subtitle" runat="server">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2" id="PrizeText" runat="server">
        </div>
    </div>
    <div class="row top-buffer">
        <div class="col-xs-12">
            <div class="row">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Firstname
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" id="Firstname" autocomplete="off" runat="server" clientidmode="Static" required>
                </div>
            </div>
            <div class="row  top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Surname
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" id="Surname" autocomplete="off" runat="server" clientidmode="Static" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Company
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" runat="server" id="Company" autocomplete="off" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Job Title
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" type="text" runat="server" id="JobTitle" autocomplete="off" required>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-xs-12 col-sm-3 labeltext">
                    Email
                </div>
                <div class="col-xs-12 col-sm-7">
                    <input class="form-control" runat="server" id="Email" autocomplete="off" type="email" required>
                </div>
            </div>  
            <div class="row top-buffer">               
                <div class="col-xs-12 col-sm-offset-3 col-sm-7">
                    <div class="g-recaptcha" data-sitekey="6LfCAxMUAAAAALF4k8V2a8bqXleClyd9VfAWI1uO"></div> 
                </div>                
            </div>           
        </div>
    </div>
    <div class="row top-buffer">
        <div class="col-xs-6 col-sm-4 col-sm-offset-2">
            <asp:Button class="btn-xlg btn-success" ID="Button1" Text="Restart" OnClick="Restart_Click" OnClientClick="forcesubmit()" runat="server" />
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5" style="text-align: right">
            <asp:Button class="btn-xlg btn-success" ID="Buttonlink" Text="Start" OnClick="Email_Click" runat="server" />
        </div>
    </div>
    <!-- Modal -->
    <div id="errorModal" class="modal fade in" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Please enter the required fields</h4>
                </div>
                <div class="modal-body">
                    <% for (var i = 0; i < errors.Count; i++) { %>
                    <div><%= errors[i] %></div>
                    <% } %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-block btn-success" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

</form>
<script>
    function forcesubmit() {
        $('input').removeAttr("required")
    }
</script>
