extends Node
class_name ProjectileManager

var actorData : ActorData

func handle_projectile_res(projectileRes : ProjectileRes):
	if projectileRes:
		shoot_projectile(projectileRes)

func shoot_projectile(projectileRes : ProjectileRes):
	var _actorData = actorData.duplicate(true)
	_actorData.do_move(projectileRes.moveRes)
	_actorData.ownerID = actorData.ownerID
	_actorData.direction = actorData.direction
	var actorInstance = load("res://nodes/player/ActorScene.tscn").instantiate()
	add_child(actorInstance)
	actorInstance.global_position = owner.global_position + directed_vector2(projectileRes.spawnOffset)
	actorInstance.set_actor_data(_actorData)

func directed_vector2(vector2:Vector2):
	return Vector2(vector2.x * actorData.direction, vector2.y)
