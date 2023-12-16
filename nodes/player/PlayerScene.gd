extends Node2D

var playerData : PlayerData = PlayerData.new()

func _ready():
	playerData.start_move(MOVES.moves.IDLE)
	$ActorScene.set_actor_data(playerData.characterData)

func _process(delta):
	playerData.process(delta)

func _unhandled_input(event):
	playerData.handle_event(event)
#func _input(event : InputEvent):
	#playerData.handle_event(event)
