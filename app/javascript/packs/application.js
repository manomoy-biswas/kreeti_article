// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

var string = $('.article-description').text();
var str50 = string.substr(0,50) 
$('.article-description').html(str50+'...'+'<a class="read-more" href="#">readmore</a>');
$('.article-description').attr('data-text',string);

$('.read-more').click(function(e)
{
    e.preventDefault();
    $(this).parent().html($(this).parent().attr('data-text'))

})