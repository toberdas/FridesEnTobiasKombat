extends Node2D

func _ready():
	var playerData = PlayerData.new(preload("res://assets/character/default/DefaultCharacter.tres"))
	$PlayerScene.playerData = playerData
	$PlayerScene.start()
