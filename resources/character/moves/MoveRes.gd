extends Resource
class_name MoveRes

@export var spriteSheet : Texture2D
@export var moveName : MOVES.moves
@export_category("Move frames")
@export var moveFrames : Array[MoveFrameRes] = []

func get_moveframe_res(index):
	if index < moveFrames.size():
		return moveFrames[index]
	return null

func get_all_moveframes():
	return moveFrames

func get_moveframes_amount():
	return moveFrames.size()
