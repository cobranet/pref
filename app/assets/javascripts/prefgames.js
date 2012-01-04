/* crating Card sprite */

function newCard() {
    var card = {
        canvas: 0,
	ctx: 0, 
	x: 0,
        y: 0,
        animation: 0,
        currentFrame: 0,
        width: 72,
        height: 96,
        image: 0,
        currentStep: 0,
        is_ready: 0,
        initCard: function(canvas,x,y,width,height,img_file){
            card.is_ready = false;
            card.x = x;
            card.y = y;
            card.width = width;
            card.height = height;
            card.canvas = canvas; // ? nije mi bas jasno zasto 
            card.canvas.setAttribute('width',width);
            card.canvas.setAttribute('height',height);
            card.ctx = card.canvas.getContext('2d');
            card.loadImage(img_file); 
        },
        loadImage: function(img_file){
            card.image = new Image();
            card.image.onload = function () { card.is_ready = true; };
            card.image.src = img_file;
        },
        drawImage: function(){
            card.ctx.clearRect(0,0,card.width,card.height); // clear previous frame
	    if ( card.is_ready) {
                var srcX = 0;
		var srcY = 0;
                var srcW = 90;
                var srcH = 70;
                card.ctx.drawImage(card.image,0,0,72,96,0,0,card.width,card.height); // drawimage  
            }
        },
        
    };
    return card;
};

/* main table object */
var cardT = {
    cardw : 72,  // initial card width
    cardh : 96, // initial card height
    canvas_el : 0, // canvas
    ctx : 0, // context,
    card : 0, // card object /
    setup: function(){
	cardT.canvas_el = $('#main').get(0);
        cardT.ctx = cardT.canvas_el.getContext('2d');
        /* new canvas for card */
        var new_canvas = document.createElement('canvas');
        cardT.card = newCard();
        cardT.card.initCard(new_canvas,100,100,cardT.cardw,cardT.cardh,'/assets/9D.png');
        /* background */
        
        cardT.background = new Image();
        cardT.background.onload = function(){
	    cardT.background.ready = true;
            cardT.timer = setInterval(cardT.drawFrame,40);
	};
        cardT.background.src = '/assets/9D.png';
    },
    drawFrame: function(){
        cardT.ctx.clearRect(0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        cardT.ctx.drawImage(cardT.background,0,0);
        if(cardT.card) { // if card exists
            cardT.card.drawImage();
            cardT.ctx.drawImage(cardT.card.canvas,cardT.card.x,cardT.card.y); 
        } 
    },
    resize_canvas: function(){
      var inner =  window.innerWidth;
      cardT.canvas_el.width = inner*0.8
      cardT.canvas_el.height = cardT.canvas_el.width*0.5
	cardT.cardw = 72 * 640/inner;
        cardT.cardh = 96 * 640/inner;
    },
    get_table_data: function(){
      var jqXHR= $.get("9/data")
	    .success( function(){ alert("succes"); })
            .error( function(data){ 
                      $("#jerror").html(data.responseText); 
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
    cardT.resize_canvas();   
});


   