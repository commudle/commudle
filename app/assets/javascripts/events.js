{
    let responsesFilter = function(){
        $('#responses-filter').on('input', function(){
            let filterVal = $(this).val();


            $(".user-entry-pass-code").each(function(){
                if ($(this).html().includes(filterVal) || $(this).closest('.user-info').find('.user-email').html().includes(filterVal)){
                    $(this).closest(".list-group-item.user-info").removeClass('hidden-item');

                }else{
                    $(this).closest(".list-group-item.user-info").addClass('hidden-item');

                }
            });

        });
    }


    window.addEventListener('load', function(){
        responsesFilter();
    })

}
