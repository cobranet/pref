/* crating Card sprite */

function newCard() {
    var card = {
        canvas: 0,
	ctx: 0,
        visible: false, 
        id: 0,
	x: 0,
        str_value: "",
        y: 0,
        newx: 0,
        newy: 0, 
        inMove: false,
        width: 72,
        height: 96,
        image: 0,
        is_ready: 0,
        selected: false,
        setX: function(x){
            card.x = x;
	    card.newx = x;
        },
        setY: function(y){
            card.y = y;
	    card.newy =y;
        },
        initCard: function(canvas,x,y,width,height,img_file){
            card.is_ready = false;
            card.x = x;
            card.y = y;
            card.newx = x;
            card.newy = y;
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
        drawImage: function(w,h){
            
            if ( card.visible == false ) { return; };  
            card.canvas.setAttribute('width',w);
            card.canvas.setAttribute('height',h);

            card.ctx.clearRect(0,0,card.width,card.height); // clear previous frame
            card.width = w
            card.height = h
  
	    if ( card.is_ready) {
                var srcX = 0;
		var srcY = 0;
                card.ctx.drawImage(card.image,0,0,72,96,0,0,card.width,card.height); // drawimage  
            }
        },
        move: function(){

            if (card.inMove == false){
		return; 
            }
            if (card.x == card.newx && card.y == card.newy) {
		card.inMove = false;
                return; 
	    }
            if (card.x>card.newx ){
		card.x = card.x-2; 
            }
            if (card.x<card.newx){
                card.x = card.x+2;
	    }
            if (card.y>card.newy ){
		card.y = card.y-2; 
            }
            if (card.y < card.newy){
                card.y = card.y + 2;
	    }
        }
        
    };
    return card;
};

/* main table object */
var cardT = {
    playposx: 100,
    playposy: 10,
    allcards: [ '7S', '8S', '9S', 'TS', 'JS', 'QS', 'KS', 'AS',
               '7D', '8D', '9D', 'TD', 'JD', 'QD', 'KD', 'AD',
               '7H', '8H', '9H', 'TH', 'JH', 'QH', 'KH', 'AH',
        	'7C', '8C', '9C', 'TC', 'JC', 'QC', 'KC', 'AC'],
    cardw : 72,  // initial card width
    cardh : 96, // initial card height
    canvas_el : 0, // canvas
    ctx : 0, // context,
    game: 0, // object returned by get data 
    cards : [], // Array of card object /
    cards_in_move: [], // Array of cards in move... 
    setup: function(){
	cardT.canvas_el = $('#main').get(0);
        $('#main').click(cardT.click);
        cardT.ctx = cardT.canvas_el.getContext('2d');
        /* new canvas for card */

        for (var i=0;i<cardT.allcards.length;i++) { 
           var new_canvas = document.createElement('canvas');
           cardT.cards[i] = newCard();
           cardT.cards[i].initCard(new_canvas,100,100,cardT.cardw,cardT.cardh,'/assets/'+ cardT.allcards[i] + '.png');
           cardT.cards[i].id = i;
           cardT.cards[i].str_value = cardT.allcards[i];   
	}
        /* background */
        
        cardT.background = new Image();
        cardT.background.onload = function(){
	    cardT.background.ready = true;
            cardT.timer = setInterval(cardT.drawFrame,40);
	};
        cardT.background.src = '/assets/back.png';


    },
    drawFrame1: function(){
         
        cardT.ctx.clearRect(0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        cardT.ctx.drawImage(cardT.background,0,0,640,400,0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        for (var i = 0 ; i < 32;i++) { 
            var c = cardT.cards[i];
            if(c) { // if card exists
               c.drawImage();
               cardT.ctx.drawImage(c.canvas,c.x,c.y); 
            }
	} 
    },
// if one card is selected all others dont
    select_card: function(id) {
	for ( var i=0;i<cardT.cards.length;i++){
            cardT.cards[id].selected = false; 
        }
        cardT.cards[id].selected = true;
    },    
// this is primitive game loop
    drawFrame: function(){
        cardT.moveCards();
        cardT.ctx.clearRect(0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        cardT.ctx.drawImage(cardT.background,0,0,640,400,0,0,cardT.canvas_el.width,cardT.canvas_el.height);
        if ( cardT.game == 0 ) { 
            return; 
        }
        for (var i = 0 ; i < cardT.game.mycards.length;i++) { 
            var c = cardT.cards[cardT.game.mycards[i].id];
            if(c) { // if card exists
	       c.drawImage(cardT.cardw,cardT.cardh);
               cardT.ctx.drawImage(c.canvas,c.x,c.y); 
            }
	} 
    },
     // move all cards 
    moveCards: function(){
	for (var i = 0; i < cardT.cards.length; i++){
            if (cardT.cards[i].inMove == true) {
                cardT.cards[i].move();
	    }
	}           
    },
    resize_canvas: function(){
        var inner =  window.innerWidth;
        if (inner < 700) {
           cardT.canvas_el.width = inner*0.8;
          
           cardT.cardw = 72 * cardT.canvas_el.width / 640;
           cardT.cardh = cardT.cardw * 96/72;
           cardT.canvas_el.height = cardT.canvas_el.width*400*640;
	} else {
	    cardT.canvas_el.width = 640;
	    cardT.cardw = 72;
	    cardT.cardh = 96;
	    cardT.canvas_el.height = 400;
        }
    },
    play_card: function(card_id){
        var lcard = cardT.cards[card_id];
        lcard.inMove = true;
        lcard.newx = cardT.playposx;
        lcard.newy = cardT.playposy;
//        var game_id=$("#game_id").html();
//	$.post("/prefgames/"+game_id+"/data",card_id);
    },
    set_player_cards: function(data,channel){
        var g = $.parseJSON(data.gm);
        cardT.game = g;
        for (var i= 0;i<g.mycards.length;i++){
            cardT.cards[g.mycards[i].id].visible = true;
            cardT.cards[g.mycards[i].id].setX(g.mycards[i].x);
            cardT.cards[g.mycards[i].id].setY( g.mycards[i].y); 
        }
    },
    card_clicked: function(card_id){
        var lcard = cardT.cards[card_id]
        if ( lcard.inMove == true ) { return; };
        if (lcard.selected == true ){
            cardT.play_card(card_id);
            return;
        }  
        lcard.newy = lcard.y - 10;
        lcard.inMove = true; 
        cardT.select_card(lcard.id);
    },
/* clicking is on card or event */
    click: function(event){
        var pos = $('#main').position();
        var x = event.pageX-pos.left;
        var y = event.pageY-pos.top;
        var clicked = -1;   
        for (var i = 0; i < cardT.game.mycards.length; i++){
            var card = cardT.game.mycards[i];
            if (  x >  card.x && x < card.x+cardT.cardw
                  && y > card.y && y < card.y+cardT.cardh ){
                    clickked = i;
	    }
	}
        if (clickked != -1){
            cardT.card_clicked(cardT.game.mycards[clickked].id);	}
    }	
};

/* on load */

$(function () {
    cardT.setup();
    cardT.resize_canvas();
    var user_id=$("#user_id").html();
    var game_id=$("#game_id").html();
    PrivatePub.subscribe("/game/"+game_id+"/"+user_id,cardT.set_player_cards);
    
});

/* resize canvas when resize window */
$(window).resize( function(){
    cardT.resize_canvas();   
});

   