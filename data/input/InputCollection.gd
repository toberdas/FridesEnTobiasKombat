extends Resource
class_name InputCollection

@export var inputRules : Array[InputRule]

var inputHeldCache = {}

func get_rule_for_event(incomingInputEvent):
	for inputRule in inputRules:
		if inputRule.matches_event(incomingInputEvent):
			return inputRule
	return null

func handle_event(event : InputEvent):
	var inputRule = get_rule(event)
	if inputRule != null:
		if !event.is_pressed():
			cache_released(inputRule)
			return null
		if is_event_just_pressed(inputRule):
			return inputRule
	return null

func get_rule(event : InputEvent):
	return get_rule_for_event(event)

func cache_pressed(rule : InputRule):
	inputHeldCache[rule] = true

func cache_released(rule : InputRule):
	inputHeldCache[rule] = false

func get_pressed_input_rule():
	for key : InputRule in inputHeldCache.keys():
		if inputHeldCache[key] == true:
			if key.canBeHeld:
				return key
	return null

func is_event_just_pressed(rule):
	if !inputHeldCache.has(rule):
		cache_pressed(rule)
		return true
	if inputHeldCache[rule] == false:
		cache_pressed(rule)
		return true
	return false
