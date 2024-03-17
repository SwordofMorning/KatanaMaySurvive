extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = 0
	
	if Input.is_action_pressed("Move_Left"):
		direction = -1
	elif Input.is_action_pressed("Move_Right"):
		direction = 1
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()



func _on_area_2d_body_entered(body):
	if (body.name == "Player"):
		print("player in")
		Global.Penetration_Times += 1


func _on_area_2d_body_exited(body):
	if (body.name == "Player"):
		print("player out")
