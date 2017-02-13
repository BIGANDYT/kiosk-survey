$(document).ready(function () {
    $(document.getElementById('content_0_Description')).hide();
    $(document.getElementById('content_0_SubHeading')).hide();
    $(document.getElementById('content_0_SubDescription')).hide();
    $('.dial').val(0).trigger('change').delay(2000);
    var max = 100;
    var myKnob = $(".knob").knob({
        'min': 0,
        'max': max,
        'readOnly': true,
        'fgColor': myColor,
        'dynamicDraw': true,
        'thickness': 0.4,
        'tickColorizeValues': true,
        'displayInput': false,
        'bgColor':"#FFFFFF"
    })
    var interval = Math.round(max / (levels.length-1));
    var intervalCheck = interval;
    var tmr = self.setInterval(function () { tester() }, 30);
    var dialValue = 0;
    var i = 0;
    var myColor = levelColors[i];
    $("#content_0_Heading").html("<h2>" + levels[i] + "</h2>");
    $('.knob').trigger('configure', { 'fgColor': myColor });
    function tester() { 
        if (dialValue == intervalCheck) {            
            updater(i);  
        } else {
            dialValue += 1;
        }
        $('.knob').val(dialValue).trigger('change');        
    }   

    function updater(i) {
        i++;
        $("#content_0_Heading").html("<h2>" + levels[i] + "</h2>");
        if (levels[i] == stopper) {
            window.clearInterval(tmr);
            $(document.getElementById('content_0_Description')).fadeIn("slow");
            $(document.getElementById('content_0_SubHeading')).fadeIn("slow");
            $(document.getElementById('content_0_SubDescription')).fadeIn("slow");
        }
        intervalCheck = intervalCheck + interval;
        myColor = levelColors[i];
        dialValue += 1;
        $('.knob').trigger('configure', { 'fgColor': myColor });
    }
});