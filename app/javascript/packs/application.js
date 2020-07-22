
require("jquery")
require("@rails/ujs").start()
require("turbolinks")
require("@rails/activestorage").start()
require("channels")
require("bootstrap")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(()=>$(".hide").fadeOut(4000));

// $(()=>$('.dropdown-toggle').dropdown());

$(document).ready(function() {
	var showChar = 130;
	var ellipsestext = "...";
	// var moretext = "more";
	// var lesstext = "less";
  
  $('.more').each(function() {
		var content = $(this).html();

		if(content.length > showChar) {

			var c = content.substr(0, showChar);
			// var h = content.substr(showChar-1, content.length - showChar);

			var html = c + '<span class="moreellipses">' + ellipsestext + '</span>'
				// <span class="morecontent"><span>'+ h +'</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

      $(this).html(html);
		}
	});
	
	// $(".morelink").click(function(){
	// 	if($(this).hasClass("less")) {
	// 		$(this).removeClass("less");
	// 		$(this).html(moretext);
	// 	} else {
	// 		$(this).addClass("less");
	// 		$(this).html(lesstext);
	// 	}
	// 	$(this).parent().prev().toggle();
	// 	$(this).prev().toggle();
	// 	return false;
	// });
});

$(document).ready(function() {
  $('#filters').on('change', function() {
    this.form.submit();
  });
});
