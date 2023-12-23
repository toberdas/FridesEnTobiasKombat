extends Resource
class_name PlayerData

var playerID : int = 0
var characterRes : CharacterRes = preload("res://assets/character/default/DefaultCharacter.tres")
var characterData : ActorData = null
var inputData : InputData = InputData.new()
var moveBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.6)

func _init(_characterRes:CharacterRes):
	characterRes = _characterRes
	characterData = ActorData.new()
	characterData.ownerID = playerID
	characterData.set_character_res(characterRes)

func process(delta):
	moveBus.decay_timer(delta)
	if inputData:
		if characterData.is_free_to_move():
			var rule : InputRule = inputData.get_pressed_input_rule()
			if rule:
				characterData.add_moveinputname_to_bus(rule.get_moveinput_name())
			var moveName = translate_inputrule_to_movename(inputData.get_pressed_input_rule())
			if moveName != null:
				start_move(moveName)

func handle_event(event : InputEvent):
	if inputData != null:
		var inputRule : InputRule = inputData.handle_event(event)
		if inputRule:
			var moveName = translate_inputrule_to_movename(inputRule)
			var move = start_move(moveName)
			if move:
				put_in_move_bus(move)
				var comboMove : MoveRes = check_combo()
				if comboMove:
					moveBus.erase_all()
					characterData.do_move(comboMove)
				

func get_next_input_rule():
	if inputData != null:
		return inputData.pop_first_input_rule()
	return null

func start_move(moveName):
	var move : MoveRes = characterRes.get_move_by_name(moveName)
	if move:
		characterData.set_next_move_res(move)
		return move
	return null

func translate_inputrule_to_movename(inputRule:InputRule):
	if inputRule != null:
		return characterData.translate_moveinputname_to_movename(inputRule.get_moveinput_name())
	return null

func check_combo():
	var currentMoveData : MoveData = characterData.get_current_move()
	if currentMoveData:
		var currentMoveFrame = currentMoveData.get_current_move_frame()
		if currentMoveFrame:
			if currentMoveFrame.can_combo():
				var currentMoveDataName = currentMoveData.get_move_name()
				var combo : ComboRes = characterRes.get_combo_by_starting_move(currentMoveDataName)
				if combo:
					var i = 0
					var restOfCombo : Array = combo.get_rest_of_combo_names()
					var movesInMoveBus : Array = moveBus.get_all()
					for move : MoveRes in movesInMoveBus:
						if i < restOfCombo.size():
							var comboPartName = restOfCombo[i]
							if comboPartName != move.moveName:
								return null
						i += 1
						if i == restOfCombo.size():
							print("combo hit")
							return combo.get_resulting_move()

func put_in_move_bus(moveRes : MoveRes):
	moveBus.add_item(moveRes)

func set_player_id(newID:int):
	playerID = newID
	characterData.ownerID = newID
