extends Resource
class_name PlayerData

var playerID : int = 0
var characterRes : CharacterRes = preload("res://assets/character/default/DefaultCharacter.tres")
var characterData : ActorData = null
var inputData : InputData = InputData.new()

func _init(_characterRes:CharacterRes):
	characterRes = _characterRes
	characterData = ActorData.new()
	characterData.ownerID = playerID
	characterData.set_character_res(characterRes)

func process(delta):
	if inputData:
		if characterData.is_free_to_move():
			var rule : InputRule = inputData.get_pressed_input_rule()
			if rule:
				characterData.add_moveinputname_to_bus(rule.get_moveinput_name())

func handle_event(event : InputEvent):
	if inputData != null:
		var inputRule : InputRule = inputData.handle_event(event)
		if inputRule:
			var inputMoveName = inputRule.get_moveinput_name()
			characterData.add_moveinputname_to_bus(inputMoveName)

func get_next_input_rule():
	if inputData != null:
		return inputData.pop_first_input_rule()
	return null

func set_player_id(newID:int):
	playerID = newID
	characterData.ownerID = newID
