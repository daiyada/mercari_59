// $(document).ready(function(){

//   $('.m-parent').hover(function(){
//     $(this).addClass('active');
//     var children = $('.active').children('.m-child-wrap');
//     children.show();
//   },function(){
//     $(this).removeClass('active');
//     $(this).children('.m-child-wrap').hide();
//   });

//   $('.m-child').hover(function(){
//     $(this).addClass('active2');
//     var grandChild = $('.active2').children('.m-grand-child-wrap');
//     grandChild.show();
//   },function(){
//     $(this).removeClass('active2');
//     $(this).children('.m-grand-child-wrap').hide();

//   });


//   var search_list = "";

//   $('.m-child__link').off('hover');
//   $('.m-child__link').hover(function(){
//       function appendProduct(grand) {
//       search_list = $(".m-grand-child-wrap");
//       var html = `<li class="m-grand-child"></li>
//       <a class="m-grand-child__link" href="">
//       ${ grand.name }
//       </a>`
    
//          search_list.append(html);
//         }
//     var input = $(this).attr('id'); 
//     // console.log(input)
//         $.ajax({
//           type: 'GET',
//           url: '/items',
//           data: { keyword: input },
//           dataType: 'json'
//         })

//         .done(function(grands) {
//           // $('.m-grand-child-wrap').hide();
//           $('.m-grand-child').remove(); //親が変更された時、子以下を削除するする
//         // $('#grandchildren_wrapper').remove();
//           if (grands.length !== 0) { 
//             grands.forEach(function(grand){
//               appendProduct(grand);     
          
//             console.log(grand) 
//           // console.log(grand[1])
//           // console.log(grand[2])
          
//            });
//           //  $('.m-grand-child').remove(); 
//           }
//           else{

//           }
//         })
//   // $('.m-grand-child-wrap').hide();
  
// });
