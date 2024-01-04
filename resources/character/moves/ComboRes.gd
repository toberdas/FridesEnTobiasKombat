extends Resource
class_name ComboRes

@export var moveNames : Array[MOVES.moves]
@export var resultingMove : MoveRes

func get_resulting_move():
	return resultingMove

func get_rest_of_combo_names():
	return moveNames.slice(1,moveNames.size())

func get_all_move_names():
	return moveNames

func get_move_at_index(index):
	return moveNames[index]

func get_amount_of_moves():
	return moveNames.size()

func check_combo(busMoveNames : Array):
	var i = 0
	for busMoveName in busMoveNames:
		if i < moveNames.size():
			if busMoveName != moveNames[i]:
				return null
		i += 1
		if i == moveNames.size():
			return get_resulting_move()

