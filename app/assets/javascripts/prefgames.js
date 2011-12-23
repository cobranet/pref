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
      var jqXHR= $.get("9/data")
	    .success( function(){ alert("succes"); })
            .error( function(data){ 
                      $("#jerror").html(data.responseText); 
             });
    }	
};

/* propulsion.js sprite engine */


/* on load */ 
$(function () {
    cardT.setup();
    cardT.resize_canvas();
(function() {   //  start of propulsion
	var spr=PP.spr,rm=PP.rm,obj=PP.obj,snd=PP.snd,al=PP.al,global=PP.global,Alarm=PP.Alarm,collision=PP.collision,draw=PP.draw,init=PP.init,key=PP.key,load=PP.load,loop=PP.loop,mouse=PP.mouse,physics=PP.physics,Sound=PP.Sound,SoundEffect=PP.SoundEffect,Sprite=PP.Sprite,view=PP.view,walkDown=PP.walkDown;
    var can = document.getElementById("main");
    init("main");
    spr.c1 = new Sprite('9D.png',1,0,0);

/*
    load(function(t){
        obj.card = {
            initialize: function(){
              t.x = 100;
	      t.y = 100;
              t.sprite = spr.c1;
	    },
          draw: function(){
              t.sprite.draw(t.x,t.y);
          }
        };
	rm.play = function(){
            loop.register(obj.card);
        };
        loop.active = true;
	loop.room =rm.play();
    }());
*/
}()); // end of propulsion
});

/* resize canvas when resize window */
$(window).resize( function(){
 //   console.log('resize');
    cardT.resize_canvas();   
});

