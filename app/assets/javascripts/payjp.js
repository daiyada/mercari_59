$(document).on("turbolinks:load", function(){
  var form = $(".hi-container__wrapper__main__right__secret");
  Payjp.setPublicKey("pk_test_8147a23f6956eb62dc7e25ff");

  $(".hi-container__wrapper__main__right__secret").on("click", ".hi-container__wrapper__main__right__secret__content__btn", function(e){
    e.preventDefault();
    form.find(".hi-container__wrapper__main__right__secret__content__btn").prop("disabled", true);

    var card = {
        number: $("#card_num").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val()
    };
    Payjp.createToken(card, function(status, response){
      if (status === 200){
        $("#card_num").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id

        form.append($('<input type="hidden" name="payjpToken">').val(token));
        form.get(0).submit();
      }
      else{
        console.log(status);
        alert("トークン作成時にエラーが生じました。");
      }
    })
  })
})