extends Node2D

@export var spawn_object : PackedScene
@export var spawn_y : float = 100.0
@export var spawn_x_min : float = -200.0
@export var spawn_x_max : float = 200.0
@export var spawn_interval : float = 1.5

var timer := 0.0

func _process(delta):
	timer += delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn_object_at_random_position()

func spawn_object_at_random_position():
	if spawn_object == null:
		return

	var instance = spawn_object.instantiate()
	var random_x = randf_range(spawn_x_min, spawn_x_max)
	var spawn_position = Vector2(random_x, spawn_y)
	
	instance.global_position = spawn_position
	get_tree().current_scene.add_child(instance)
