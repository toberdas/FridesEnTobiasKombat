extends Node2D

@export var playerOneCharacterRes : CharacterRes

func _ready():
	var playerData = PlayerData.new(playerOneCharacterRes)
	$PlayerScene.playerData = playerData
	$PlayerScene.start()
	
