$(document).ready(function () {
    $(document.getElementById('content_0_Description')).hide();
    $(document.getElementById('content_0_SubHeading')).hide();
    $(document.getElementById('content_0_SubDescription')).hide();
    $('.dial').val(0).trigger('change').delay(2000);    
    var myKnob = $(".dial").knob({
        'min': 0,
        'max': 100,
        'readOnly': true,
        'width': 200,
        'height': 200,
        'fgColor': myColor,
        'dynamicDraw': true,
        'thickness': 0.4,
        'tickColorizeValues': true,
        'displayInput': false
    })

    var tmr = self.setInterval(function () { myDelay() }, 30);
    var m = 0;
    var i = 0;
    var myColor = '#F99501';
    function myDelay() {       
        m += 1;
        switch (m) {
            case 15:
                updater(i++)
                break;
            case 16:
                myColor = '#F4572D';
                updater(i++)
                break;
            case 32:
                myColor = '#C5341F';
                updater(i++)
                break;
            case 48:
                myColor = '#B83C81';
                updater(i++)
                break;
            case 64:
                myColor = '#803A9A';
                updater(i++)
                break;
            case 80:
                myColor = '#1C7FC1';
                updater(i++)
                break;
            case 100:
                myColor = '#008B48';
                updater(i++);
                break;
        }
        $('.dial').trigger('configure', { 'fgColor': myColor });
        $('.dial').val(m).trigger('change');
    }

    function updater(i) {
        $("#content_0_Heading").html("<h2>" + levels[i] + "</h2>");
        if (i == levels.length - 1) {
            window.clearInterval(tmr);
            $(document.getElementById('content_0_Description')).fadeIn("slow");
            $(document.getElementById('content_0_SubHeading')).fadeIn("slow");
            $(document.getElementById('content_0_SubDescription')).fadeIn("slow");
        }
    }
});