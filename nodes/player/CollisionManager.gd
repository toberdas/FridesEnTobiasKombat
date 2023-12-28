extends Node2D
class_name CollisionManager

var actorData : ActorData

const BLOCKED_HIT_COLLECTION = preload("res://assets/geluid/soundcollections/BlockedHitCollection.tres")
const LIGHT_HIT_COLLECTION = preload("res://assets/geluid/soundcollections/LightHitCollection.tres")
const HEAVY_HIT_COLLECTION = preload("res://assets/geluid/soundcollections/HeavyHitCollection.tres")

signal destroy_attacker

func _ready():
	$AttackHitbox.connect("area_entered", attack_body)
	pass

func attack_body(body):
	if actorData:
		var _collision = Collision.new(actorData, body.get_parent().actorData)
		$AttackHitbox.set_deferred("monitoring", false)
		match _collision.hit:
			Collision.HITS.NONE:
				pass
			Collision.HITS.LIGHT:
				var sound = LIGHT_HIT_COLLECTION.get_random_item()
				if sound != null:	
					$HitAudio.stream = sound
					$HitAudio.play(0.0)
			Collision.HITS.HEAVY:
				var sound = HEAVY_HIT_COLLECTION.get_random_item()
				if sound != null:
					$HitAudio.stream = sound
					$HitAudio.play(0.0)
			Collision.HITS.BLOCKED:
				var sound = BLOCKED_HIT_COLLECTION.get_random_item()
				if sound != null:	
					$HitAudio.stream = sound
					$HitAudio.play(0.0)
		if _collision.destroyAttacker:
			emit_signal("destroy_attacker")

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
	$Hitbox.set_hitbox_from_res(preload("res://assets/misc/DefaultHitRes.tres").hitboxRes)
	$Hitbox.monitorable = true
