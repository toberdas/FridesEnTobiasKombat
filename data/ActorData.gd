extends Resource
class_name ActorData

var location : Vector2 = Vector2.ZERO
var direction : int = 1
var targetDirection : int = 1
var currentMoveData : MoveData = null
var nextMove : MoveRes = null
var recoveryTime : float = 0
var cacheTimer : float = 0
var moveBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.8)

var ownerID : int = 0
var characterRes : CharacterRes = null
var hitpointData : HitpointData = null
var idleMove : MoveRes = preload("res://assets/character/Frides/moves/DefaultIdle.tres")
var hurtMove : MoveRes = preload("res://assets/character/Frides/moves/DefaultHurt.tres")

func is_free_to_move():
	if get_next_move() == null:
		return true
	else:
		return false

func idle():
	print("idle")
	set_current_move(idleMove)

func do_next_move():
	var canLoop = can_loop()
	var canBeCancelled = can_be_cancelled()
	if get_next_move() == null:
		return false
	if get_next_move().moveName == currentMoveData.moveRes.moveName && canLoop:
		print('a')
		set_current_move(get_next_move())
		moveBus.erase_all()
		print('bus cleares')
		return true
	if get_next_move().moveName != currentMoveData.moveRes.moveName && canBeCancelled:
		print('b')
		set_current_move(get_next_move())
		moveBus.erase_all()
		print('bus cleares')
		return true
	return false

func cancel_process():
	if get_next_move() == null:
		return
	if get_next_move() != currentMoveData.moveRes && can_be_cancelled():
		print('c')
		set_current_move(get_next_move())
		moveBus.erase_all()
		print('bus cleares')

func do_move(move : MoveRes):
	set_current_move(move)

func tick_time(delta):
	moveBus.decay_timer(delta)
	if recoveryTime > 0.0:
		recoveryTime -= delta
		return
	if currentMoveData != null:
		var tickResult : TickResult = currentMoveData.tick_time(delta)
		if tickResult == null:
			print("tick failed")
			return
		match tickResult.result:
			TickResult.RESULT.FRAMEINCREASE:
				pass
			TickResult.RESULT.TIMERINCREASE:
				#do_next_move()
				cancel_process()
			TickResult.RESULT.MOVEENDED:
				print('move ended')
				direction = targetDirection
				if !do_next_move():
					idle()
	if currentMoveData == null:
		set_current_move(get_next_move())

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

func set_current_move(moveRes : MoveRes):
	var moveData = MoveData.new(moveRes)
	if moveData:
		currentMoveData = moveData

func set_next_move_res(moveRes : MoveRes):
	if moveRes:
		nextMove = moveRes
		cacheTimer = moveRes.cacheTime

func get_next_move():
	var rv = null
	if characterRes == null:
		return rv
	for moveName in moveBus.get_all():
		var moveRes : MoveRes = characterRes.get_move_by_name(moveName)
		if moveRes != null:
			if !moveRes.canBeSkippedInBus:
				return moveRes
	var moveName = moveBus.get_first()
	var move = characterRes.get_move_by_name(moveName)
	if move == null:
		return null	
	return characterRes.get_move_by_name(moveName)

func set_character_res(newRes : CharacterRes):
	characterRes = newRes
	hurtMove = characterRes.get_move_by_name(MOVES.moves.HURT)
	idleMove = characterRes.get_move_by_name(MOVES.moves.IDLE)
	set_current_move(characterRes.get_move_by_name(MOVES.moves.ENTRANCE))
	hitpointData = HitpointData.new(characterRes.hitpoints)

func add_moveinputname_to_bus(moveInputName):
	var translatedName = translate_moveinputname_to_movename(moveInputName)
	if translatedName != null:
		moveBus.add_item(translatedName)
	var moveBusCopy : Array = moveBus.get_all().duplicate()
	moveBusCopy.insert(0, currentMoveData.moveRes.moveName)
	var resultingMove : MoveRes = characterRes.check_combo_with_names(moveBusCopy)
	if resultingMove:
		moveBus.erase_all()
		do_move(resultingMove)

func take_damage(damage:int):
	if hitpointData != null:
		hitpointData.take_damage(damage)
	do_move(hurtMove)

func take_recovery_time(time:float):
	recoveryTime = time

func translate_moveinputname_to_movename(moveInputName): ##Ik schrijf dit nu uit, maar zou mooi zijn om het ook in regels te kunnen vatten.
	var rv = moveInputName
	if moveInputName == MOVES.moveInputs.WALKLEFT or moveInputName == MOVES.moveInputs.WALKRIGHT: 
		rv = handle_movement_input(moveInputName)
	if moveInputName == MOVES.moveInputs.TEST:
		rv = MOVES.moves.TEST
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


