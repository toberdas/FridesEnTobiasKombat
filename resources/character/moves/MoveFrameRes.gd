extends Resource
class_name MoveFrameRes

@export_group("Nested resources")
@export var hitRes : HitRes
@export var attackRes : AttackRes
@export var displacementRes : DisplacementRes
@export var projectileRes : ProjectileRes
@export var soundFromCollection : Collection = null
@export var specificSound : AudioStream = null
@export_group("Frame properties")
@export var canBeCancelled : bool = false
@export var canBeInterrupted : bool = false
@export var frameDuration : float = 0.1
@export var selfDestruct : bool = false
@export var canCombo : bool = false
@export var canLoop : bool = false
@export var increasesSpriteFrameCounter : bool = true
@export var grounding : bool = false

func get_frame_duration():
	return frameDuration

func can_be_cancelled():
	return canBeCancelled

func can_combo():
	return canCombo

func can_loop():
	return canLoop
