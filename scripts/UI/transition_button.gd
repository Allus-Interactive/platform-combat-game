extends Button

@export var transitioner : Transitioner

func _on_pressed():
	transitioner.set_next_animation(true)
