extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var GRAVITY = 0.1
var JUMP = false
var vx = 0
var vy = 0
var SHOT = load("res://Ship/Shot_hero.tscn")
var INVENTORY = [0,0,0,0] #Agua, Fuel
var CORE

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("ui_left") && !test_move(transform,Vector2(-2,0)):
		vx = -1
		get_node("Figura").scale.x = -1
	elif Input.is_action_pressed("ui_right")&& !test_move(transform,Vector2(2,0)):
		vx = 1
		get_node("Figura").scale.x = 1
	else:
		vx = 0
	if !JUMP && Input.is_action_just_pressed("ui_accept"):
		vy = -2
		JUMP = true
	if Input.is_action_just_pressed("SHOT"):
		_shot()
	if test_move(transform,Vector2(0,-2)) && vy<0:
		vy = -0.8*vy
	if !test_move(transform,Vector2(0,1)):
		_gravity()
	else:
		if !JUMP:
			position.y = floor(position.y)
			vy = 0
		else:
			if vy >0:
				JUMP = false
				position.y = floor(position.y)
				vy = 0
	#get_node("HUD/Label").set_text(var2str(position.x)+", "+var2str(position.y))
	move_and_collide(Vector2(vx,vy))
	
func _gravity():
	vy = vy+GRAVITY
func _pick_up_item(TYPE):
	if TYPE == 0:
		CORE.SHIP_FUEL = 100
		get_node("HUD/Warnings").play("ON")
		get_node("HUD/Label").set_text("You've got some fuel")
	if TYPE == 1:
		CORE.GOT_WATER = true
		get_node("HUD/Warnings").play("ON")
		get_node("HUD/Label").set_text("You've got some water. Go back home! HURRY!")
func _shot():
	var BAM = SHOT.instance()
	BAM.position = position+Vector2(0,-3)
	BAM.DIRECTION = Vector2(get_node("Figura").scale.x,0)
	get_parent().add_child(BAM)
func _ship():
	pass