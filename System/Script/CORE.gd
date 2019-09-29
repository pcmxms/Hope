extends Node2D

var menu = load("res://System/Credits.tscn")
var game = load("res://System/Main_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var PUT_MENU = menu.instance()
	get_node("Menu").add_child(PUT_MENU)

func _start_game():
	var PUT_GAME = game.instance()
	get_node("Menu").get_children()[0].queue_free()
	get_node("Game").add_child(PUT_GAME)
	
func _main_menu():
	var PUT_MENU = menu.instance()
	get_node("Game").get_children()[0].queue_free()
	PUT_MENU.STEP = 1
	get_node("Menu").add_child(PUT_MENU)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
