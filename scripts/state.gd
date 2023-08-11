extends Node

class_name State

@export var can_move : bool = true
@export var is_rolling : bool = false

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

signal interrupt_state(new_state : State)

func state_process(_delta):
	pass

func state_input(_event  : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass

