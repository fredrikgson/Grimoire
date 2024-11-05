extends Area2D
class_name RunePoint

@export var id:int
@onready var sprite:Sprite2D = $Sprite2D

var highlight_tween:Tween
const default_scale = Vector2(1, 1)
const highlight_scale = Vector2(1.1, 1.1)

signal mouse_over(rune_point:RunePoint)
signal mouse_exit(rune_point:RunePoint)
signal left_mouse_button_clicked(rune_point:RunePoint)

func _mouse_enter():
	mouse_over.emit(self)
	highlight()

func _mouse_exit():
	unhighlight()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_mouse_button_clicked.emit(self)

func highlight():
	if highlight_tween:
		highlight_tween.kill()
	highlight_tween = get_tree().create_tween()
	highlight_tween.tween_property(sprite, "scale", highlight_scale, 0.05)
func unhighlight():
	if highlight_tween:
		highlight_tween.kill()
	highlight_tween = get_tree().create_tween()
	highlight_tween.tween_property(sprite, "scale", default_scale, 0.05)
