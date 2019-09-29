extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var VELOCITY = Vector2(0,0)
var ACELERATION = Vector2(0,0)
var CORE
var FUEL = 100
var SHIELD = 100
var NO_FUEL = false
var OUT_OF_BOUNDS = false

var SHOT = load("res://Ship/shot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true) # Replace with function body.

func _physics_process(delta):
	get_node("HUD/Shield/shield").set_text(var2str(int(SHIELD))+"%")
	if Input.is_action_pressed("ui_right"):
		rotation = rotation+0.05
	elif Input.is_action_pressed("ui_left"):
		rotation = rotation-0.05
	if Input.is_action_pressed("ui_up"):
		if FUEL>0:
			ACELERATION = 0.05*Vector2(cos(rotation),sin(rotation))
			FUEL = FUEL - 0.2
			if get_node("Fogo").one_shot:
				get_node("Fogob").one_shot = true
				get_node("Fogo").one_shot = false
				get_node("Fogo").set_emitting(true)
		else:
			get_node("Fogo").one_shot = true
			get_node("Fogob").one_shot = true			
	elif Input.is_action_pressed("ui_down"):
		if FUEL>0:
			ACELERATION = -0.05*Vector2(cos(rotation),sin(rotation))
			FUEL = FUEL - 0.2
			if get_node("Fogob").one_shot:
				get_node("Fogo").one_shot = true
				get_node("Fogob").one_shot = false
				get_node("Fogob").set_emitting(true)
		else:
			get_node("Fogo").one_shot = true
			get_node("Fogob").one_shot = true
	else:
		get_node("Fogo").one_shot = true
		get_node("Fogob").one_shot = true
		ACELERATION = Vector2(0,0)
		
	if FUEL <0 && !NO_FUEL && !OUT_OF_BOUNDS:
		NO_FUEL = true
		get_node("DEATH_TIMER").start()
		get_node("HUD/WARNING").show()
		get_node("HUD/Warning").play("ON")
		
	if NO_FUEL || OUT_OF_BOUNDS:
		get_node("HUD/WARNING").set_text("Time left for oblivion: "+var2str(int(get_node("DEATH_TIMER").time_left))+" seconds")
	if Input.is_action_just_pressed("ui_accept"):
		_shot()
	if FUEL <21:
		get_node("HUD/Fuel/fuel").modulate = Color(0.87,0.14,0.14)
	else:
		get_node("HUD/Fuel/fuel").modulate = Color(1,1,1)
	get_node("HUD/Fuel/fuel").set_text(var2str(int(FUEL))+"%")
	_move()
	
func _move():
	if ACELERATION != Vector2(0,0):
		VELOCITY = VELOCITY + ACELERATION
		if VELOCITY.length()>3:
			VELOCITY = VELOCITY*3/(VELOCITY.length())
	move_and_collide(VELOCITY)

func _shot():
	var BANG = SHOT.instance()
	BANG.rotation = rotation
	BANG.DIRECTION = Vector2(cos(rotation),sin(rotation))
	BANG.position = position
	get_parent().add_child(BANG)
	
func _ship():
	pass
	
func _update_space_position(position):
	CORE.SHIP_POSITION = position
	CORE.SHIP_FUEL = FUEL
	CORE.SHIP_SHIELD = SHIELD

func _on_DEATH_TIMER_timeout():
	set_physics_process(false)
	get_node("HUD/Warning").stop()
	get_node("HUD/WARNING").set_text("You got lost in space forever. \n \nEveryone you love is dead. \n \nGAME OVER")
	get_node("finish").start()
func _reset_death():
	OUT_OF_BOUNDS = false
	get_node("DEATH_TIMER").stop()
	get_node("HUD/WARNING").set_text("")
	get_node("HUD/Warning").stop()
func _oblivion():
	if !NO_FUEL:
		get_node("DEATH_TIMER").start()
		get_node("HUD/WARNING").show()
		get_node("HUD/Warning").play("ON")
func _die():
	SHIELD = SHIELD-10
	if SHIELD < 21:
		get_node("HUD/Shield/shield").modulate = Color(0.87,0.14,0.14)
	get_node("HUD/Shield/shield").set_text(var2str(int(SHIELD))+"%")
	if SHIELD <0:
		set_physics_process(false)
		get_node("Figura").hide()
		get_node("HUD/WARNING").show()
		get_node("HUD/WARNING").set_text("Your ship exploded. \n \nEveryone you love is dead. \n \nGAME OVER")
		get_node("finish").start()
		


func _on_finish_timeout():
	CORE._game_over()
