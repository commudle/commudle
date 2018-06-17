
window.addEventListener('load', function(){
    $('form').on('click', '.remove_fields', function(){

        event.preventDefault();
        $(this).prev('input[type=hidden]').val('1');

        $(this).closest('fieldset').hide();


    });


    $('form').on('click', '.add_fields', function(){

        event.preventDefault();
        time = new Date().getTime()

        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))


    });
});