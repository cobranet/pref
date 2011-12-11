/* main table object */
var cardT = {
    canvas_el : 0,
    setup: function(){
      cardT.canvas_el = $('#main')[0]
    },
    resize_canvas: function(){
      cardT.canvas_el.width = window.innerWidth*0.8
      cardT.canvas_el.height = cardT.canvas_el.width*0.5
    },
    get_table_data: function(){
	$.ajax( 
           { 
               type: 'GET',
               url: "1/data",
	       success: function (data){
                   cardT.data = data;
	       },
	       error: function(data){
                   alert(data);
               }
	   });
    }	
};
/* on load */ 
$(function () {
    cardT.setup();
    cardT.resize_canvas();
}); 

/* resize canvas when resize window */
$(window).resize( function(){
 //   console.log('resize');
    cardT.resize_canvas();   
});

