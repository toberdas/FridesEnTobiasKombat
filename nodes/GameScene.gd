extends Node2D

var game : Game
var characterSelection : CharacterSelection

@export var matchScene : PackedScene

const characterSelectScene = preload("res://nodes/CharacterSelectionScene.tscn")
var characterSelectInstance = null

func _ready():
	game = Game.new()
	game.start_game()
	characterSelectInstance = characterSelectScene.instantiate()
	characterSelection = game.character_select()
	characterSelection.allCharactersCollection = preload("res://assets/character/AllCharacters.tres")
	characterSelectInstance.characterSelection = characterSelection
	add_child(characterSelectInstance)

func _process(delta):
	if characterSelection != null:
		if characterSelection.allConfirmed:
			characterSelectInstance.queue_free()
			characterSelection = null
			var matchData = game.make_match()
			var matchInstance = matchScene.instantiate()
			add_child(matchInstance)
			matchInstance.matchData = matchData
			matchInstance.start_match()
