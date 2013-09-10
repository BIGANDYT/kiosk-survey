﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.Main" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/assets/css/Main.css" rel="stylesheet" />
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" media="screen" />
    <script src="/assets/js/bootstrap.js"></script>
    <script src="/assets/js/attendee/attendee.js"></script>
    <script src="/assets/js/attendee/jquery.knob.js"></script>
    
    <link href="/assets/css/Main.css" rel="stylesheet" />
    <link href="/assets/css/radio/radio.css" rel="stylesheet" />

</head>
<body>
    <div class="container-fluid, background">
        <div class="row-fluid">
            <div class="span12">
                <img class="arrows" src="/assets/img/arrows.png" />
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="content">
                    <form id="form1" runat="server">
                        <sc:Placeholder ID="content" Key="content" runat="server" />
                    </form>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="footer">
                    <div class="logo">
                        <img src="/assets/img/sitecore.png" />
                    </div>
                    <div class="ownit">Own the Experience</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>