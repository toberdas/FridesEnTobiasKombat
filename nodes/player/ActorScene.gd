extends Node2D

var actorData : ActorData

func check_collisions():
	pass

func _process(delta):
	actorData.tick_time(delta)
	var parseFrame : MoveFrameRes = actorData.parse_current_frame()
	if parseFrame:
		scale.x = actorData.direction
		var displacementRes = parseFrame.displacementRes
		if displacementRes != null:
			displace(displacementRes)
		var hitRes = parseFrame.hitRes
		$CollisionManager.handle_hit_res(hitRes)
		var attackRes = parseFrame.attackRes
		$CollisionManager.handle_attack_res(attackRes)
		var projectileRes = parseFrame.projectileRes
		$ProjectileManager.handle_projectile_res(projectileRes)
		if parseFrame.selfDestruct:
			queue_free()
		var currentMove : MoveData = actorData.get_current_move()
		if currentMove:
			$Sprite2D.texture = currentMove.moveRes.spriteSheet
			var currentFrames = actorData.get_current_move_frames()
			if currentFrames.size() > 0:
				$Sprite2D.hframes = currentFrames.size()
			$Sprite2D.frame = actorData.get_current_move_frame_index()

func displace(displacementRes : DisplacementRes):
	var hdisplacement = displacementRes.horizontalDisplacement
	position.x += hdisplacement * actorData.direction
	position.y += displacementRes.verticalDisplacement
	
func set_actor_data(_actorData):
	actorData = _actorData
	$CollisionManager.actorData = actorData
	$ProjectileManager.actorData = actorData
