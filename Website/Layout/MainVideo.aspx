<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="MainVideo.aspx.cs" Inherits="Website.Layout.MainVideo" EnableEventValidation="false" %>

<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/assets/css/bigvideo/bigvideo.css">
    <link rel="stylesheet" href="/assets/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/responsive.css">
    <title>Customer Experience Maturity Assessment</title>    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</head>
<body oncontextmenu="return false;">   
    <sc:Placeholder ID="content" Key="content" runat="server" />
    <!-- BigVideo Dependencies -->
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script src="/assets/js/bigvideo/jquery-ui-1.8.22.custom.min.js"></script>
    <script src="/assets/js/bigvideo/jquery.imagesloaded.min.js"></script>
    <script src="/assets/js/bigvideo/video.js"></script>
    <script src="/assets/js/bigvideo/bigvideo.js"></script>
    <script src="/assets/js/bigvideo/modernizr-2.5.3.min.js"></script>
    <!-- BigVideo -->
    <!-- Bootstrap Dependencies -->
    <script src="/assets/js/bootstrap/bootstrap.min.js"></script>
    <!-- Bootstrap -->
    <script>
        $(function () {
            $("body").css("overflow", "hidden");
            var BV = new $.BigVideo();
            BV.init();
            if (Modernizr.touch && window.screen.availWidth < 1070) {
                BV.show('/assets/img/bigvideo/poster.png');
            } else {
                BV.show('/assets/vids/video1-new.mp4', { ambient: true }, { doLoop: true });
            }
        });
    </script>
</body>
</html>
