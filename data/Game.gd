extends Resource
class_name Game

@export var players : Array[PlayerData]

var currentMatch : Match

func start_game():
	create_players()

func make_match():
	currentMatch = Match.new()
	currentMatch.initialize_from_game(self)
	return currentMatch

func character_select():
	var characterSelection = CharacterSelection.new()
	characterSelection.players = players
	return characterSelection

func create_players():
	var playerOneData = PlayerData.new()
	playerOneData.set_input_collection(preload("res://assets/input/DefaultInputCollection.tres"))
	playerOneData.playerID = 0
	var playerTwoData = PlayerData.new()
	playerTwoData.set_input_collection(preload("res://assets/input/SecondDefaultInputCollection.tres"))
	playerTwoData.playerID = 1
	players.append(playerOneData)
	players.append(playerTwoData)
