$(document).on('turbolinks:load', function(){
  $('.slick').slick({
    autoplay:true,
    dots:true,
    prevArrow: '<img src="https://web-jp-assets.mercdn.net/_next/static/images/carousel-prev-af7ca886ce42c4c02610cd15421ddcad.png" class="slide-arrow prev-arrow">',
    nextArrow: '<img src="https://web-jp-assets.mercdn.net/_next/static/images/carousel-next-bc3a1438a1435e953bc67d720cd05c61.png" class="slide-arrow next-arrow">'
    
  });
});