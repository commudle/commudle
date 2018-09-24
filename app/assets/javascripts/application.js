// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require tinymce
//= require moment
//= require_tree .



{
    window.addEventListener('load', function(){
        tinyMCE.init({
            selector: 'textarea.tinymce.editor',
            branding: false
        });

        var current_time = new Date();
        Cookies.set('time_zone', current_time.getTimezoneOffset());
    });





}

var textAreaRowIncrementor = function(event, element){
    if (event.keyCode == 13 && !event.shiftKey){
        if (element.value.replace(/\s/g,'')){
            Rails.fire(element.form, "submit");
            element.rows = 1;
        }

    }else if(event.keyCode == 13 && event.shiftKey){
        element.rows += 1
    }
}


//this method with show the attached image realtime in either an image tag or as the background of a container
function showImage(input, displayContainerId, displayType='image_tag') {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        let displayContainer =  $(`#${displayContainerId}`);

        reader.onload = function (e) {
            if (displayType == 'image_tag'){

                displayContainer.attr('src', e.target.result);
            }else if(displayType == 'background'){
                console.log(displayContainer);
                displayContainer.css('background', `transparent url${e.target.result}`);
                // console.log(displayContainer.c);
            }


        };

        reader.readAsDataURL(input.files[0]);
    }
}


function updateRegistrationStatusCounter(edfegId, kommunity, event_id){
    $.getScript( `/${kommunity}/events/${event_id}/update-registration-status-counter?event_data_form_entity_group_id=${edfegId}` )
        .done(function( script, textStatus ) {
            console.log('counter refreshed');
        })
}


