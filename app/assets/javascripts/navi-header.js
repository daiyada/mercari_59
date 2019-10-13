$(document).on('turbolinks:load', function() { 
$(document).ready(function(){
  $('.m-grand-child-wrap').hide();
  $('.m-child-wrap').hide();
  $('.m-parent').hide();
  //親要素の吹き出し
  $('.m-parent1').hover(function(){
  $('.m-parent-wrap').show();
  $('.m-parent').show();
  },function(){
    $('.m-parent-wrap').hide();
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
                  $(childid).css('background-color','rgb(233, 233, 233)');
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
});