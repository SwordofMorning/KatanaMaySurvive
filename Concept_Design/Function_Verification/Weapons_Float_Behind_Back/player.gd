extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var anime
var is_atk = false

func _ready():
	anime = get_node("AnimationPlayer")
	anime.connect("animation_finished", ATK_Finished, 0)
	
func ATK_Finished():
	is_atk = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Move_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("Atk"):
		anime.play("Atk")
		is_atk = true
	elif !anime.is_playing():
		anime.play("Idle")
	move_and_slide()
