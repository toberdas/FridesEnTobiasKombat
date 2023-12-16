extends Node2D

func _ready():
	$PlayerScene2.playerData.set_player_id(2)
	$PlayerScene2.playerData.inputData = null
	$PlayerScene2.playerData.characterData.direction = -1

func _process(_delta):
	if $PlayerScene2/ActorScene.position.x > $PlayerScene/ActorScene.position.x:
		$PlayerScene2.playerData.characterData.targetDirection = -1
		$PlayerScene.playerData.characterData.targetDirection = 1
	else:
		$PlayerScene2.playerData.characterData.targetDirection = 1
		$PlayerScene.playerData.characterData.targetDirection = -1
		
