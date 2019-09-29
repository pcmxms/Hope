extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ON_CREDITS = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	get_node("Animation").play("Begin")

func _process(delta):
	if Input.is_action_just_pressed("SHOT") && !ON_CREDITS:
		ON_CREDITS = true
		get_node("Menu").hide()
		get_node("ThingsIUsed").show()
		get_node("Animation").play("Credits")
	if Input.is_action_just_pressed("ui_cancel") && ON_CREDITS:
		get_node("Thanks").modulate = Color(1,1,1,0)
		get_node("Animation").stop()
		get_node("Menu").show()
		get_node("ThingsIUsed").hide()
		ON_CREDITS = false

func _on_Animation_animation_finished(anim_name):
	if anim_name == "Begin":
		get_node("Animation").play("Start")
	if anim_name == "Start":
		set_process(true)
	if anim_name == "Credits":
		get_node("ThingsIUsed").hide()
		get_node("Menu").show()
		
