extends KinematicBody2D

var DIRECTION = Vector2(0,0)
var POWER = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	move_and_collide(3*DIRECTION)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hit_body_entered(body):
	if body.has_method("_die"):
		body._die()
		queue_free()
	else:
		queue_free()

func _on_Timer_timeout():
	queue_free()