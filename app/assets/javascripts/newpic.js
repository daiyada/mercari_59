

$(document).on('turbolinks:load', function() { 
$(function(){

  var i = 1
  var search_list = "";
  //写真フォーマット挿入
  function appendProduct(id) {
  search_list = $(".m-main__container__inner__form__upload__number10__box__file");
  var html = `<input multiple="multiple" class="m-main__container__inner__form__upload__number10__box__file${id} pic" type="file" name="item[images_attributes][${id}][image]" id="item_images_attributes_${id}_image">`

    search_list.append(html);
  }
  //見せる写真挿入
  function appendProduct1(src_pass , i) {
  search_list = $(".m-main__container__inner__form__upload__number10__box__visible ");

  var html = `<div class="m-main__container__inner__form__upload__number10__box__visible__box">
              <img class="m-main__container__inner__form__upload__number10__box__visible__box__pic" src="${src_pass}"> 
              <div class="m-main__container__inner__form__upload__number10__box__visible__box__btn">
              <a class=".m-sell-upload-edit" >編集</a>
              <a class=".m-sell-upload-edit" pic-id="${i}">削除</a>
              </div>
              </div>`

    search_list.append(html);
  }
 
  $('.m-main__container__inner__form__upload__number10__box__file').off('change')
  $('.m-main__container__inner__form__upload__number10__box__file').on('change', function(e) {
    //ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();
    //画像でない場合は処理終了
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }
    //アップロードした画像を設定する
    reader.onload = (function(file){ 
      return function(e){
        
        $('.m-main__container__inner__form__upload__number10__box__visible__pic1').hide();
        $('.pic').hide();
        i = i + 1
        appendProduct1(e.target.result , i);
        if (i <= 10) {
        appendProduct(i);
        }
        if (i == 6) {
          //cssサイズ変更
          $(function() {
            $('.m-main__container__inner__form__upload__number10__box').height(324);
          });
        } 
      };
    })(file);
    //プレビュー表示
    reader.readAsDataURL(file);
 
  });

});
});
