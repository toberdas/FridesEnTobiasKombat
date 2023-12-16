extends Node2D
class_name CollisionManager

var actorData : ActorData

func _ready():
	$AttackHitbox.connect("area_entered", attack_body)
	pass

func attack_body(body):
	var _collision = Collision.new(actorData, body.get_parent().actorData)
	$AttackHitbox.set_deferred("monitoring", false)

func handle_attack_res(attackRes:AttackRes):
	if attackRes:
		set_attack_hitbox(attackRes)
	else:
		clear_attack_hitbox()

func handle_hit_res(hitRes : HitRes):
	if hitRes:
		set_hitbox(hitRes)
	else:
		clear_hitbox()

func set_attack_hitbox(attackRes : AttackRes):
	$AttackHitbox.set_hitbox_from_res(attackRes.hitboxRes)
	$AttackHitbox.monitoring = true

func clear_attack_hitbox():
	$AttackHitbox.set_hitbox_from_res(null)
	$AttackHitbox.monitoring = false

func set_hitbox(hitRes : HitRes):
	$Hitbox.set_hitbox_from_res(hitRes.hitboxRes)
	$Hitbox.monitorable = true

func clear_hitbox():
	$Hitbox.set_hitbox_from_res(null)
	$Hitbox.monitorable = false
