extends Resource
class_name PlayerData

@export var playerID : int = 0
@export var characterRes : CharacterRes = null :
	set(_characterRes):
		characterRes = _characterRes
		characterData = ActorData.new()
		characterData.set_character_res(characterRes)
		characterData.ownerID = playerID
var characterData : ActorData = null
@export var inputCollection : InputCollection = null
@export var color : Color

func process(_delta):
	if inputCollection:
		if characterData.is_free_to_move():
			var rule : InputRule = inputCollection.get_pressed_input_rule()
			if rule:
				characterData.add_moveinputname_to_bus(rule.get_moveinput_name())

func handle_event_for_character_select(event : InputEvent):
	if inputCollection != null:
		var inputRule : InputRule = inputCollection.handle_event(event)
		if inputRule:
			var inputMoveName = inputRule.get_moveinput_name()
			return inputMoveName

func handle_event(event : InputEvent):
	if inputCollection != null:
		var inputRule : InputRule = inputCollection.handle_event(event)
		if inputRule:
			var inputMoveName = inputRule.get_moveinput_name()
			characterData.add_moveinputname_to_bus(inputMoveName)

func get_next_input_rule():
	if inputCollection != null:
		return inputCollection.pop_first_input_rule()
	return null

func set_player_id(newID:int):
	playerID = newID
	characterData.ownerID = newID

func set_input_collection(newInputCollection):
	inputCollection = newInputCollection

func win():
	characterData.do_move_by_name(MOVES.moves.WIN)

func lose():
	characterData.do_move_by_name(MOVES.moves.DEATH)
