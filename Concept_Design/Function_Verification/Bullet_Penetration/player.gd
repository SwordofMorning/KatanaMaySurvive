extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var Velo_x = 0
var Velo_y = 0

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	var direction = 0
	if Input.is_action_pressed("Move_Left"):
		direction = -1
	elif Input.is_action_pressed("Move_Right"):
		direction = 1
	if Input.is_action_just_pressed("Mouse_LeftClick"):
		var mouse_position = get_viewport().get_mouse_position()
		var aim_direction = mouse_position - position
		print("Mouse Position: " + str(mouse_position))
		print("Player Position: " + str(position))
		print("Aim Victor: " + str(aim_direction))
		var aim_norm = aim_direction.normalized()
		velocity.x = aim_norm.x * SPEED
		velocity.y = aim_norm.y * SPEED
		Velo_x = velocity.x
		Velo_y = velocity.y
	
	# Reflection
	if is_on_floor() or is_on_ceiling():
		velocity.y = -Velo_y
		Velo_y = velocity.y
		Global.Reflection_Times += 1
	if is_on_wall():
		velocity.x = -Velo_x
		Velo_x = velocity.x
		Global.Reflection_Times += 1
	
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
