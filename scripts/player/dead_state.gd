extends State

class_name DeadState

# @export var scene_after_death : PackedScene

@onready var timer : Timer = $Timer

func on_enter():
	timer.start()

func _on_timer_timeout():
	pass
	# TODO: reload current scene
	get_tree().reload_current_scene()
#	print_debug("Scene after death: ", scene_after_death)
#	if scene_after_death != null:
#		get_tree().change_scene_to_packed(scene_after_death)
#	else:
#		push_warning("There is nowhere to go after death")
