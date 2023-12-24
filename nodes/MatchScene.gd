extends Node2D

@export_category('Player one')
@export var playerOneCharacterResource : CharacterRes
@export var playerOneInputCollection : InputCollection
@export_category('Player two')
@export var playerTwoCharacterResource : CharacterRes
@export var playerTwoInputCollection : InputCollection

func _ready():
	$PlayerScene.characterRes = playerOneCharacterResource
	$PlayerScene.inputCollection = playerOneInputCollection
	$PlayerScene2.characterRes = playerTwoCharacterResource
	$PlayerScene2.inputCollection = playerTwoInputCollection
	$PlayerScene.start()
	$PlayerScene2.start()
	$PlayerScene2.playerData.set_player_id(2)
	$PlayerScene2.playerData.characterData.direction = -1

func _process(_delta):
	if $PlayerScene2/ActorScene.global_position.x > $PlayerScene/ActorScene.global_position.x:
		$PlayerScene2/ActorScene.actorData.targetDirection = -1
		$PlayerScene/ActorScene.actorData.targetDirection = 1
	else:
		$PlayerScene2/ActorScene.actorData.targetDirection = 1
		$PlayerScene/ActorScene.actorData.targetDirection = -1
