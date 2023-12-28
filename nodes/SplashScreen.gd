extends Node2D

signal go_further

func _ready():
	$StervelijkGevechtSpeler.play(0.0)
	$Sprite2D.play("default")

func _unhandled_input(event):
	if event is InputEventKey:
		emit_signal("go_further")
		queue_free()
	if event is InputEventJoypadButton:
		emit_signal("go_further")
		queue_free()
