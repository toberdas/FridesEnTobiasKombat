extends Resource
class_name Game

@export var players : Array[PlayerData]

var currentMatch : Match

func make_match():
	currentMatch = Match.new()
	currentMatch.initialize_from_game(self)
	return currentMatch

func character_select():
	var characterSelection = CharacterSelection.new()
	characterSelection.players = players
	return characterSelection
