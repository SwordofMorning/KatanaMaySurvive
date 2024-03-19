extends Node2D

@onready var body_parts = [
	preload("res://Frog_Body_Rigid/frog_body_part_rigid_head.tscn"),
	preload("res://Frog_Body_Rigid/frog_body_part_rigid_body.tscn")
]

func get_direction():
	return Vector2 (randf_range(-1, 1), randf_range(-1, 1) )

func explode():
	var tween = get_tree().create_tween()
	for part in body_parts:
		var piece = part.instantiate()
		piece.position = get_parent().position
		
		get_parent().get_parent().add_child(piece) # i.e. To world.tscn
		#tween.tween_property(piece, "position", piece.position + get_direction()*100, 0.1)
	
func _on_auto_test_timer_timeout():
	explode()
