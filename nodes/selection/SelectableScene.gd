extends Node2D

@export var characterRes : CharacterRes
var selectable : Selectable:
	set(val):
		selectable = val
		if selectable != null:
			selectable.connect("confirmed", play_confirm)

func _ready():
	if selectable != null:
		$Sprite2D.texture = selectable.selectValue.icon

func _process(_delta):
	for highlighter : PlayerData in selectable.selectDict.keys():
		var label = $Sprite2D.get_child(highlighter.playerID)
		label.set_text(selectable.get_string(highlighter))
		label.modulate = selectable.get_color(highlighter)
		
	for highlighter : PlayerData in selectable.selectDict.keys():
		if selectable.is_highlighted_by(highlighter):
			$Sprite2D.material.set_shader_parameter("color", highlighter.color)
			return
	$Sprite2D.material.set_shader_parameter("color", Color.WHITE)
	
func play_confirm():
	if selectable.selectValue.selectionSound:
		$AudioStreamPlayer2D.stream = characterRes.selectionSound
		$AudioStreamPlayer2D.play(0.0)
