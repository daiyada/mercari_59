$(document).on('turbolinks:load', function() { 
  //値段
  $(function() {
    var search_list = "";
    function appendProduct1(margin_fee ) {
      search_list = $(".m-main__container__inner__form__price__box__price__calc__right");
      var html = `<div class="m-main__container__inner__form__price__box__price__calc__right">
      ${margin_fee}
      </div>`
       search_list.append(html);
      }
    function appendProduct2(benefit ) {
      search_list = $(".m-main__container__inner__form__price__box__price__benefit__right");
      var html = `<div class="m-main__container__inner__form__price__box__price__benefit__right">
      ${benefit}
      </div>`
        search_list.append(html);
      }
      function pricecalc() {
      var input = $("#set_item_price").val();
      
      $(".m-main__container__inner__form__price__box__price__calc__right").empty();
      $(".m-main__container__inner__form__price__box__price__benefit__right").empty();
      ;
        if (input>= 300) {
       
        margin_fee = input * 0.1
        margin_fee = Math.floor(margin_fee); 
        margin_fee = '¥' + margin_fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        benefit = input * 0.9
        benefit = Math.floor(benefit); 
        benefit = '¥' + benefit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        appendProduct1(margin_fee);
        appendProduct2(benefit);
      }
      else {
        appendProduct1("-");
        appendProduct2("-");   
      }
    }
    pricecalc();
    $("#set_item_price").on("keyup", function() {
      var input = $("#set_item_price").val();
      pricecalc();
       
    });
  });
    var submitnum = 1
    $('.m-main__container__inner__form__last__button').off('click')
    $('.m-main__container__inner__form__last__button').on('click',function(){
    
      if (submitnum >= 2) {
        $(".m-main__container__inner__form__last__button").prop("disabled", true);
        }
        submitnum = submitnum + 1

    });


});
  