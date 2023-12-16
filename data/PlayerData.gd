extends Resource
class_name PlayerData

var playerID : int = 0
var characterRes : CharacterRes = preload("res://assets/character/default/DefaultCharacter.tres")
var characterData : ActorData = ActorData.new()
var inputData : InputData = InputData.new()

func process(delta):
	if inputData != null:
		inputData.process(delta) ##TODO:overwegen om dit door inputscene te laten doen
	if is_character_free_to_move():
		var inputRule : InputRule = get_next_input_rule()
		if inputRule:
			var moveName : int = translate_inputrule_to_movename(inputRule)
			if moveName != null:
				start_move(moveName)
	
func handle_event(event : InputEvent):
	if inputData != null:
		inputData.handle_event(event)
		check_combo()

func is_character_free_to_move():
	return characterData.is_free_to_move()

func get_next_input_rule():
	if inputData != null:
		return inputData.pop_first_input_rule()
	return null

func start_move(moveName):
	var move = characterRes.get_move_by_name(moveName)
	if move:
		characterData.do_move(move)

func translate_inputrule_to_movename(inputRule:InputRule):
	if inputRule != null:
		return characterData.translate_moveinputname_to_movename(inputRule.get_moveinput_name())
	return null

func check_combo():
	var currentMove : MoveData = characterData.get_current_move()
	if currentMove:
		var currentMoveFrame = currentMove.get_current_move_frame()
		if currentMoveFrame:
			if currentMoveFrame.can_combo():
				var currentMoveName = currentMove.get_move_name()
				var combos = characterRes.get_combos_by_starting_move(currentMoveName)
				print(combos)
				for combo in combos:
					var _inputBus : InputBus = inputData.inputBus
					var i = 0
					var removeArray = []
					var hit = true
					removeArray.append(i)
					for comboPartName in combo.get_rest_of_combo():
						var moveName = translate_inputrule_to_movename(_inputBus.get_at(i))
						if moveName != comboPartName:
							hit = false
						i += 1
						removeArray.append(i)
					if i < combo.get_amount_of_moves() - 1:
						hit = false
					if hit:
						print("combo hit")
						characterData.do_move(combo.get_resulting_move())
						for removeIndex in removeArray:
							_inputBus.pop_at(removeIndex)
						return

func set_player_id(newID:int):
	playerID = newID
	characterData.ownerID = newID
