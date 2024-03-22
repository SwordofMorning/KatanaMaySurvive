extends Node2D

@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0002

# the spring array
var springs = []
# how many times spread in one frame
var spread_times = 10

@export var distance_between_springs = 32
@export var spring_nums = 35
var water_length = distance_between_springs * spring_nums
@onready var water_spring = preload("res://water_spring.tscn")

# Water Depth
@export var water_depth = 200
var target_height = global_position.y
# to create polygon
var bottom = target_height + water_depth
@onready var water_polygon = $Water_Polygon

# Water Border
@onready var Water_Border = $Water_Border
@export var border_thickness = 0.5

func _ready():
	Water_Border.width = border_thickness
	for i in range(spring_nums):
		var x_pos = distance_between_springs * i
		var water_spring_node = water_spring.instantiate()
		add_child(water_spring_node)
		springs.append(water_spring_node)
		water_spring_node.Init(x_pos, i)
		water_spring_node.Set_Collision_Width(distance_between_springs)
		water_spring_node.connect("splash", Splash, 0)
	#Splash(18, 5)
	

func _physics_process(delta):
	for i in springs:
		i.Water_Update(k, d)
		
	var left_deltas = []
	var right_deltas = []
	
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
	
	for spread_times_idx in range(spread_times):
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size() - 1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	Draw_Border()
	Draw_Water_Body()

func Splash(index, speed):
	if (index >= 0 and index < springs.size()):
		springs[index].velocity += speed

func Draw_Water_Body():
	# Use Curve to implace Polygon
	var curve = Water_Border.curve
	var points = Array(curve.get_baked_points())
	
	var water_polygon_points = points
	
	var first_idx = 0
	var last_idx = water_polygon_points.size() - 1
	
	water_polygon_points.append(Vector2(water_polygon_points[last_idx].x, bottom))
	water_polygon_points.append(Vector2(water_polygon_points[first_idx].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points)
	water_polygon.set_polygon(water_polygon_points)
	
func Draw_Border():
	var curve = Curve2D.new().duplicate()
	
	var surface_points = []
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	for i in range(springs.size()):
		curve.add_point(surface_points[i])
		
	Water_Border.curve = curve
	Water_Border.smooth(true)
	Water_Border.queue_redraw()
