extends Resource
class_name Match

var game : Game

@export_category('Players')
@export var players : Array[PlayerData]

func initialize_from_game(_game:Game):
	game = _game
	players = game.players

func process(_delta):
	if players[1].characterData.location.x > players[0].characterData.location.x:
		players[1].characterData.targetDirection = 1
		players[0].characterData.targetDirection = -1
	else:
		players[1].characterData.targetDirection = -1
		players[0].characterData.targetDirection = 1
