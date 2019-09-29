extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var REFERENCE = 0
var MAP = [load("res://Location/Mapas/Mapa0.tscn"),load("res://Location/Mapas/Mapa1.tscn"),load("res://Location/Mapas/Mapa2.tscn")]#,load("res://Location/Mapas/Mapa3.tscn"),load("res://Location/Mapas/Mapa4.tscn")]
var SPACE = load("res://Location/Space/Space.tscn")
var START = load("res://Location/Mapas/Start.tscn")
var SHIP_POSITION = Vector2(0,0)
var SHIP_FUEL = 100
var SHIP_SHIELD = 100
var GOT_WATER = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var PUT_START = START.instance()
	PUT_START.name = "Planet"
	PUT_START.CORE = self
	get_node("Sandbox").add_child(PUT_START)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _transition(planet):
	if planet != -1:
		REFERENCE = planet
	get_node("Transition").play("Enter")

func _on_Transition_animation_finished(anim_name):
	if anim_name == "Enter":
		var KILL = get_node("Sandbox").get_children()
		if KILL[0].name == "Space":
			KILL[0].queue_free()
			if !GOT_WATER || REFERENCE!=0:
				var PUT_MAP = MAP[REFERENCE].instance()
				PUT_MAP.name = "Planet"
				PUT_MAP.CORE = self
				get_node("Sandbox").add_child(PUT_MAP)
			elif GOT_WATER && REFERENCE==0:
				if !get_node("Timer").is_stopped():
					if get_node("Timer").wait_time-get_node("Timer").time_left<50:
						prints("Best Ending ",300-get_node("Timer").time_left )
					elif get_node("Timer").wait_time-get_node("Timer").time_left>=50 && get_node("Timer").wait_time-get_node("Timer").time_left<179:
						prints("OK Ending ",300-get_node("Timer").time_left)
				else:
					prints("Bad_ending")
					
				#prints("ENDGAME ",get_node("Timer").time_left)# TIME <50 seg, ending 1
				                 # time >50 seg, <5 min ending 2
								 # time > 5 min ending 3
		else:
			KILL[0].queue_free()
			var PUT_SPACE = SPACE.instance()
			PUT_SPACE.name = "Space"
			PUT_SPACE.CORE = self
			PUT_SPACE.SHIP_POSITION = SHIP_POSITION
			PUT_SPACE.SHIP_FUEL = SHIP_FUEL
			PUT_SPACE.SHIP_SHIELD = SHIP_SHIELD
			get_node("Sandbox").add_child(PUT_SPACE)
		get_node("Transition").play("Inside")
		
