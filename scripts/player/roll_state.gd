extends PlayerState

class_name RollState

@export var ground_state : PlayerState
@export var roll_animation_name : String = "roll"

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == roll_animation_name:
		is_rolling = false
		next_state = ground_state
