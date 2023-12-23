extends Resource
class_name ActorData

var location : Vector2 = Vector2.ZERO
var direction : int = 1
var targetDirection : int = 1
var currentMoveData : MoveData = null
var nextMove : MoveRes = null
var recoveryFrames : int = 0
var cacheTimer : float = 0
var moveBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.6)

var ownerID : int = 0
var characterRes : CharacterRes = null
var hitpointData : HitpointData = null
var idleMove : MoveRes = preload("res://assets/moves/defaults/DefaultIdle.tres")
var hurtMove : MoveRes = preload("res://assets/moves/defaults/DefaultHurt.tres")

func is_free_to_move():
	if nextMove == null:
		return true
	else:
		if nextMove == idleMove:
			return true
		if nextMove.canBeHeld:
			return true
	return false

func idle():
	print("idle")
	set_current_move(MoveData.new(idleMove))
	set_next_move_res(idleMove)

func do_next_move():
	var canLoop = can_loop()
	var canBeCancelled = can_be_cancelled()
	if nextMove == null:
		return false
	if nextMove.moveName == currentMoveData.moveRes.moveName && canLoop:
		print('a')
		set_current_move(MoveData.new(nextMove))
		return true
	if nextMove.moveName != currentMoveData.moveRes.moveName && canBeCancelled:
		print('b')
		set_current_move(MoveData.new(nextMove))
		return true
	return false

func cancel_process():
	if nextMove == null:
		return
	if nextMove != currentMoveData.moveRes && can_be_cancelled():
		print('c')
		set_current_move(MoveData.new(nextMove))

func do_move(move : MoveRes):
	set_current_move(MoveData.new(move))

func wipe_next_move():
	if nextMove != null:
		nextMove = null
		print('Wiped next move')

func tick_time(delta):
	moveBus.decay_timer(delta)
	if recoveryFrames > 0:
		recoveryFrames -= 1
		return
	if currentMoveData != null:
		var tickResult : TickResult = currentMoveData.tick_time(delta)
		match tickResult.result:
			TickResult.RESULT.FRAMEINCREASE:
				print('frame increase')
				cancel_process()
			TickResult.RESULT.TIMERINCREASE:
				pass
			TickResult.RESULT.MOVEENDED:
				print('move ended')
				direction = targetDirection
				if !do_next_move():
					idle()
	if currentMoveData == null:
		set_current_move(MoveData.new(nextMove))
	cacheTimer -= delta
	if cacheTimer <= 0.0:
		wipe_next_move()
	

func parse_current_frame():
	if currentMoveData:
		return currentMoveData.parse_current_frame()
	return null

func get_current_move():
	return currentMoveData

func get_current_move_name():
	if currentMoveData:
		return currentMoveData.get_move_name()
	return null

func get_current_move_frame():
	if currentMoveData:
		return currentMoveData.get_current_move_frame()
	return null

func get_current_move_frames():
	if currentMoveData:
		return currentMoveData.get_move_frames()
	return []

func get_current_sprite_index():
	if currentMoveData:
		return currentMoveData.currentSpriteFrame
	return 0

func get_current_move_frame_index():
	if currentMoveData:
		return currentMoveData.currentFrame
	return 0

func can_loop():
	if currentMoveData.get_current_move_frame().can_loop():
		return true
	return false

func can_be_cancelled():
	if currentMoveData.get_current_move_frame().can_be_cancelled():
		return true
	return false

func set_current_move(moveData : MoveData):
	if moveData:
		currentMoveData = moveData

func set_next_move_res(moveRes : MoveRes):
	if moveRes:
		nextMove = moveRes
		cacheTimer = moveRes.cacheTime

func set_character_res(newRes : CharacterRes):
	characterRes = newRes
	hurtMove = characterRes.get_move_by_name(MOVES.moves.HURT)
	idleMove = characterRes.get_move_by_name(MOVES.moves.IDLE)
	set_current_move(MoveData.new(idleMove))
	hitpointData = HitpointData.new(characterRes.hitpoints)

func add_moveinputname_to_bus(moveInputName):
	var translatedName = translate_moveinputname_to_movename(moveInputName)
	moveBus.add_item(translatedName)
	var moveBusCopy : Array = moveBus.get_all().duplicate()
	moveBusCopy.insert(0, currentMoveData.moveRes.moveName)
	var resultingMove : MoveRes = characterRes.check_combo_with_names(moveBusCopy)
	if resultingMove:
		do_move(resultingMove)

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


