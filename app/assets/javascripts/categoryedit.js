$(document).on('turbolinks:load', function() { 
  if(document.URL.match(/(edit)/)) {
  //写真が6枚以上の時箱サイズ変更
    $(function () {
      var counter = 0;
      $('.m-editbox').each(function () {
          counter++;
      });
      if (counter >= 6) {
        //cssサイズ変更
        $(function() {
          $('.m-main__container__inner__form__upload__number10__box').height(324);
        });
      } 
  });

//最初のクリックで子孫削除
var firstclick = 0;
if (firstclick == 0){
  $('.select-wrap').off('click');
  $('.select-wrap').on('click', function(){
  $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
  $('#grandchildren_wrapper').remove();
  firstclick = firstclick + 1
});
}


  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
   
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
  
  
      childSelectHtml = `<div class="select-wrap" id="children_wrapper">
                        <i class="fas fa-chevron-down m-arrow">
                        </i>
                        <select class="m-select-default" id="child_category" name="child_id"><option value="---" data-category="---">---</option>
                        ${insertHTML}
                        </div>`;
      $('.m-main__container__inner__form__descript__box__up').append(childSelectHtml);
    }
    // 孫カテゴリーの表示作成  <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class="select-wrap" id="grandchildren_wrapper">
                              <i class="fas fa-chevron-down m-arrow">
                              </i>
                              <select class="m-select-default" id="grandchild_category" name="grandchild_id"><option value="---" data-category="---">---</option>
                              ${insertHTML}
                              </div>`;
      $('.m-main__container__inner__form__descript__box__up').append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
      if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
        $.ajax({
      
          url: '/items/get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
          $('#grandchildren_wrapper').remove();
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
  
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
      }
    });
    // 子カテゴリー選択後のイベント class="listing-select-wrapper__box--select" id="grandchild_category" name="category_id"
    $('.m-main__container__inner__form__descript__box__up').on('change', '#child_category', function(){
      var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      
      if (childId != "---"){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
            $('#size_wrapper').remove();
            $('#brand_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              // console.log(grandchild)
              insertHTML += appendOption(grandchild);
            });
            
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
      }
    });
  });
}
  });