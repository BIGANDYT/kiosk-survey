<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Finished.ascx.cs" Inherits="Website.Layout.SubLayout.Finished" %>
<body>
<div class="row-fluid">
    <div class="span12 text-left">
        <h1 class="finish"><sc:FieldRenderer ID="Title" FieldName="Title" runat="server" />            
        </h1>
        <h2 class="finish"><sc:FieldRenderer ID="Subtitle" FieldName="Subtitle" runat="server" />            
        </h2>
    </div>    
</div>    
<div class="row-fluid">
    <div class="span4 text-left">
        <img src="/assets/img/amazon-com-logo.png" />
    </div>
    <div class="span4 offset1 text-right bottom">
        <asp:Button class="emailbutton" ID="Buttonlink" Text="Next User Click Here" OnClick="Restart_Click" runat="server" />
    </div>
</div>
</body>
