$(document).on("turbolinks:load",function(){
  if($('#code4').length){
    var canvas = document.getElementById('step4');
    if (canvas.getContext){
      var context = canvas.getContext("2d");
      context.lineWidth = 3;

      // 赤線
      context.beginPath();
      context.strokeStyle = "#EA352D";
      context.moveTo(28, 20);
      context.lineTo(368, 20);
      context.stroke();

      // 灰色線
      context.beginPath();
      context.strokeStyle = "#d3d3d3";
      context.moveTo(368, 20);
      context.lineTo(465, 20);
      context.stroke(); 

      // 会員情報○
      context.beginPath () ;
      context.arc( 28, 20, 6.5, 0, Math.PI*2, false) ;
      context.fillStyle = "#EA352D" ;
      context.fill() ;

      // 電話番号認証○
      context.beginPath () ;
      context.arc( 143, 20, 6.5, 0, Math.PI*2, false) ;
      context.fillStyle = "#EA352D" ;
      context.fill() ;

      // 住所入力○
      context.beginPath () ;
      context.arc( 258, 20, 6.5, 0, Math.PI*2, false) ;
      context.fillStyle = "#EA352D" ;
      context.fill() ;

      // 支払い方法○
      context.beginPath () ;
      context.arc( 368, 20, 6.5, 0, Math.PI*2, false) ;
      context.fillStyle = "#EA352D" ;
      context.fill() ;

      // 完了○
      context.beginPath () ;
      context.arc( 465, 20, 6.5, 0, Math.PI*2, false) ;
      context.fillStyle = "#d3d3d3" ;
      context.fill() ;
    }
  }
})
