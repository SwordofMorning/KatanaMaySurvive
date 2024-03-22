extends Node2D

var stone = preload("res://stone.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var s = stone.instantiate()
		s.position = get_global_mouse_position()
		add_child(s)
