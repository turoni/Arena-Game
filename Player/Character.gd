extends CharacterBody2D

@onready var shooting_point: Marker2D = $shooting_point

const SPEED = 450.0
const DASH_SPEED = 1000.0
const ACCELERATION = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var move_input : MoveInputComponent
var timeoutDash : Timer

func _physics_process(delta: float) -> void:
	update_movement()
	execute_actions()	
	
func update_movement():
	if move_input.input_vector != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, move_input.input_vector.x * SPEED, ACCELERATION)
		velocity.y = move_toward(velocity.y, move_input.input_vector.y * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	
	if move_input.dash && velocity.length() <= SPEED:
		velocity = move_input.input_vector * DASH_SPEED
		move_input.dash = false
	move_and_slide()

const bullet_scene = preload("res://Bullets/Bullet.tscn")
func execute_actions():
	if move_input.shoot:
		move_input.shoot = false	
		var cursosPosition = get_global_mouse_position()
		var new_bullet = bullet_scene.instantiate()
		new_bullet.global_position = shooting_point.global_position
		new_bullet.look_at(cursosPosition)
		print(new_bullet.rotation)
		get_tree().current_scene.add_child(new_bullet)
