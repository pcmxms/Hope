extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var ITEM_TYPE = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if ITEM_TYPE == 1:
		get_node("Sprite").frame = 24
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body):
	body._pick_up_item(ITEM_TYPE)
	queue_free()
