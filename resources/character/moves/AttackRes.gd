extends Resource
class_name AttackRes

@export var hitboxRes : HitboxRes = HitboxRes.new()
@export var damage : int = 1
@export var recoveryTimeWhenBlocked : float = 0.4
@export var recoveryTimeWhenNotBlocked : float = 0.0
@export var destroyOnHit : bool = false
