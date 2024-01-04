extends Node2D

@export_group("Game resource")
@export var game : Game
var characterSelection : CharacterSelection:
	set(val):
		characterSelection = val
		if characterSelection != null:
			characterSelection.connect("all_confirmed", start_match)
@export_group("Children scenes")
@export var matchScene : PackedScene
@export var characterSelectScene : PackedScene
@export var splashScreenScene : PackedScene
var characterSelectInstance = null
var matchInstance = null
var splashScreenInstance = null

const CHARACTER_SELECT_MUSIC = preload("res://assets/geluid/muziek/characterSelectMusic.wav")
const FIGHT_MUSIC = preload("res://assets/geluid/muziek/fightMusic.wav")


func _ready():
	splash_screen()

func splash_screen():
	splashScreenInstance = splashScreenScene.instantiate()
	add_child(splashScreenInstance)
	splashScreenInstance.connect("go_further", start_character_select)

func start_character_select():
	if characterSelectInstance == null:
		$ScreenTransition.start_transition()
		$MusicPlayer.stream = CHARACTER_SELECT_MUSIC
		$MusicPlayer.play()
		
		characterSelectInstance = characterSelectScene.instantiate()
		characterSelection = game.character_select()
		characterSelection.allCharactersCollection = preload("res://assets/character/AllCharacters.tres")
		characterSelectInstance.characterSelection = characterSelection
		add_child(characterSelectInstance)

func start_match():
	if matchInstance == null:
		await(get_tree().create_timer(2.4).timeout)	
		$ScreenTransition.start_transition()
		$MusicPlayer.stop()
		$MusicPlayer.stream = FIGHT_MUSIC
		$MusicPlayer.play()
		characterSelectInstance.queue_free()
		characterSelection = null
		var matchData = game.make_match()
		matchData.connect("match_over", back_to_start)
		matchInstance = matchScene.instantiate()
		add_child(matchInstance)
		matchInstance.matchData = matchData
		matchInstance.start_match()

func back_to_start():
	$MusicPlayer.stop()
	await(get_tree().create_timer(4.0).timeout)	
	$ScreenTransition.start_transition()
	matchInstance.queue_free()
	matchInstance = null
	splash_screen()	


func _on_music_player_finished():
	$MusicPlayer.play(0.0)
