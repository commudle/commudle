{
    $(document).ready(function(){
       let readMoreLink = $('.read-more-box-link');
        readMoreLink.each(function(){
          let totalHeight = 0;

            $(this).parent().children().each(function() {
                totalHeight += $(this).outerHeight();
            });

          $(this).click(function(){
              event.preventDefault();
             if ($(this).parent().attr('data-expanded') == 0){
                 $(this).parent().css('height', totalHeight);
                 $(this).parent().attr('data-expanded', '1');
                 $(this).remove();
             }


          });
       });




    });
}