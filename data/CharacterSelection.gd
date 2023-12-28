extends Resource
class_name CharacterSelection

@export var players : Array[PlayerData]
@export var allCharactersCollection = preload("res://assets/character/AllCharacters.tres"):
	set(val):
		allCharactersCollection = val
		amountOfCharacters = allCharactersCollection.get_all().size()
		for i in range(amountOfCharacters):
			var selectable = Selectable.new()
			selectable.selectValue = allCharactersCollection.get_at(i)
			selectables.append(selectable)

var amountOfCharacters : int
var selectables : Array[Selectable] = []
var amountConfirmed : int = 0

signal character_confirmed
signal all_confirmed
signal cycled

func player_confirms_selection(player : PlayerData):
	var selectable :Selectable = get_highlighted_selectable(player)
	if selectable:
		var characterRes = allCharactersCollection.get_at(get_highlighted_selectable_index(player))
		player.characterRes = characterRes
		emit_signal("character_confirmed", characterRes)
		selectable.confirmed_by(player)
		amountConfirmed += 1
		if amountConfirmed == players.size():
			emit_signal("all_confirmed")

func handle_input_event(event : InputEvent):
	for player in players:
		var moveName = player.handle_event_for_character_select(event)
		if moveName != null:
			parse_movename_for_player(moveName, player)

func parse_movename_for_player(moveName:int,player:PlayerData):
	var oldIndex = get_highlighted_selectable_index(player)
	var oldSelectable = selectables[oldIndex]
	if oldSelectable.is_confirmed_by(player):
		return
	selectables[oldIndex].dehighlighted_by(player)
	if moveName == MOVES.moveInputs.WALKLEFT:
		oldIndex = wrapi(oldIndex + 1, 0, amountOfCharacters)
		emit_signal("cycled")
	if moveName == MOVES.moveInputs.WALKRIGHT:
		oldIndex = wrapi(oldIndex - 1, 0, amountOfCharacters)
		emit_signal("cycled")
	selectables[oldIndex].highlighted_by(player)
	if moveName == MOVES.moveInputs.LIGHTATTACK:
		player_confirms_selection(player)

func get_highlighted_selectable(player):
	for selectable in selectables:
		if selectable.is_highlighted_by(player):
			return selectable
	return null

func get_highlighted_selectable_index(player):
	var i = 0 
	for selectable in selectables:
		if selectable.is_highlighted_by(player):
			return i
		i += 1
	return 0
