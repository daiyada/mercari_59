$(document).on("turbolinks:load", function(){
  var form = $("#card-info-form");
  Payjp.setPublicKey("pk_test_8147a23f6956eb62dc7e25ff");

  $("#card-info-form").on("click", "#submit-card-info", function(e){
    e.preventDefault();
    form.find("#submit-card-info").prop("disabled", true);

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