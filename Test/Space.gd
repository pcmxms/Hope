extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CORE
var SHIP_POSITION
var SHIP_FUEL
var SHIP_SHIELD
export var GRAVITY = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	if name == "Space":
		get_node("Ship").CORE = CORE
		get_node("Ship").position = CORE.SHIP_POSITION
		get_node("Ship").FUEL = SHIP_FUEL
		get_node("Ship").SHIELD = SHIP_SHIELD
		get_node("Ship/Camera2D").limit_left=get_node("upleft").position.x
		get_node("Ship/Camera2D").limit_top=get_node("upleft").position.y
		get_node("Ship/Camera2D").limit_right=get_node("downright").position.x
		get_node("Ship/Camera2D").limit_bottom=get_node("downright").position.y
	else:
		get_node("Hero").CORE = CORE
		get_node("Hero").GRAVITY = GRAVITY

func _entering_planet(planet):
	CORE._transition(planet)


func _on_Back_to_ship_body_entered(body):
	if body.has_method("_ship"):
		CORE._transition()


func _on_Boundaries_body_entered(body):
	get_node("Ship").OUT_OF_BOUNDS = true
	get_node("Ship")._oblivion()


func _on_Boundaries_body_exited(body):
	get_node("Ship").OUT_OF_BOUNDS = false
	get_node("Ship")._reset_death()
