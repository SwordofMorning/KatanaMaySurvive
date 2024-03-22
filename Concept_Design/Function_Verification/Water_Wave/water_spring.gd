extends Node2D

# spring's current velocity
var velocity = 0
# force to spring
var force = 0
# spring's current height
var height = 0
# spring's natural pisition, height+80 means: move down 80
var target_height = 0

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

func Init(x_pos):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_pos
