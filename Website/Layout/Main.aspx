<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.Main" EnableEventValidation="false" %>

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

    <link href="/assets/css/radio/radio.css" rel="stylesheet" />
    <link href="/assets/css/radio/maturitymodel.css" rel="stylesheet" />

    <script src="/assets/js/jquery.fittext.js"></script>

</head>
<body>
    <div id="wrap">
        <div class="container-fluid wrapmain">           
            <div class="row-fluid">
                <div class="span6">
                    <img class="arrows" src="/assets/img/arrows.png" />
                </div>                
                <asp:Repeater ID="ProgressRepeater" runat="server">
                    <ItemTemplate>
                        <div class="span1">
                            <div class="circle <%# circle(((Sitecore.Data.Items.Item)(Container.DataItem)).Name) %>">
                            </div>
                            <div class="stage"><%# ((Sitecore.Data.Items.Item)(Container.DataItem)).Name %></div>                            
                            <div class="line <%# line(((Sitecore.Data.Items.Item)(Container.DataItem)).Name) %>"></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>                   
            </div>
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
        <div id="push"></div>
    </div>
    <div id="footer">
        <div class="row-fluid">
            <div class="span6">
                <div class="logo">
                    <img src="/assets/img/sitecore.png" />
                </div>
            </div>
            <div class="span6">
                <div class="ownit">Own the Experience</div>

            </div>
        </div>
    </div>    
    <script>
        $(".responsive_text").fitText(2);

        var timer;
        $(document).ready(
            timer = setTimeout("location.href = '/';", 120000)
        );

        $('input').click(function () {
            window.clearTimeout(timer)
            timer = setTimeout("location.href = '/';", 120000)
        });

    </script>
</body>
</html>
