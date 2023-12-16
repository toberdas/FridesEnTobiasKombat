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

func get_combos_by_starting_move(moveName):
	var _combos = []
	for combo : ComboRes in combos:
		if combo.moveNames[0] == moveName:
			_combos.append(combo)
	return _combos
