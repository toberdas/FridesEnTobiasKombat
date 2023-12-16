extends Resource
class_name ComboRes

@export var moveNames : Array[MOVES.moves]
@export var resultingMove : MoveRes

func get_resulting_move():
	return resultingMove

func get_rest_of_combo():
	return moveNames.slice(1,moveNames.size())

func get_all_move_names():
	return moveNames

func get_move_at_index(index):
	return moveNames[index]

func get_amount_of_moves():
	return moveNames.size()
