extends Node2D

var characterSelection : CharacterSelection = null:
	set(val):
		characterSelection = val
		characterSelection.connect("character_confirmed", play_confirm)
		characterSelection.connect("cycled", play_cycle)

const selectableScene = preload("res://nodes/selection/SelectableScene.tscn")

func _ready():
	if characterSelection:
		var i = 0
		for selectable in characterSelection.selectables:
			var selectableInstance = selectableScene.instantiate()
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

func play_confirm(character : CharacterRes):
	var anouncement = character.selectionSound
	if anouncement != null:
		$AankondigingPlayer.stream = anouncement
		$AankondigingPlayer.play(0.0)

func play_cycle():
	$CyclePlayer.play(0.0)
