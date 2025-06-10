extends Node2D

@export var explosion_effect : PackedScene
@export var move_speed : float = 300

func _physics_process(delta):
	global_position.y += delta * move_speed

func _on_area_2d_area_entered(area:Area2D):
	if area.is_in_group("Bullet"):
		area.queue_free()
		spawn_explosion_effect()
		GameManager.increase_score(1)
		queue_free()


func spawn_explosion_effect()->void:
	var effect = explosion_effect.instantiate()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
