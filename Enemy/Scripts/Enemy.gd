extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ENERGY = 3
var EXPLODE = load("res://Ship/Explosion.tscn")
var SPEED = 1
var time = 0
var freq = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	freq = randf()
	get_node("Figura").frame = randi()%8+2
	set_physics_process(true)
	
func _physics_process(delta):
	time = time + delta
	move_and_collide(Vector2(cos(freq*time),sin(freq*time)*SPEED))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _die():
	ENERGY = ENERGY - 1
	if ENERGY <= 0 :
		var BUM = EXPLODE.instance()
		BUM.position = position
		get_parent().add_child(BUM)
		queue_free()

func _on_Hurt_body_entered(body):
	if body.has_method("_ship"):
		body._die()
		_die()
		var BUM = EXPLODE.instance()
		BUM.position = position
		get_parent().add_child(BUM)
		