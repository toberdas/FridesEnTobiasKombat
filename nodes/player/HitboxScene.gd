extends Area2D

func set_hitbox_from_res(hitboxRes:HitboxRes):
	if hitboxRes:
		$CollisionShape2D.shape.size = hitboxRes.hitboxSize
		$CollisionShape2D.position = hitboxRes.hitboxLocation
	else:
		$CollisionShape2D.shape.size = Vector2.ZERO
		$CollisionShape2D.position = Vector2.ZERO
