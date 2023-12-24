extends Resource
class_name MoveRes

@export var spriteSheet : Texture2D
@export_category("Move frames")
@export var moveFrames : Array[MoveFrameRes] = []
@export_category("Move properties")
@export var moveName : MOVES.moves
@export var canBeHeld : bool = false
@export var cacheTime : float = 0.8
@export var spriteFrameAmount : int = 0
@export var canBeSkippedInBus : bool = false

func get_moveframe_res(index):
	if index < moveFrames.size():
		return moveFrames[index]
	return null

func get_all_moveframes():
	return moveFrames

func get_moveframes_amount():
	return moveFrames.size()
