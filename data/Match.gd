extends Resource
class_name Match

var game : Game

@export_category('Players')
@export var players : Array[PlayerData]

signal match_over

func initialize_from_game(_game:Game):
	game = _game
	players = game.players
	for player in players:
		player.characterData.hitpointData.connect("death", player_death)

func process(_delta):
	if players[1].characterData.location.x > players[0].characterData.location.x:
		players[1].characterData.targetDirection = -1
		players[0].characterData.targetDirection = 1
	else:
		players[1].characterData.targetDirection = 1
		players[0].characterData.targetDirection = -1

func player_death():
	var deadPlayer = find_dead_player()
	var winningPlayer = find_alive_player()
	deadPlayer.lose()
	winningPlayer.win()
	emit_signal("match_over")

func find_alive_player():
	for player in players:
		if player.characterData.hitpointData.hitpoints > 0:
			return player

func find_dead_player():
	for player in players:
		if player.characterData.hitpointData.hitpoints <= 0:
			return player
