$(document).ready(function(){
  $('.m-grand-child-wrap').hide();
  $('.m-child-wrap').hide();
  $('.m-parent').hide();
  //親要素の吹き出し
  $('.m-parent1').hover(function(){
  $('.m-parent').show();
  },function(){
  });
  
  //親要素が消えないためm-mainに乗ったら消える
  $('.m-main').hover(function(){
    $('.m-parent').hide();
  },function(){
  });
  //子要素追加
  $('.m-parent').hover(function(){
    $('.m-grand-child-wrap').hide();
    $('.m-child__link').css('background-color','white');
    $(this).addClass('active');
    var children = $('.active').children('.m-child-wrap');
    children.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.m-child-wrap').hide(); 
  });
  
  //孫要素追加
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
           //洗濯中のchild要素の色が残るようにした
           var preinput =""
           var input = $(this).attr('id'); 
           $(function(){
            var childid =  '#'+ input.toString()
                if(preinput != input){
                  $('.m-child__link').css('background-color','white');
                  $(childid).css('background-color','gray');
                  preinput = input
              }
            });
        
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
