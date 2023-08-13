extends Control

@export var health_change_label : PackedScene
@export var damage_colour : Color = Color.DARK_RED
@export var heal_colour : Color = Color.DARK_GREEN

func _ready():
	SignalBus.connect("on_health_changed", on_enemy_health_changed)
	SignalBus.connect("on_player_health_changed", on_player_health_changed)

func on_enemy_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_change_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	
	if amount_changed >= 0:
		label_instance.modulate = heal_colour
	else:
		label_instance.modulate = damage_colour

func on_player_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_change_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	
	# TODO: add in logic to update health bar
	
	if amount_changed >= 0:
		label_instance.modulate = heal_colour
	else:
		label_instance.modulate = damage_colour
