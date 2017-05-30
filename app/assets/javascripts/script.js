$(document).ready(function() {
	// $(".owl-slide").owlCarousel({
	// 	autoPlay: true,
	// 	items : 1,
	// 	itemsDesktop : [1199,1],
	// 	itemsDesktopSmall : [979,1],
	// 	itemsTablet : [768, 1],
	// 	itemsMobile : [479,1],
	// 	navigation : true,
 //        navigationText : ["", ""],
 //        rewindNav : true,
 //        scrollPerPage : false,

 //        pagination : false,
	// });

  $(document).on("click", "#request_class_btn", function(){
    $("#availability-tab-btn").closest(".tab-page").find(".active").removeClass("active");
    $("#availability-tab-btn").addClass("active");
    $("#availability-tab-btn").parent().addClass("active");
  });

  // dropzone for avatar
  Dropzone.autoDiscover = false;

  $("#new_avatar").dropzone({
    maxFilesize:      1,
    dictDefaultMessage: "Upload a Photo",
    addRemoveLinks:   true,
    success: function(file, response){
      $('div.dz-default.dz-message').hide();
      $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
      $(file.previewElement).addClass("dz-success");
    },
    removedfile: function(file){
      $('div.dz-default.dz-message').show();

      $.ajax({
        type:     'DELETE',
        url:      '/remove_avatar',
        success:  function(data){
          console.log(data.message);
        }
      });
      var _ref;
      return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
    },
    maxFiles:1,
      init: function() {
          this.hiddenFileInput.removeAttribute('multiple');
      }
  });
  // End dropzone


	$('.btn-menu').click(function() {
		$(".nav-logo").slideToggle("fast");
	});



	$(window).load(function(){
    $('#carousel').flexslider({
      animation: "slide",
      controlNav: false,
      animationLoop: false,
      slideshow: false,
      asNavFor: '#slider'
    });

    $('#slider').flexslider({
      animation: "slide",
      controlNav: false,
      animationLoop: false,
      slideshow: false,
      sync: "#carousel",
      start: function(slider){
        $('body').removeClass('loading');
      }
    });
  });

  $(function(){
    $(".search-geocomplete").geocomplete({
      details: "#search-filters",
      detailsAttribute: "data-geo"
    });
  });

  $(".register-geocomplete").geocomplete({
    details: "#register-form",
    detailsAttribute: "data-geo"
  });

  // jQuery validation form
  $.validate();
});
