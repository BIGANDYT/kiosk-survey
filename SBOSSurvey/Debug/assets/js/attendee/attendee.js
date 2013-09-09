$(document).ready(function () {
    document.getElementById('andythompson2').style.display = 'none';
    document.getElementById('andythompson').value = 'Initiator';
    $('.dial').val(0).trigger('change').delay(2000);
    var myColor = '#F99501';
    var myKnob = $(".dial").knob({
        'min': 0,
        'max': 100,
        'readOnly': true,
        'width': 510,
        'height': 510,
        'fgColor': myColor,
        'dynamicDraw': true,
        'thickness': 0.24,
        'tickColorizeValues': true,
        'skin': 'tron',
        'displayInput': false
    })

    var tmr = self.setInterval(function () { myDelay() }, 30);
    var m = 0;
    function myDelay() {
        m += 1;
        switch (m) {
            case 16:                
                if (document.getElementById('content_0_stopper').value == 'Initiator') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }
                break;
            case 17:
                document.getElementById('andythompson').value = 'Promoter';
                myColor = '#F4572D';
                if (document.getElementById('content_0_stopper').value == 'Promoter') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }                
                break;
            case 34:
                document.getElementById('andythompson').value = 'Aligner';
                myColor = '#C5341F';
                if (document.getElementById('content_0_stopper').value == 'Aligner') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }
                break;
            case 51:
                document.getElementById('andythompson').value = 'Optimizer';
                myColor = '#B83C81';
                if (document.getElementById('content_0_stopper').value == 'Optimizer') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }
                break;
            case 68:
                document.getElementById('andythompson').value ='Nurturer';
                myColor = '#803A9A';
                if (document.getElementById('content_0_stopper').value == 'Nurturer') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }
                break;
            case 85:
                document.getElementById('andythompson').value = 'Engager';
                myColor = '#1C7FC1';
                if (document.getElementById('content_0_stopper').value == 'Engager') {
                    window.clearInterval(tmr);
                    $(document.getElementById('andythompson2')).fadeIn("slow");
                }
                break;
            case 100:
                document.getElementById('andythompson').value = 'Lifetime Customer Champion';
                myColor = '#008B48';
                window.clearInterval(tmr);
                $(document.getElementById('andythompson2')).fadeIn("slow");
                break;
        }
        document.getElementById('andythompson').style.color = myColor;
        document.getElementById('andythompson2').style.color = myColor;
        $('.dial').trigger('configure', { 'fgColor': myColor });
        $('.dial').val(m).trigger('change');
    }   
});