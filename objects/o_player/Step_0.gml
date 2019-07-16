//INIT
w_key=false;
a_key=keyboard_check(ord("A"));
s_key=false;
d_key=keyboard_check(ord("D"));
a_cover=false;
d_cover=false;


//Get Player Input
airborne=!place_meeting(x,y+1,o_wall);
show_debug_message(airborne);

if(keyboard_check_pressed(ord("A"))){
	lastkey="A";
}
if(keyboard_check_pressed(ord("D"))){
	lastkey="D";
}
if(keyboard_check(ord("A")) && lastkey=="A"){
	if(d_key){
		d_key=false;
		a_cover=true;
	}
	a_key=true;
	if(place_meeting(x,y+1,o_wall)){
		lastmovement = "A";
	}
}
if(keyboard_check(ord("D")) && lastkey=="D"){
	if(a_key){
		a_key=false;
		d_cover=true;
	}
	d_key=true;
	if(place_meeting(x,y+1,o_wall)){
		lastmovement = "D";
	}

}
if(keyboard_check_released(ord("A"))){
	if(a_cover){
		d_key=true;
		lastmovement = "D";
	}
	else{
		lastmovement = 0;
	}
	a_key = false;
}
if(keyboard_check_released(ord("D"))){
	if(d_cover){
		a_key=true;
		lastmovement = "A";
	}
	else{
		lastmovement = 0;
	}
	d_key = false;
}

key_jump = keyboard_check(ord("W"));

//Calculate movement
//if there is a collision then I can change directions
var move = d_key - a_key; //add acceleration //'var' are temporary existing only in a given step
if(airborne){
	if(lastmovement=="A"){
		hsp = -walksp+1.5*move; //total amount of pixels moved and the direction
		previous_movement = hsp;
	}else if(lastmovement=="D"){
		hsp = walksp+1.5*move;
		previous_movement = hsp;
	}else if(lastmovement==0){
		hsp = previous_movement+1.5*move;
	}
}else{
	hsp = move * walksp; //total amount of pixels moved and the direction
	previous_movement=0;
	//show_debug_message("here");
}
vsp+= grv;
if(place_meeting(x,y+1,o_wall) && key_jump){
	vsp=-6.5;
}

//Horizontal Collision
if(place_meeting(x+hsp,y,o_wall)){
	while(!place_meeting(x+sign(hsp),y,o_wall)){ //sign(x) = 1 if x>0 | -1 if x<0
		x+=sign(hsp);
	}
	hsp = 0;
}
x += hsp;

//Vertical Collision
if(place_meeting(x,y+vsp,o_wall)){
	while(!place_meeting(x,y+sign(vsp),o_wall)){
		y+=sign(vsp);
	}
	vsp = 0;
}
y += vsp;