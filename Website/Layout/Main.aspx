<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.Main" EnableEventValidation="false" %>

<!DOCTYPE HTML>
<html lang="en">
<head>    
    <link rel="stylesheet" href="/assets/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" href="/assets/css/survey.css">
    <link rel="stylesheet" href="/assets/css/responsive.css" />
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script src="/assets/js/knob/jquery.knob.js"></script>
    <script src="/assets/js/bootstrap/bootstrap.min.js"></script>    
    <title>Customer Experience Maturity Assessment</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
    <style type="text/css">
        body {
            margin: 0px;
            overflow: hidden;
        }

        a {
            color: #0078ff;
        }
    </style>
    <script type="text/javascript">
        function openErrorModal() {
            $('#errorModal').modal('show');
        }
    </script>
    <!--<script>
   	 $(document).ready(
	        setTimeout("location.href = '<%= Sitecore.Context.Site.StartPath %>';", 240000)
	    );    
	</script>-->
</head>
<body oncontextmenu="return false;" onload="init()">
     <script src="/assets/js/bigvideo/jquery-ui-1.8.22.custom.min.js"></script>
    <script type="text/javascript" src="/assets/js/xmas/ThreeCanvas.js"></script>
    <script type="text/javascript" src="/assets/js/xmas/Snow.js"></script>
    <script type="text/javascript" src="/assets/js/xmas/SnowLoader.js"></script>
    <style>
        section {
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }
    </style>
    <div class="row header">
        <div class="col-xs-6 col-sm-6">
            <img id="arrows" class="img-responsive logo" src="/assets/img/logo.svg" />
        </div>
        <div class="col-xs-12 col-sm-4 col-sm-offset-2">

            <img id="progress" class="img-responsive" src="/assets/img/progress_<%= Sitecore.Context.Item["Stage"] %>.png" />
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <sc:Placeholder ID="content" Key="content" runat="server" />
        </div>
    </div>
    <nav class="footer navbar navbar-default navbar-fixed-bottom" role="navigation" style="">
        <div class="col-xs-12 col-sm-6" style="padding-top:5px;padding-left:30px;">
            <h3>Avanade Customer Experience Maturity Survey</h3>
        </div>
    </nav>
</body>
</html>

