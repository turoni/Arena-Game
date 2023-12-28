class_name MoveInputComponent
extends Node

@export var input_vector : Vector2
@export var dash : bool
@export var shoot : bool

func _input(event: InputEvent) -> void:
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	dash = Input.is_action_just_pressed("ui_dash")
	shoot = Input.is_action_just_pressed("ui_shoot")
