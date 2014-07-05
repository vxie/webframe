// 进度条显示

(function( $ ){
  $.fn.animateProgress = function(progress, callback) {    
    return this.each(function() {
      $(this).animate({
        width: progress+'%'
      }, {
        duration: 2000, 
        easing: 'swing',
        step: function( progress ){
          var labelEl = $('.progress-label', this),
              valueEl = $('.value', labelEl);
          
          if (Math.ceil(progress) < 20 && $('.progress-label', this).is(":visible")) {
            labelEl.hide();
          }else{
            if (labelEl.is(":hidden")) {
              labelEl.fadeIn();
            };
          }
          
          if (Math.ceil(progress) == 100) {
            labelEl.text('Done');
            setTimeout(function() {
              labelEl.fadeOut();
            }, 1000);
          }else{
            valueEl.text(Math.ceil(progress) + '%');
          }
        },
        complete: function(scope, i, elem) {
          if (callback) {
            callback.call(this, i, elem );
          };
        }
      });
    });
  };
})( jQuery );

/*
$(function() {
  // Hide the label at start
  //$('#progress_bar .ui-progress .progress-label').hide();
  // Set initial value
  //$('#progress_bar .ui-progress').css('width', '7%');

  // Simulate some progress
  $('#progressbar_total_value').animateProgress(50, function() {
    $(this).animateProgress(79, function() {
      setTimeout(function() {
        $('#progressbar_total_value').animateProgress(100, function() {
          //$('#main_content').slideDown();
          //$('#fork_me').fadeIn();
        });
      }, 2000);
    });
  });
  
});*/