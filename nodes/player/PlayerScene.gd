extends Node2D

@export var characterRes : CharacterRes
@export var inputCollection : InputCollection

var playerData : PlayerData
@onready var actorScene = $ActorScene

func start():
	playerData = PlayerData.new(characterRes)
	playerData.set_input_data(InputData.new(inputCollection))
	if actorScene:
		actorScene.set_actor_data(playerData.characterData)

func _process(delta):
	playerData.process(delta)

func _input(event : InputEvent):
	playerData.handle_event(event)
