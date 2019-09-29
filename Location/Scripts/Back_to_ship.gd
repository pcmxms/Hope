extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Back_to_ship_body_entered(body):
	if body.has_method("_ship"):
		body.set_physics_process(false)
		body.move_and_collide(Vector2(0,0))
		body.hide()
		get_parent()._entering_planet(-1)