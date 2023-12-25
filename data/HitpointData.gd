extends Resource
class_name HitpointData

var hitpoints : int = 10
var hitpointResources : Array[HitpointRes] = []
var currentHitpointRes : HitpointRes

signal hitpoints_lost
signal death

func _init(hitpointResourceArray):
	hitpointResources = hitpointResourceArray
	find_current_hitpoint_res()

func take_damage(damage:int):
	hitpoints -= damage
	find_current_hitpoint_res()
	emit_signal("hitpoints_lost")
	if hitpoints <= 0:
		emit_signal("death")
		

func find_current_hitpoint_res():
	for hitpointRes in hitpointResources:
		if hitpoints > hitpointRes.hitpointRange[0] && hitpoints < hitpointRes.hitpointRange[1]:
			currentHitpointRes = hitpointRes
