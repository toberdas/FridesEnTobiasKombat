extends Resource
class_name ActorData

var ownerID : int = 0
var location : Vector2 = Vector2.ZERO
var direction : int = 1
var targetDirection : int = 1
var hitpointData : HitpointData = HitpointData.new()
var currentMove : MoveData = null
var idleMove : MoveRes = preload("res://assets/moves/defaults/DefaultIdle.tres")
var hurtMove : MoveRes = preload("res://assets/moves/defaults/DefaultHurt.tres")
var moveBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.8)
var recoveryFrames : int = 0

func is_free_to_move():
	if currentMove == null:
		return true
	else:
		var currentMoveFrame = currentMove.get_current_move_frame()
		if currentMoveFrame:
			if currentMoveFrame.can_be_cancelled():
				return true
	return false

func add_move_to_bus(moveRes : MoveRes):
	moveBus.add_item(moveRes)

func do_move(move : MoveRes):
	currentMove = MoveData.new(move)

func do_next_move():
	var nextMove : MoveRes = get_next_move_in_bus()
	if nextMove:
		do_move(nextMove)
		return
	do_move(idleMove)

func tick_time(delta):
	if is_free_to_move():
		do_next_move()
	if recoveryFrames > 0:
		recoveryFrames -= 1
		return
	if currentMove != null:
		var tickResult : TickResult = currentMove.tick_time(delta)
		match tickResult.result:
			TickResult.RESULT.FRAMEINCREASE:
				pass
			TickResult.RESULT.TIMERINCREASE:
				pass
			TickResult.RESULT.MOVEENDED:
				direction = targetDirection
				var nextMove = get_next_move_in_bus()
				if nextMove:
					do_move(nextMove)
				else:
					do_move(idleMove)

func parse_current_frame():
	if currentMove:
		return currentMove.parse_current_frame()
	return null

func get_current_move():
	return currentMove

func get_current_move_name():
	if currentMove:
		return currentMove.get_move_name()
	return null

func get_current_move_frame():
	if currentMove:
		return currentMove.get_current_move_frame()
	return null

func get_current_move_frames():
	if currentMove:
		return currentMove.get_move_frames()
	return []

func get_current_move_frame_index():
	if currentMove:
		return currentMove.currentFrame
	return 0

func get_next_move_in_bus():
	return moveBus.pop_at(0)

func take_damage(damage:int):
	hitpointData.take_damage(damage)
	do_move(hurtMove)

func take_recovery_frames(frames:int):
	recoveryFrames = frames

func translate_moveinputname_to_movename(moveInputName): ##Ik schrijf dit nu uit, maar zou mooi zijn om het ook in regels te kunnen vatten.
	var rv = moveInputName
	if moveInputName == MOVES.moveInputs.WALKLEFT or moveInputName == MOVES.moveInputs.WALKRIGHT: 
		rv = handle_movement_input(moveInputName)
	return rv

func handle_movement_input(moveInputName):
	if moveInputName == MOVES.moveInputs.WALKLEFT:
		if direction == 1:
			return MOVES.moves.WALKBACKWARD
	if moveInputName == MOVES.moveInputs.WALKLEFT:
		if direction == -1:
			return MOVES.moves.WALKFORWARD
	if moveInputName == MOVES.moveInputs.WALKRIGHT:
		if direction == 1:
			return MOVES.moves.WALKFORWARD
	if moveInputName == MOVES.moveInputs.WALKRIGHT:
		if direction == -1:
			return MOVES.moves.WALKBACKWARD
