<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Finished.ascx.cs" Inherits="Website.Layout.SubLayout.Finished" %>
<script>
    $(document).ready(
        setTimeout("location.href = '<%= Sitecore.Context.Site.StartPath %>';", 15000)
    );    
</script>
<body>

<div class="row-fluid">
    <div class="span12 text-center">
        <h1 class="welcome">Thank you for taking the test<br />
            Your full assessment has been emailed to you<br />
        </h1>
    </div>
    <div class="span12 text-center">
        <asp:Button class="emailbutton" ID="Buttonlink" Text="Next User Click Here" OnClick="Restart_Click" runat="server" />
    </div>
</div>
    
</body>
