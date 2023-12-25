extends Node2D

@export var game : Game
var characterSelection : CharacterSelection:
	set(val):
		characterSelection = val
		if characterSelection != null:
			characterSelection.connect("all_confirmed", start_match)

@export var matchScene : PackedScene
@export var characterSelectScene : PackedScene
var characterSelectInstance = null
var matchInstance = null

func _ready():
	start_character_select()

func start_character_select():
	characterSelectInstance = characterSelectScene.instantiate()
	characterSelection = game.character_select()
	characterSelection.allCharactersCollection = preload("res://assets/character/AllCharacters.tres")
	characterSelectInstance.characterSelection = characterSelection
	add_child(characterSelectInstance)

func start_match():
	characterSelectInstance.queue_free()
	characterSelection = null
	var matchData = game.make_match()
	matchData.connect("match_over", back_to_start)
	matchInstance = matchScene.instantiate()
	add_child(matchInstance)
	matchInstance.matchData = matchData
	matchInstance.start_match()

func back_to_start():
	await(get_tree().create_timer(4.0).timeout)
	matchInstance.queue_free()
	start_character_select()	
