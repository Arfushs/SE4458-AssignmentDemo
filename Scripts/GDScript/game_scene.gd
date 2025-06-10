extends Node2D

@onready var crosshair : Sprite2D = get_node("CrossHair")
@export var label : Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_crosshair_position()
	label.text = str(GameManager.score)


func set_crosshair_position() -> void:
	crosshair.global_position = get_global_mouse_position()
