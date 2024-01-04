extends Node2D

@export var matchData : Match = null
var matchStarted : bool = false
var playerInstances = []

const playerScene = preload("res://nodes/player/PlayerScene.tscn")
const STAGE_COLLECTION = preload("res://assets/stage/StageCollection.tres")

func _ready():
	randomize()
	var stageRes = STAGE_COLLECTION.get_random_item()
	unpack_stage_res(stageRes)
	start_match()

func unpack_stage_res(stageRes:StageRes):
	if stageRes.backgroundSprite != null:
		$Camera2D/Background.texture = stageRes.backgroundSprite
		$Camera2D/Background.visible = true
	if stageRes.foregroundSprite != null:
		$Camera2D/Foreground.texture = stageRes.foregroundSprite
		$Camera2D/Foreground.visible = true
	if stageRes.backgroundSpriteFrames != null:
		$Camera2D/AnimatedBackground.sprite_frames = stageRes.backgroundSpriteFrames
		$Camera2D/AnimatedBackground.visible = true
		$Camera2D/AnimatedBackground.play("default")
	if stageRes.foregroundSpriteFrames != null:
		$Camera2D/AnimatedForeground.sprite_frames = stageRes.foregroundSpriteFrames
		$Camera2D/AnimatedForeground.visible = true
		$Camera2D/AnimatedForeground.play("default")

func start_match():
	if matchData:
		spawn_players()
		matchStarted = true

func spawn_players():
	var i = 0
	for player : PlayerData in matchData.players:
		var playerInstance = playerScene.instantiate()
		$PlayerSceneRoot.get_child(i).add_child(playerInstance)
		playerInstance.start(player)
		playerInstances.append(playerInstance)
		i += 1
		
	playerInstances[1].playerData.characterData.direction = -1
	playerInstances[1].set_hp_bar_direction(-1)

func _process(delta):
	if matchStarted:
		matchData.process(delta)
