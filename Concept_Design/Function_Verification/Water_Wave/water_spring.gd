extends Node2D

# spring's current velocity
var velocity = 0
# force to spring
var force = 0
# spring's current height
var height = 0
# spring's natural pisition, height+80 means: move down 80
var target_height = 0

@onready var collision = get_node("Area2D/CollisionShape2D")

var idx_in_water_body = 0
# to cal spring size
var velo_factor = 0.02
signal splash

var is_collided = false

func Water_Update(spring_constant, dampening):
	# update height
	height = position.y
	# spring extension
	var x = height - target_height
	
	# hook's law
	force = -spring_constant * x
	# dampening, and loss
	force -= (dampening * velocity)
	
	# apply force to velocity
	velocity += force
	
	# make it move
	position.y += velocity
	pass

func Init(x_pos, idx):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_pos
	idx_in_water_body = idx

func Set_Collision_Width(value):
	var size = collision.shape.size
	var new_size = Vector2(value/2, size.y)
	size = new_size


func _on_area_2d_body_entered(body):
	if not is_collided:
		var speed = body.velocity.y * velo_factor
		emit_signal("splash", idx_in_water_body, speed)
		is_collided = true
		get_node("Timer").start()

func _on_timer_timeout():
	is_collided = false
