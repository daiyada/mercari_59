$(document).on('turbolinks:load', function() { 

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
  
    $("#set_item_price").on("keyup", function() {
      var input = $("#set_item_price").val();
      
        $(".m-main__container__inner__form__price__box__price__calc__right").empty();
        $(".m-main__container__inner__form__price__box__price__benefit__right").empty();
        ;
          if (input>= 300) {
         
          margin_fee = input * 0.1
          margin_fee = Math.floor(margin_fee); 
          margin_fee = '¥' + margin_fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
          // margin_fee = margin_fee.substring(0,margin_fee.indexOf("."));
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
    });
  });
  });
  