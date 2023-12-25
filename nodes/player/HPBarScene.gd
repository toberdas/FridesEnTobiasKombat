extends Sprite2D

var hitPointData : HitpointData = null:
	set(val):
		hitPointData = val
		hitPointData.connect('hitpoints_lost', update_hp_bar)

func set_hitpoint_data(newData):
	hitPointData = newData

func update_hp_bar():
	$Label.text = str(hitPointData.hitpoints)
