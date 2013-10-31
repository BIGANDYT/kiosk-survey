$(document).ready(function () {
    // if the system is windows 7 then show a keyboard otherwise dont
    if (navigator.userAgent.indexOf("NT 6.1") != -1) {
        $('input[type=text], input[type=email]').keyboard({

            autoAccept: true,
            usePreview: false,
            css: {
                input: '',
            },

            display: {
                'bksp': '\u2190',
                'enter': 'enter',
                'default': 'ABC',
                'meta1': '.?123',
                'meta2': '#+=',
                'accept': 'ok'
            },

            layout: 'custom',

            customLayout: {

                'default': [
                    'q w e r t y u i o p {bksp}',
                    'a s d f g h j k l',
                    '{s} z x c v b n m @ . {s}',
                    '{meta1} {space} _ - {accept}'
                ],
                'shift': [
                    'Q W E R T Y U I O P {bksp}',
                    'A S D F G H J K L',
                    '{s} Z X C V B N M @ . {s}',
                    '{meta1} {space} _ - {accept}'
                ],
                'meta1': [
                    '1 2 3 4 5 6 7 8 9 0 {bksp}',
                    '` | { } % ^ * / \'',
                    '{meta2} $ & ~ # = + . {meta2}',
                    '{default} {space} ! ? {accept}'
                ],
                'meta2': [
                    '[ ] { } \u2039 \u203a ^ * " , {bksp}',
                    '\\ | / &lt; &gt; $ \u00a3 \u00a5 \u2022',
                    '{meta1} \u20ac & ~ # = + . {meta1}',
                    '{default} {space} ! ? {accept}'
                ]

            }

        });
		
    }
        document.getElementById('maintext').style.display = 'none';
        document.getElementById('qualifiertext').value = 'Initiator';
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
                    $(document.getElementById('maintext')).fadeIn("slow");
                }
                break;
            case 17:
                document.getElementById('qualifiertext').value = 'Promoter';
                myColor = '#F4572D';
                if (document.getElementById('content_0_stopper').value == 'Promoter') {
                    window.clearInterval(tmr);
                    $(document.getElementById('maintext')).fadeIn("slow");
                }                
                break;
            case 34:
                document.getElementById('qualifiertext').value = 'Aligner';
                myColor = '#C5341F';
                if (document.getElementById('content_0_stopper').value == 'Aligner') {
                    window.clearInterval(tmr);
                    $(document.getElementById('maintext')).fadeIn("slow");
                }
                break;
            case 51:
                document.getElementById('qualifiertext').value = 'Optimizer';
                myColor = '#B83C81';
                if (document.getElementById('content_0_stopper').value == 'Optimizer') {
                    window.clearInterval(tmr);
                    $(document.getElementById('maintext')).fadeIn("slow");
                }
                break;
            case 68:
                document.getElementById('qualifiertext').value = 'Nurturer';
                myColor = '#803A9A';
                if (document.getElementById('content_0_stopper').value == 'Nurturer') {
                    window.clearInterval(tmr);
                    $(document.getElementById('maintext')).fadeIn("slow");
                }
                break;
            case 85:
                document.getElementById('qualifiertext').value = 'Engager';
                myColor = '#1C7FC1';
                if (document.getElementById('content_0_stopper').value == 'Engager') {
                    window.clearInterval(tmr);
                    $(document.getElementById('maintext')).fadeIn("slow");
                }
                break;
            case 100:
                document.getElementById('qualifiertext').value = 'Lifetime';
                myColor = '#008B48';
                window.clearInterval(tmr);
                $(document.getElementById('maintext')).fadeIn("slow");
                break;
        }
        document.getElementById('qualifiertext').style.color = myColor;
        $('.dial').trigger('configure', { 'fgColor': myColor });
        $('.dial').val(m).trigger('change');
    }   
});