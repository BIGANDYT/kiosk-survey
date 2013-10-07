<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.MainVideo" EnableEventValidation="false" %>

<!DOCTYPE html>
<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/assets/css/style.css">
    <link rel="stylesheet" href="/assets/css/bigvideo.css">
    <link rel="stylesheet" href="/assets/css/Main.css" />
</head>
<body>
    <div class="main">
        <div>
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span1"></div>
                    <div class="span10">
                        <div class="content">
                            <form id="form1" runat="server">
                                <sc:Placeholder ID="content" Key="content" runat="server" />
                            </form>
                        </div>
                    </div>
                    <div class="span1"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- BigVideo Dependencies -->
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script>window.jQuery || document.write('<script src="/assets/js/jquery-1.7.2.min.js"><\/script>')</script>
    <script src="/assets/js/jquery-ui-1.8.22.custom.min.js"></script>
    <script src="/assets/js/jquery.imagesloaded.min.js"></script>
    <script src="http://vjs.zencdn.net/4.0/video.js"></script>

    <!-- BigVideo -->
    <script src="/assets/js/bigvideo.js"></script>

    <!-- Demo -->
    <script>
        $(function () {
            $("body").css("overflow", "hidden");
            var BV = new $.BigVideo();
            BV.init();
            BV.show('/assets/vids/video1-new.mp4', { ambient: true }, { doLoop: true });
        });
    </script>
</body>
</html>
