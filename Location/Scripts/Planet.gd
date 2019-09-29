extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
export var planet_name = "Antaris"
export var reference = 0

func _ready():
	get_node("Name").set_text(planet_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Planet_body_entered(body):
	if body.has_method("_ship"):
		body.set_physics_process(false)
		body.move_and_collide(Vector2(0,0))
		body.hide()
		body._update_space_position(position+get_node("Position").position)
		get_parent()._entering_planet(reference)

func _on_ShowName_body_entered(body):
	get_node("AnimationPlayer").play("Show_name")


func _on_ShowName_body_exited(body):
	get_node("AnimationPlayer").play_backwards("Show_name")
