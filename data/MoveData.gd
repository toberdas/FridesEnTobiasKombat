extends Resource
class_name MoveData

var moveRes : MoveRes
var currentFrame : int = 0
var frameParsed : bool = false
var timer : float = 0.0

func _init(_moveRes:MoveRes):
	moveRes = _moveRes

func tick_time(delta):
	timer += delta
	return check_increment()

func check_increment():
	if timer >= get_current_move_frame().frameDuration:
		currentFrame += 1
		timer = 0.0
		frameParsed = false
		if currentFrame >= moveRes.get_moveframes_amount():
			return TickResult.new(TickResult.RESULT.MOVEENDED)
		var currentFrameRes : MoveFrameRes = moveRes.get_moveframe_res(currentFrame)
		if currentFrameRes != null:
			return TickResult.new(TickResult.RESULT.FRAMEINCREASE)
	return TickResult.new(TickResult.RESULT.TIMERINCREASE)
		
func parse_current_frame():
	if frameParsed == false:
		frameParsed = true
		return get_current_move_frame()
	return null

func get_move_name():
	return moveRes.moveName

func get_move_frames():
	return moveRes.get_all_moveframes()

func get_current_move_frame():
	if moveRes:
		return moveRes.get_moveframe_res(currentFrame)
	return null
