extends RigidBody2D

var thrust = Vector2(0, -250)
var torque = 20000

var rotation_direction = 0
var impulse = Vector2(0, 0)

func _on_timer_timeout():
	queue_free()

func _ready():
	rotation_direction = randi_range(-1, 1)
	impulse = Vector2(randi_range(0, 20000), randi_range(-30000, -20000))

func _integrate_forces(state):
	state.apply_torque(rotation_direction * torque)
	rotation_direction = 0
	state.apply_central_force(impulse)
	impulse = Vector2(0, 0)
