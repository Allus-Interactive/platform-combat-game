extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : PlayerState

var states : Array[PlayerState]

func _ready():
	for child in get_children():
		if child is PlayerState:
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func check_if_can_move():
	return current_state.can_move

