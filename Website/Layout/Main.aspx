<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.Main" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" href="/assets/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" href="/assets/css/responsive.css" />
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script src="/assets/js/attendee/jquery.knob.js"></script>
</head>
<body>
    <div class="row">
        <div class="col-xs-12">
            <sc:Placeholder ID="content" Key="content" runat="server" />
        </div>
    </div>
    <nav class="footer navbar navbar-default navbar-fixed-bottom" role="navigation">
        <img class="img-responsive" src="/assets/img/sitecore-50.png" />
    </nav>
</body>
</html>

