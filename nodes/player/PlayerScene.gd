extends Node2D

var playerData : PlayerData
@onready var actorScene = $ActorScene

func start():
	if actorScene:
		actorScene.set_actor_data(playerData.characterData)

func _process(delta):
	playerData.process(delta)

func _input(event : InputEvent):
	playerData.handle_event(event)
