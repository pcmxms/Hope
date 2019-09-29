extends Sprite

func _ready():
	get_node("AnimationPlayer").play("BUM",0,4)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()