$(document).on("turbolinks:load",function(){
  // マイページ下部のタブ切り替え
  $(".hi-container__wrapper__main__right__itemlist__tab__switch").on("click", function(){
    $('.hi-container__wrapper__main__right__itemlist__tab__switch.is-shown').removeClass('is-shown');
		$(this).addClass('is-shown');
    $('.hi-container__wrapper__main__right__itemlist__box.is-active').removeClass('is-active');
    var index = $(this).index();
    $('.hi-container__wrapper__main__right__itemlist__box').eq(index).addClass('is-active');
  })

  // マイページ上部のタブの切り替え
  $(".hi-container__wrapper__main__right__tab__switch").on("click", function(){
    $('.hi-container__wrapper__main__right__tab__switch.is-shown').removeClass('is-shown');
    $(this).addClass('is-shown');
    var index = $(this).index();
    $('.hi-container__wrapper__main__right__list.is-active').css('display','none');
    $('.hi-container__wrapper__main__right__list.is-active').removeClass('is-active');
    $('.hi-container__wrapper__main__right__list').eq(index).addClass('is-active');
    $('.hi-container__wrapper__main__right__list.is-active').css('display','block');
  })
})