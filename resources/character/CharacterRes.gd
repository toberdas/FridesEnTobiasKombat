extends Resource
class_name CharacterRes

@export var moves : Array[MoveRes]
@export var combos : Array[ComboRes]
@export var hitpoints : Array[HitpointRes]

func get_move_by_name(moveName):
	for move in moves:
		if move.moveName == moveName:
			return move
	return null

func get_combo_by_starting_move(moveName):
	for combo : ComboRes in combos:
		if combo.moveNames[0] == moveName:
			return combo
	return null

func check_combo_with_names(moveNames = []):
	for combo : ComboRes in combos:
		var resultingMove = combo.check_combo(moveNames)
		if resultingMove != null:
			return resultingMove
	return null
