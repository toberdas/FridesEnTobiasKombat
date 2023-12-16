extends Resource
class_name HitpointData

var hitpoints : int = 10
var hitpointResources : Array[HitpointRes] = []
var currentHitpointRes : HitpointRes

func take_damage(damage:int):
	hitpoints -= damage
	find_current_hitpoint_res()

func find_current_hitpoint_res():
	for hitpointRes in hitpointResources:
		if hitpoints > hitpointRes.hitpointRange[0] && hitpoints < hitpointRes.hitpointRange[1]:
			currentHitpointRes = hitpointRes
