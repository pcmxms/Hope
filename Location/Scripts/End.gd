extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var END = "good"
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Hero").set_physics_process(false)
	if END == "good":
		get_node("Ending").play("GoodEnding")
	else:
		get_node("Ending").play("Bad_ending")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_End_timeout():
	get_parent().get_parent()._game_over()


func _on_Ending_animation_finished(anim_name):
	get_node("End").start()
