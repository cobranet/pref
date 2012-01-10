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
        drawImage: function(table){
       //     card.width = table.cardw;
        //    card.height = table.cardh;  
            card.ctx.clearRect(0,0,card.width,card.height); // clear previous frame
	    if ( card.is_ready) {
                var srcX = 0;
		var srcY = 0;
                card.ctx.drawImage(card.image,0,0,72,96,0,0,card.width,card.height); // drawimage  
            }
        },
        
    };
    return card;
};

/* main table object */
var cardT = {
    allcards: [ '7S', '8S', '9S', 'TS', 'JS', 'QS', 'KS', 'AS',
               '7D', '8D', '9D', 'TD', 'JD', 'QD', 'KD', 'AD',
               '7H', '8H', '9H', 'TH', 'JH', 'QH', 'KH', 'AH',
        	'7C', '8C', '9C', 'TC', 'JC', 'QC', 'KC', 'AC'],
    cardw : 72,  // initial card width
    cardh : 96, // initial card height
    canvas_el : 0, // canvas
    ctx : 0, // context,
    cards : [], // Array of card object /
    setup: function(){
	cardT.canvas_el = $('#main').get(0);
        cardT.ctx = cardT.canvas_el.getContext('2d');
        /* new canvas for card */

        for (var i=0;i<cardT.allcards.length;i++) { 
           var new_canvas = document.createElement('canvas');
           cardT.cards[i] = newCard();
           cardT.cards[i].initCard(new_canvas,100,100,cardT.cardw,cardT.cardh,'/assets/'+ cardT.allcards[i] + '.png');
	}
        /* background */
        
        cardT.background = new Image();
        cardT.background.onload = function(){
	    cardT.background.ready = true;
            cardT.timer = setInterval(cardT.drawFrame,40);
	};
        cardT.background.src = '/assets/back.png';
    },
    drawFrame: function(){
        cardT.ctx.clearRect(0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        cardT.ctx.drawImage(cardT.background,0,0,640,400);
        if(cardT.cards[1]) { // if card exists
            cardT.cards[1].drawImage();
            cardT.ctx.drawImage(cardT.cards[1].canvas,cardT.cards[1].x,cardT.cards[1].y); 
        } 
    },
    resize_canvas: function(){
      var inner =  window.innerWidth;
      cardT.canvas_el.width = inner*0.8
      cardT.canvas_el.height = cardT.canvas_el.width*0.5
   
    },
    get_table_data: function(){
      var jqXHR= $.getJSON("11/data")
	    .success(cardT.set_player_cards )
            .error( function(data){ 
                      $("#jerror").html(data.responseText); 
             });
    },
    set_player_cards: function(data){
        var g = $.parseJSON(data);
        for (var i= 0;i<g.mycards.length;i++){
           alert (g.mycards[i].id);
        }
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


   