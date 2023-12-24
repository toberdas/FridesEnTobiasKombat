extends Node2D

var actorData : ActorData = null

func check_collisions():
	pass

func _process(delta):
	if actorData:
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
			var currentMoveData : MoveData = actorData.get_current_move()
			if currentMoveData:
				var spriteSheet = currentMoveData.moveRes.spriteSheet
				var frameCount = currentMoveData.get_sprite_frame_count()
				$Sprite2D.texture = spriteSheet
				$Sprite2D.hframes = frameCount
				var spriteIndex = actorData.get_current_sprite_index()
				if spriteIndex < frameCount:
					$Sprite2D.frame = spriteIndex
				else:
					print_debug("sprite index overflow")

func displace(displacementRes : DisplacementRes):
	var hdisplacement = displacementRes.horizontalDisplacement
	position.x += hdisplacement * actorData.direction
	position.y += displacementRes.verticalDisplacement
	actorData.location = position
	
func set_actor_data(_actorData):
	actorData = _actorData
	$CollisionManager.actorData = actorData
	$ProjectileManager.actorData = actorData
