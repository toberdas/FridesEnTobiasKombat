extends Node2D

var actorData : ActorData = null:
	set(val):
		actorData = val
		actorData.location = global_position

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
			if parseFrame.soundFromCollection != null:
				$MoveAudio.stream = parseFrame.soundFromCollection.get_random_item()
				$MoveAudio.play(0.0)
			if parseFrame.specificSound != null:
				$MoveAudio.stream = parseFrame.specificSound
				$MoveAudio.play(0.0)
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
			if parseFrame.grounding:
				global_position.y = 0.0
		var passiveParseFrame : MoveFrameRes = actorData.parse_current_passive_frame()
		
		if passiveParseFrame:
			var displacementRes = passiveParseFrame.displacementRes
			if displacementRes != null:
				displace(displacementRes)
		var currentMove : MoveData = actorData.get_current_move()
		if currentMove:
			adjust_sprite_location(currentMove)

func adjust_sprite_location(currentMove):
	var spriteSheet : Texture2D = currentMove.moveRes.spriteSheet
	var w = spriteSheet.get_width()
	var wpf = w / currentMove.moveRes.spriteFrameAmount
	var h = spriteSheet.get_height()
	var xDif = wpf - 64
	var yDif = h - 64
	var rX = xDif
	$Sprite2D.position = Vector2(rX * 0.5, -yDif * 0.5)

func displace(displacementRes : DisplacementRes):
	var hdisplacement = displacementRes.horizontalDisplacement
	global_position.x += hdisplacement * actorData.direction
	global_position.y += displacementRes.verticalDisplacement
	actorData.location = global_position
	
func set_actor_data(_actorData):
	actorData = _actorData
	$CollisionManager.actorData = actorData
	$ProjectileManager.actorData = actorData


func _on_collision_manager_destroy_attacker():
	queue_free()
