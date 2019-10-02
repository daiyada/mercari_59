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
      
      $.ajax({
        type: 'GET',
        url: '/items/new',
        data: { keyword: input },
        dataType: 'json'
      })
  
      .done(function(item) {
        console.log(item.price);
        $(".m-main__container__inner__form__price__box__price__calc__right").empty();
        $(".m-main__container__inner__form__price__box__price__benefit__right").empty();
        ;
        if (item.price >= 300) {
          margin_fee = item.price * 0.1
          margin_fee = '¥' + margin_fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
          benefit = item.price * 0.9
          benefit = '¥' + benefit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
          
          appendProduct1(margin_fee);
          appendProduct2(benefit);
        }
        else {
          appendProduct1("-");
          appendProduct2("-");   
        }
      })
    });
  });
  });
  