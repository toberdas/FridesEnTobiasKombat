extends Node2D

@export var matchData : Match = null
var matchStarted : bool = false
var playerInstances = []

const playerScene = preload("res://nodes/player/PlayerScene.tscn")

func _ready():
	start_match()

func start_match():
	if matchData:
		var i = 0
		for player : PlayerData in matchData.players:
			var playerInstance = playerScene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			$PlayerSceneRoot.get_child(i).add_child(playerInstance)
			playerInstance.start(player)
			playerInstances.append(playerInstance)
			i += 1
			
		playerInstances[1].playerData.characterData.direction = -1
		matchStarted = true

func _process(delta):
	if matchStarted:
		matchData.process(delta)
