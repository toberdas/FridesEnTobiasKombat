extends Resource
class_name Selectable

var selectDict : Dictionary =  {}
var selectValue = null

func dehighlighted_by(playerData : PlayerData):
	if !selectDict.has(playerData):
		selectDict[playerData] = Select.new()
	selectDict[playerData].highlighted = false

func highlighted_by(playerData : PlayerData):
	if !selectDict.has(playerData):
		selectDict[playerData] = Select.new()
	selectDict[playerData].highlighted = true

func confirmed_by(playerData : PlayerData):
	selectDict[playerData].confirmed = true

func is_highlighted_by(playerData : PlayerData):
	if selectDict.has(playerData):
		return selectDict[playerData].highlighted

func is_confirmed_by(playerData : PlayerData):
	if selectDict.has(playerData):
		return selectDict[playerData].confirmed

func get_string(playerData : PlayerData):
	if is_highlighted_by(playerData) && !is_confirmed_by(playerData):
		return "P " + str(playerData.playerID)
	if is_confirmed_by(playerData):
		return "P " + str(playerData.playerID) + " gekozen"
	return ""

func get_color(playerData : PlayerData):
	if is_highlighted_by(playerData) && !is_confirmed_by(playerData):
		return playerData.color
	if is_confirmed_by(playerData):
		return playerData.color
	return Color.WHITE
