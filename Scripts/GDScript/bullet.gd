extends Area2D

@export var move_speed : float = 1000
var dir : Vector2 = Vector2.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position += delta * move_speed * dir


func set_bullet_dir(direction : Vector2)->void:
	dir = direction
	rotation = dir.angle() + 80
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
