extends Resource
class_name Collision

enum HITS{NONE,LIGHT,HEAVY,SPECIAL,BLOCKED}

var attackedCharacter 
var attackingCharacter

var hit = HITS.NONE
var destroyAttacker = false

func _init(attacker : ActorData, attacked : ActorData):
	if check_if_different_owner(attacker, attacked):
		handle_collision(attacker, attacked)

func check_if_different_owner(actor : ActorData,actor2 : ActorData):
	return actor.ownerID != actor2.ownerID

func handle_collision(attacker : ActorData, attacked : ActorData):
	var attackMove : MoveData = attacker.get_current_move()
	var attackedMove : MoveData = attacked.get_current_move()
	
	var attackingMoveFrame : MoveFrameRes = attacker.get_current_move_frame()
	var attackedMoveFrame : MoveFrameRes = attacked.get_current_move_frame()
	var hitRes : HitRes = attackedMoveFrame.hitRes
	var attackRes : AttackRes = attackingMoveFrame.attackRes	
	
	if attackedMove.moveRes.cantBeHit: ##TODO:eigenlijk per frame maar luiheid
		return
	
	if attackedMoveFrame == null or attackingMoveFrame == null:
		return
	
	if hitRes == null:
		hitRes = preload("res://assets/misc/DefaultHitRes.tres")
	
	if attackRes == null:
		return
	
	if attackRes.destroyOnHit:
		destroyAttacker = true
	
	if hitRes.blocks:
		hit = HITS.BLOCKED
		attacked.increase_special_charges(1)
		attacker.take_recovery_time(attackingMoveFrame.attackRes.recoveryTimeWhenBlocked)
		return
	
	if attackRes.resultingPassiveMove == null:
		attacked.do_passive_move(preload("res://assets/misc/KnockbackLightMove.tres"))
	else:
		attacked.do_passive_move(attackRes.resultingPassiveMove)
	
	attacker.increase_special_charges(attackRes.specialChargesGainedOnHit)
	attacked.take_damage(attackingMoveFrame.attackRes.damage - hitRes.damageReduction)

	var recoveryTime = hitRes.recoveryTime
	attacked.take_recovery_time(0.2)
	
	if attackMove.get_move_name() == MOVES.moves.LIGHTATTACK:
		hit = HITS.LIGHT
	if attackMove.get_move_name() == MOVES.moves.HEAVYATTACK:
		hit = HITS.HEAVY
	if attackMove.get_move_name() == MOVES.moves.SPECIAL:
		hit = HITS.SPECIAL
	if attackMove.get_move_name() == MOVES.moves.AIRKICK:
		hit = HITS.HEAVY
