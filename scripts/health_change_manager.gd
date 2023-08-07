extends Control

@export var health_change_label : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_signal_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_change_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
