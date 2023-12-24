extends Node2D

@export var playerData : PlayerData
@onready var actorScene = $ActorScene

var started : bool = false

func start(_playerData : PlayerData):
	playerData = _playerData
	if actorScene:
		actorScene.set_actor_data(playerData.characterData)
	started = true

func _process(delta):
	if started:
		playerData.process(delta)

func _input(event : InputEvent):
	if started:
		playerData.handle_event(event)

func get_actor_location():
	if actorScene:
		return actorScene.global_position
