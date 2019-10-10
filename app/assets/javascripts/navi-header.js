$(document).ready(function(){
  $('.m-grand-child-wrap').hide();
  $('.m-child-wrap').hide();
  $('.m-parent').hide();
  //親要素の吹き出し
  $('.m-header__inner__low__lleft__category').hover(function(){
  $('.m-parent').show();
  },function(){
  });
  
  //親要素が消えないためm-mainに乗ったら消える
  $('.m-main').hover(function(){
    $('.m-parent').hide();
  },function(){
  });
  //孫要素追加
  $('.m-parent').hover(function(){
    $('.m-grand-child-wrap').hide();
    $(this).addClass('active');
    var children = $('.active').children('.m-child-wrap');
    children.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.m-child-wrap').hide(); 
  });
        var search_list = "";
        $('.m-child__link').hover(function(){
            function appendProduct(grand) {
            search_list = $(".m-grand-child-wrap");
            var html = `<li class="m-grand-child"></li>
            <a class="m-grand-child__link" href="">
            ${ grand.name }
            </a>`
              search_list.append(html);
           }
           var input = $(this).attr('id'); 
        
            $.ajax({
              type: 'GET',
              url: '/items',
              data: { keyword: input },
              dataType: 'json'
            })

              .done(function(grands) {
                $('.m-grand-child-wrap').empty(); //親が変更された時、子以下を削除するする
                $('.m-grand-child-wrap').show();
                if (grands.length !== 0) { 
                  grands.forEach(function(grand){
                    appendProduct(grand);     
                  });
                  }          
              }); 
        })
    
});
