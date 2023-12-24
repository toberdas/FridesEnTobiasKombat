extends Resource
class_name Collision

var attackedCharacter 
var attackingCharacter

func _init(attacker : ActorData, attacked : ActorData):
	if check_if_different_owner(attacker, attacked):
		handle_collision(attacker, attacked)

func check_if_different_owner(actor : ActorData,actor2 : ActorData):
	return actor.ownerID != actor2.ownerID

func handle_collision(attacker : ActorData, attacked : ActorData):
	var attackingMoveFrame : MoveFrameRes = attacker.get_current_move_frame()
	var attackedMoveFrame : MoveFrameRes = attacked.get_current_move_frame()
	var hitRes = attackedMoveFrame.hitRes
	
	if attackedMoveFrame == null or attackingMoveFrame == null:
		return
	
	if attackedMoveFrame.hitRes == null:
		hitRes = preload("res://assets/misc/DefaultHitRes.tres")
	
	if attackingMoveFrame.attackRes == null:
		return
	
	if hitRes.blocks:
		attacker.take_recovery_time(attackingMoveFrame.attackRes.recoveryTimeWhenBlocked)
		return
	
	attacked.take_damage(attackingMoveFrame.attackRes.damage - hitRes.damageReduction)
	attacked.take_recovery_time(hitRes.recoveryTime)
