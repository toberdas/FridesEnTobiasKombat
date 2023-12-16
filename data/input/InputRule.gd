extends Resource
class_name InputRule

@export var input : InputEvent
@export var moveInputName : MOVES.moveInputs
@export var canBeHeld : bool = false
@export var holdBufferFrames : int = 6
@export var decayTime : float = 1.0
@export var canStack : bool = true

func matches_event(event : InputEvent):
	if event.device != input.device:
		return null
	if event is InputEventKey:
		if input is InputEventKey:
			if input.keycode == event.keycode:
				return true
	if event is InputEventJoypadButton:
		if input is InputEventJoypadButton:
			if input.button_index == event.button_index:
				return true
	if event is InputEventJoypadMotion:
		if input is InputEventJoypadMotion:
			if input.axis == event.axis:
				return true
	if event is InputEventMouseButton:
		if input is InputEventMouseButton:
			if input.button_index == event.button_index:
				return true
	#if event is InputEventMouseMotion:
		#if input is InputEventMouseButton:
			#if input.button_index == event.button_index:
				#return true	
	return null

func get_moveinput_name():
	return moveInputName
