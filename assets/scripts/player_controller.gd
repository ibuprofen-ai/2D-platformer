extends CharacterBody2D
class_name PlayerController

@export var speed = 10
@export var jump = 10
var speed_multiplier = 30
var jump_multiplier = -30
var direction = 0
#const SPEED= 360.0
#const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	#jump
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump*jump_multiplier
	#jump down
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity*delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump*jump_multiplier

	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction*speed 
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
