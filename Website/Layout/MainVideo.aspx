<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="MainVideo.aspx.cs" Inherits="Website.Layout.MainVideo" EnableEventValidation="false" %>

<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/assets/css/bigvideo.css">
    <link rel="stylesheet" href="/assets/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/responsive.css">
</head>
<body>
    <sc:Placeholder ID="content" Key="content" runat="server" />
    <!-- BigVideo Dependencies -->
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script>window.jQuery || document.write('<script src="/assets/js/jquery-1.7.2.min.js"><\/script>')</script>
    <script src="/assets/js/jquery-ui-1.8.22.custom.min.js"></script>
    <script src="/assets/js/jquery.imagesloaded.min.js"></script>
    <script src="/assets/js/video.js"></script>
    <script src="/assets/js/bigvideo.js"></script>
    <script src="/assets/js/modernizr-2.5.3.min.js"></script>
    <!-- BigVideo -->
    <!-- Bootstrap Dependencies -->
    <script src="/assets/js/bootstrap/bootstrapvideo.js"></script>
    <!-- Bootstrap -->
    <script>
        $(function () {
            $("body").css("overflow", "hidden");
            var BV = new $.BigVideo();
            BV.init();
            if (Modernizr.touch) {
                BV.show('/assets/img/poster.png');
            } else {
                BV.show('/assets/vids/video1-new.mp4', { ambient: true }, { doLoop: true });
            }
        });
    </script>
</body>
</html>
