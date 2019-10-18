$(document).on("turbolinks:load",function(){
  $(".hi-container__wrapper__main__right__itemlist__tab__switch").on("click", function(){
    $('.is-shown').removeClass('is-shown');
    console.log(this);
		$(this).addClass('is-shown');
    $('.is-active').removeClass('is-active');
    const index = $(this).index();
    $('.hi-container__wrapper__main__right__itemlist__box').eq(index).addClass('is-active');
  })
})