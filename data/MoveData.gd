extends Resource
class_name MoveData

var moveRes : MoveRes
var currentFrame : int = 0
var currentSpriteFrame : int = 0
var frameParsed : bool = false
var timer : float = 0.0

func _init(_moveRes:MoveRes):
	moveRes = _moveRes

func tick_time(delta):
	timer += delta
	return check_increment()

func check_increment():
	var currentMoveFrame = get_current_move_frame()
	if currentMoveFrame == null:
		print("No move frame found")
		return null
	if timer >= get_current_move_frame().frameDuration:
		if currentFrame >= moveRes.get_moveframes_amount() -1:
			currentFrame = moveRes.get_moveframes_amount() -1
			return TickResult.new(TickResult.RESULT.MOVEENDED)
		timer = 0.0
		frameParsed = false
		currentFrame += 1
		var currentFrameRes : MoveFrameRes = moveRes.get_moveframe_res(currentFrame)
		if currentFrameRes != null:
			if currentFrameRes.increasesSpriteFrameCounter:
				currentSpriteFrame += 1
			var tickResult = TickResult.new(TickResult.RESULT.FRAMEINCREASE)
			return tickResult
	return TickResult.new(TickResult.RESULT.TIMERINCREASE)

func parse_current_frame():
	if frameParsed == false:
		frameParsed = true
		return get_current_move_frame()
	return null

func is_on_last_frame():
	if currentFrame >= moveRes.get_moveframes_amount() -1:
		return true
	return false

func get_move_name():
	return moveRes.moveName

func get_move_frames():
	return moveRes.get_all_moveframes()

func get_current_move_frame():
	if moveRes:
		return moveRes.get_moveframe_res(currentFrame)
	return null

func get_sprite_frame_count():
	if moveRes:
		return moveRes.spriteFrameAmount
	return 0

func get_cache_time():
	if moveRes:
		return moveRes.cacheTime
	return 0.8
