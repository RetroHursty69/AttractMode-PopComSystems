////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// POP COM 2022
// Dwayne Hurst
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {
</ label="--------  Main theme layout  --------", help="Show or hide additional images", order=1 /> uct1="select below";
   </ label="Select wheel", help="Select wheel", options="wheel", order=4 /> enable_list_type="wheel";
   </ label="Select spinwheel art", help="The artwork to spin", options="wheel", order=5 /> orbit_art="wheel";
   </ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=6 /> transition_ms="25"; 
   </ label="Enable box art", help="Select box art", options="Yes,No", order=22 /> enable_gboxart="Yes";
   </ label="Enable cartridge art", help="Select cartridge art", options="Yes,No", order=23 /> enable_gcartart="Yes";
   </ label="Game media style", help="Select game media style", options="Animated,Static", order=26 /> enable_mediastyle="Animated"    
</ label=" ", help=" ", options=" ", order=10 /> divider5="";
</ label="--------    Miscellaneous    --------", help="Miscellaneous options", order=16 /> uct6="select below";
   </ label="Enable monitor static effect", help="Show static effect when snap is null", options="No", order=18 /> enable_static="No"; 
   </ label="Random Wheel Sounds", help="Play random sounds when navigating games wheel", options="Yes", order=25 /> enable_random_sound="Yes";
}

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.font="badabb.ttf";

// modules
fe.load_module("fade");
fe.load_module( "animate" );
fe.load_module("scrollingtext");

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

// now position and pinch surface of snap
// adjust the below values for the game video preview snap
surface_snap.set_pos(flx*0.239, fly*0.192, flw*0.56, flh*0.738);
surface_snap.skew_y = 0;
surface_snap.skew_x = 0;
surface_snap.pinch_y = 0;
surface_snap.pinch_x = 0;
surface_snap.rotation = -4.7;
surface_snap.preserve_aspect_ratio = false;

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

//top background color

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 2000 ) / 2000.0) * (20 - (1 - 1)) + 1);
            ref.file_name = "ColorTop/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("popbubblePOP/1.png", flx*0.0, fly*0.00, flw*1, flh*1),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = 0, end = 0, time = 1, tween = Tween.Back
}
OBJECTS.wordpop1.preserve_aspect_ratio = true;
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//////////////////////////////////////////////////////////////////////////////////////
//left background color

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 2000 ) / 2000.0) * (20 - (1 - 1)) + 1);
            ref.file_name = "ColorLeft/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("popbubblePOP/1.png", flx*0.0, fly*0.00, flw*1, flh*1),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = 0, end = 0, time = 1, tween = Tween.Back
}
OBJECTS.wordpop1.preserve_aspect_ratio = true;
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//bottom background color
class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 2000 ) / 2000.0) * (20 - (1 - 1)) + 1);
            ref.file_name = "ColorBottom/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("ColorBottom/1.png", flx*0.0, fly*0.00, flw*1, flh*1),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = 0, end = 0, time = 1, tween = Tween.Back
}
OBJECTS.wordpop1.preserve_aspect_ratio = true;
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);


//////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////
// Load background image
local b_art = fe.add_image("ComicBorder.png", 0, 0, flw, flh );

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// The following section sets up what type and wheel and displays the users choice
if ( my_config["enable_list_type"] == "listbox" )
{
local listbox = fe.add_listbox( flx*0.01, fly*0.025, flw*0.325, flh*0.55 );
listbox.rows = 20;
listbox.charsize = 40;
listbox.set_rgb( 0, 0, 0 );
listbox.bg_alpha = 0;
listbox.align = Align.Left;
listbox.selbg_alpha = 0;
listbox.sel_red = 225;
listbox.sel_green = 0;
listbox.sel_blue = 0;
}

// Play random sound when transitioning to next / previous game on wheel
function sound_transitions(ttype, var, ttime) 
{
	if (my_config["enable_random_sound"] == "Yes")
	{
		local random_num = floor(((rand() % 1000 ) / 1000.0) * (124 - (1 - 1)) + 1);
		local sound_name = "sounds/GS"+random_num+".mp3";
		switch(ttype) 
		{
		case Transition.EndNavigation:		
			local Wheelclick = fe.add_sound(sound_name);
			Wheelclick.playing=true;
			break;
		}
		return false;
	}
}
fe.add_transition_callback("sound_transitions")

//////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////

//word pop bubble

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 3000 ) / 3000.0) * (30 - (1 - 1)) + 1);
            ref.file_name = "popbubblePOP/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("popbubblePOP/1.png", flx*0.0, fly*-0.03, flw*0.3, flh*0.4),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = 150, end = 0, time = 700, tween = Tween.Back
}
OBJECTS.wordpop1.preserve_aspect_ratio = true;
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//////////////////////////////////////////////////////////////////////////////////////

//Year 

::OBJECTS <- {
  yeartest = fe.add_image("popyearPOP/[Year].png", flx*0.04, fly*0.1, flw*0.22, flh*0.14 ),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "scale", start = 0.01, end = 1, time = 850, tween = Tween.Back, delay = 300
}
OBJECTS.yeartest.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.yeartest, move_transition1 ) );

//////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////

//box pop

::OBJECTS <- {
  boxpop = fe.add_image("boxesPOP/[DisplayName].png", flx*0.05, fly*0.53, flw*0.2, flh*0.42),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "x", start = flx*-2.0, end = flx*0.01, time = 750, tween = Tween.Linear
}
OBJECTS.boxpop.preserve_aspect_ratio = true;
OBJECTS.boxpop.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.boxpop, move_transition1 ) );
PopImage1(OBJECTS.boxpop);

//////////////////////////////////////////////////////////////////////////////////////

// Static media style
if ( my_config["enable_gboxart"] == "Yes" && my_config["enable_mediastyle"] == "Static" )
{
local boxartstatic = fe.add_artwork("boxart", flx*0.005, fly*0.32, flw*0.12, flh*0.18  );
boxartstatic.preserve_aspect_ratio = true;
}

if ( my_config["enable_gcartart"] == "Yes" && my_config["enable_mediastyle"] == "Static" )
{
local cartartstatic = fe.add_artwork("cartart", flx*0.09, fly*0.39, flw*0.09, flh*0.12 );
cartartstatic.preserve_aspect_ratio = true;
}

// Animated media style
if ( my_config["enable_gboxart"] == "Yes" && my_config["enable_mediastyle"] == "Animated" )
::OBJECTS <- {
 boxart = fe.add_artwork("boxart", flx*-0.2, fly*0.32, flw*0.14, flh*0.2 ),
}

if ( my_config["enable_gboxart"] == "Yes" && my_config["enable_mediastyle"] == "Animated" )
{
//Animation for Global & Expert Mode
local move_transition1 = {
  when = Transition.EndNavigation ,property = "x", start = flx*-0.2, end = flx*0.005, time = 900, tween = Tween.Back
}
OBJECTS.boxart.preserve_aspect_ratio = true;
OBJECTS.boxart.trigger = Transition.EndNavigation;
//Animation
animation.add( PropertyAnimation( OBJECTS.boxart, move_transition1 ) );
}

if ( my_config["enable_gcartart"] == "Yes" && my_config["enable_mediastyle"] == "Animated" )
::OBJECTS <- {
 cartart = fe.add_artwork("cartart", flx*-0.2, fly*0.39, flw*0.09, flh*0.12 ),
}

if ( my_config["enable_gcartart"] == "Yes" && my_config["enable_mediastyle"] == "Animated" )
{
//Animation for Global & Expert Mode
local move_transition1 = {
  when = Transition.EndNavigation ,property = "x", start = flx*-0.2, end = flx*0.09, time = 900, tween = Tween.Back
}
OBJECTS.cartart.preserve_aspect_ratio = true;
OBJECTS.cartart.trigger = Transition.EndNavigation;
//Animation
animation.add( PropertyAnimation( OBJECTS.cartart, move_transition1 ) );
}


//////////////////////////////////////////////////////////////////////////////////////
//category genre 

class GenreImage1
{
    mode = 1;       //0 = first match, 1 = last match, 2 = random
    supported = {
        //filename : [ match1, match2 ]
        "action": [ "action","gun", "climbing" ],
        "adventure": [ "adventure" ],
        "arcade": [ "arcade" ],
        "casino": [ "casino" ],
        "computer": [ "computer" ],
        "console": [ "console" ],
        "collection": [ "collection" ],
        "fighter": [ "fighting", "fighter", "beat-'em-up" ],
        "handheld": [ "handheld" ],
		"jukebox": [ "jukebox" ],
        "platformer": [ "platformer", "platform" ],
        "mahjong": [ "mahjong" ],
        "maze": [ "maze" ],
        "paddle": [ "breakout", "paddle" ],
        "puzzle": [ "puzzle" ],
	    "pinball": [ "pinball" ],
	    "quiz": [ "quiz" ],
	    "racing": [ "racing", "driving","motorcycle" ],
        "rpg": [ "rpg", "role playing", "role-playing" ],
	    "rhythm": [ "rhythm" ],
        "shooter": [ "shooter", "shmup", "shoot-'em-up" ],
	    "simulation": [ "simulation" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer", "tennis", "hockey" ],
        "strategy": [ "strategy"],
        "utility": [ "utility" ]
    }

    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local cat = " " + fe.game_info(Info.Category, var).tolower();
            local matches = [];
            foreach( key, val in supported )
            {
                foreach( nickname in val )
                {
                    if ( cat.find(nickname, 0) ) matches.push(key);
                }
            }
            if ( matches.len() > 0 )
            {
                switch( mode )
                {
                    case 0:
                        ref.file_name = "glogosPOP/" + matches[0] + "1.png";
                        break;
                    case 1:
                        ref.file_name = "glogosPOP/" + matches[matches.len() - 1] + "1.png";
                        break;
                    case 2:
                        local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
                        ref.file_name = "glogosPOP/" + matches[random_num] + "1.png";
                        break;
                }
            } else
            {
			      local random_num = floor(((rand() % 1000 ) / 1000.0) * (20 - (1 - 1)) + 1);
                  ref.file_name = "glogosPOP/unknown" + random_num + ".png";
//				  ref.file_name = "glogosPOP/unknown1.png";
            }
        }
    }
}
		
::OBJECTS <- {
  glogo1 = fe.add_image("glogosPOP/blank.png", flx*0.29, fly*0.005, flw*0.4 flh*0.16),
}

local move_transition1 = {
  when = Transition.EndNavigation ,property = "y", start = fly*-2.0, end = fly*0.01, time = 950, tween = Tween.Linear
}
OBJECTS.glogo1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.glogo1, move_transition1 ) );
GenreImage1(OBJECTS.glogo1);

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////

//word pop bubble 2

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 3000 ) / 3000.0) * (30 - (1 - 1)) + 1);
            ref.file_name = "popbubblePOP/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop5 = fe.add_image("popbubblePOP/1.png", flx*0.59, fly*0.72, flw*0.23, flh*0.314),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -200, end = 0, time = 800, tween = Tween.Back
}
OBJECTS.wordpop5.preserve_aspect_ratio = true;
OBJECTS.wordpop5.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop5, move_transition1 ) );
PopImage1(OBJECTS.wordpop5);

//////////////////////////////////////////////////////////////////////////////////////

//word pop word 2

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 3000 ) / 3000.0) * (30 - (1 - 1)) + 1);
            ref.file_name = "popwordPOP/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop6 = fe.add_image("popwordPOP/1.png", flx*0.58, fly*0.82, flw*0.25, flh*0.13),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "scale", start = 0.01, end = 1, time = 850, tween = Tween.Back, delay = 350
}
OBJECTS.wordpop6.preserve_aspect_ratio = true;
OBJECTS.wordpop6.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop6, move_transition1 ) );
PopImage1(OBJECTS.wordpop6);

//////////////////////////////////////////////////////////////////////////////////////

//word pop bubble 3

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 3000 ) / 3000.0) * (30 - (1 - 1)) + 1);
            ref.file_name = "popbubblePOP/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("popbubblePOP/1.png", flx*0.7, fly*0.0, flw*0.2, flh*0.3),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = 100, end = 0, time = 500, tween = Tween.Back
}
OBJECTS.wordpop1.preserve_aspect_ratio = true;
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//////////////////////////////////////////////////////////////////////////////////////

//word pop word 3

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 3000 ) / 3000.0) * (30 - (1 - 1)) + 1);
            ref.file_name = "popwordPOP/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop2 = fe.add_image("popwordPOP/1.png", flx*0.7, fly*0.09, flw*0.2, flh*0.11),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "scale", start = 0.01, end = 1, time = 950, tween = Tween.Back, delay = 350
}
OBJECTS.wordpop2.preserve_aspect_ratio = true;
OBJECTS.wordpop2.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop2, move_transition1 ) );
PopImage1(OBJECTS.wordpop2);


//////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////
//vertical wheel curved
fe.load_module( "conveyor" );

local wheel_x = [ flx*0.89, flx*0.890, flx*0.841, flx*0.815, flx*0.79, flx*0.77, flx*0.72, flx*0.77, flx*0.79, flx*0.815, flx*0.8406, flx*0.85, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.28, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  150,  150,  150,  150,  150,  150, 255,  150,  150,  150,  150,  150, ];
local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.168,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
local num_arts = 12;

class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["orbit_art"] ) );
                preserve_aspect_ratio = true;
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)
for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

conveyor <- Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }


//Play random sound when transitioning to next / previous game on wheel
function sound_transitions(ttype, var, ttime) 
{
	if (my_config["enable_random_sound"] == "Yes")
	{
		local random_num = floor(((rand() % 1000 ) / 1000.0) * (124 - (1 - 1)) + 1);
		local sound_name = "sounds/GS"+random_num+".mp3";
		switch(ttype) 
		{
		case Transition.EndNavigation:		
			local Wheelclick = fe.add_sound(sound_name);
			Wheelclick.playing=true;
			break;
		}
		return false;
	}
}
fe.add_transition_callback("sound_transitions")

////////////////////////////////////////////////////////

local point = fe.add_image("pointer.png", flx*0.95, fly*0.4, flw*0.1, flh*0.225);

local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 110,
    end = 255,
    time = 300
}
animation.add( PropertyAnimation( point, alpha_cfg ) );

local movey_cfg = {
    when = Transition.ToNewSelection,
    property = "y",
    start = point.y,
    end = point.y,
    time = 200
}
animation.add( PropertyAnimation( point, movey_cfg ) );

local movex_cfg = {
    when = Transition.ToNewSelection,
    property = "x",
    start = flx*0.91,
    end = point.x,
    time = 200	
}	
animation.add( PropertyAnimation( point, movex_cfg ) );


//////////////////////////////////////////////////////////////////////////////////

//Title text info
local textt = fe.add_text( "[DisplayName]", flx*0.315, fly*0.88, flw*0.57, flh*0.025  );
textt.set_rgb( 0, 0, 0 );
//textt.style = Style.Bold;
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = false;

local textt = fe.add_text( "[Title]", flx*0.315, fly*0.908, flw*0.22, flh*0.025  );
textt.set_rgb( 0, 0, 0 );
//textt.style = Style.Bold;
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = false;

local gamecount = fe.add_text( "System Count: [ListEntry]-[ListSize]", flx*0.315, fly*0.938, flw*0.5, flh*0.025 );
gamecount.set_rgb( 0, 0, 0 );
//gamecount.style = Style.Italic;
gamecount.align = Align.Left;
gamecount.rotation = 0;

