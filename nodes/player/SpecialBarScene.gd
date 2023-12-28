extends Node2D

var playerData : PlayerData = null

func _process(_delta):
	var chargesNeeded = playerData.characterRes.chargesNeededForSpecial
	var currentCharges = playerData.characterData.specialCharges
	var text = ""
	for i in range(chargesNeeded):
		if i < currentCharges:
			text += "x"
		else:
			text += "o"
	$Label.text = text

