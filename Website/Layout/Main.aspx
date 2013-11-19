<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="Main.aspx.cs" Inherits="Website.Layout.Main" EnableEventValidation="false" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <link rel="stylesheet" href="/assets/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" href="/assets/css/responsive.css" />
    <script src="/assets/js/jquery-1.9.1.min.js"></script>
    <script src="/assets/js/attendee/jquery.knob.js"></script>
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
</head>
<body oncontextmenu="return false;" onload="init()">

    <script type="text/javascript" src="/assets/js/xmas/ThreeCanvas.js"></script>
    <script type="text/javascript" src="/assets/js/xmas/Snow.js"></script>

    <script>

        var SCREEN_WIDTH = window.innerWidth * 0.95;
        var SCREEN_HEIGHT = window.innerHeight * 0.95;

        var container;

        var particle;

        var camera;
        var scene;
        var renderer;

        var mouseX = 0;
        var mouseY = 0;

        var windowHalfX = window.innerWidth / 2;
        var windowHalfY = window.innerHeight / 2;

        var particles = [];
        var particleImage = new Image();//THREE.ImageUtils.loadTexture( "img/ParticleSmoke.png" );
        particleImage.src = '/assets/img/xmas/ParticleSmoke.png';



        function init() {
            var date = new Date();
            var m = date.getMonth();
            var d = date.getDate();
            /* If its Christmas show me some snow!!! */
            if (m == 11 && (d == 24 || d == 25 || d == 26)) {
                document.getElementById('arrows').src = "/assets/img/xmas/wreath.png";                
                var x = document.getElementById('progress').src;
                var x = x.substring(x.lastIndexOf("/") + 1);
                var x = "/assets/img/xmas/" + x;
                document.getElementById('progress').src = x;
                container = document.createElement('section');
                document.body.appendChild(container);
                camera = new THREE.PerspectiveCamera(75, SCREEN_WIDTH / SCREEN_HEIGHT, 1, 10000);
                camera.position.z = 1000;

                scene = new THREE.Scene();
                scene.add(camera);

                renderer = new THREE.CanvasRenderer();
                renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
                var material = new THREE.ParticleBasicMaterial({ map: new THREE.Texture(particleImage) });

                for (var i = 0; i < 200; i++) {

                    particle = new Particle3D(material);
                    particle.position.x = Math.random() * 2000 - 1000;
                    particle.position.y = Math.random() * 2000 - 1000;
                    particle.position.z = Math.random() * 2000 - 1000;
                    particle.scale.x = particle.scale.y = 1;
                    scene.add(particle);

                    particles.push(particle);
                }

                container.appendChild(renderer.domElement);


                document.addEventListener('mousemove', onDocumentMouseMove, false);

                setInterval(loop, 1000 / 60);
            }

        }

        function onDocumentMouseMove(event) {

            mouseX = event.clientX - windowHalfX;
            mouseY = event.clientY - windowHalfY;
        }

        //

        function loop() {

            for (var i = 0; i < particles.length; i++) {

                var particle = particles[i];
                particle.updatePhysics();

                with (particle.position) {
                    if (y < -1000) y += 2000;
                    if (x > 1000) x -= 2000;
                    else if (x < -1000) x += 2000;
                    if (z > 1000) z -= 2000;
                    else if (z < -1000) z += 2000;
                }
            }

            camera.position.x += (mouseX - camera.position.x) * 0.05;
            camera.position.y += (-mouseY - camera.position.y) * 0.05;
            camera.lookAt(scene.position);

            renderer.render(scene, camera);


        }

    </script>
    <style>
        section {
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }
    </style>
    <div class="row">
        <div class="col-xs-12">
            <sc:Placeholder ID="content" Key="content" runat="server" />
        </div>
    </div>
    <nav class="footer navbar navbar-default navbar-fixed-bottom" role="navigation">
        <div class="col-xs-6">
            <img class="img-responsive" src="/assets/img/sitecore-50.png" />
        </div>
        <div class="col-xs-5 col-xs-offset-1 ownit">
            <span><img class="img-responsive" src="/assets/img/ownit.png" /></span>
        </div>
    </nav>

</body>
</html>

