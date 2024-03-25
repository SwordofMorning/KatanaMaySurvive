extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player_character = get_node("AnimationPlayer")
@onready var animation_player_weapon = []
@onready var weapons_array = []

var weapon_idx = 0

func _ready():
	var weapons = get_node("Weapon").get_children()
	
	weapons_array = weapons
	
	for i in weapons:
		animation_player_weapon.append(i.get_node("AnimationPlayer"))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	var direction = Input.get_axis("Key_A", "Key_D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
## Change Weapons
	if Input.is_action_just_pressed("Key_1"):
		weapon_idx = 0
		Weapon_Switch(0)
	elif Input.is_action_just_pressed("Key_2"):
		weapon_idx = 1
		Weapon_Switch(1)
	elif Input.is_action_just_pressed("Key_3"):
		weapon_idx = 2
		Weapon_Switch(2)
		
## Atk player
	if Input.is_action_just_pressed("Mouse_Left") and !animation_player_character.is_playing():
		animation_player_character.play("atk")
		animation_player_weapon[weapon_idx].play("atk")

	move_and_slide()

func Weapon_Switch(_weapon_idx):
	for i in weapons_array.size():
		if (i == _weapon_idx):
			weapons_array[i].visible = true
		else:
			weapons_array[i].visible = false
	
