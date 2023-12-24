extends Node2D

var characterSelection : CharacterSelection = null

const selectableScene = preload("res://nodes/SelectableScene.tscn")

func _ready():
	if characterSelection:
		var i = 0
		for selectable in characterSelection.selectables:
			var selectableInstance = selectableScene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			selectableInstance.selectable = selectable
			var parent = $SelectableRoot.get_child(i)
			if parent:
				parent.add_child(selectableInstance)
			else:
				add_child(selectableInstance)
			i += 1

func _input(event):
	if characterSelection != null:
		characterSelection.handle_input_event(event)

