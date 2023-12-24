extends Resource
class_name InputData

var inputCollection : InputCollection = preload("res://assets/input/DefaultInputCollection.tres")
<<<<<<< HEAD
var heldFrames : int
var inputBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.9)
var eventCache = {}
=======

var lastInput : InputRule
var inputHeldCache = {}

func _init(_inputCollection):
	inputCollection = _inputCollection
>>>>>>> movebus

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
	return inputCollection.get_rule_for_event(event)

<<<<<<< HEAD
func can_rule_enter_bus(inputRule : InputRule):
	if !inputRule.canStack && is_last_input(inputRule):
		return false
	if is_event_just_pressed(inputRule):
		return true
	if inputRule.canBeHeld:
		heldFrames += 1
		if heldFrames >= inputRule.holdBufferFrames:
			print('heldframes reset')
			heldFrames = 0
		return true

func put_rule_in_bus(inputRule : InputRule):
	inputBus.add_item(inputRule)
	#print(inputBus.get_all())

func is_last_input(inputRule : InputRule):
	var lastInput = inputBus.get_last()
	if lastInput:
		if lastInput == inputRule:
			return true
	return false

func is_last_two_inputs(inputRule : InputRule):
	pass

func get_last_input_rule():
	return inputBus.get_last()

func get_first_input_rule():
	return inputBus.get_first()

func pop_first_input_rule():
	return inputBus.pop_at(0)

func cache_input(rule : InputRule, event : InputEvent):
	eventCache[rule] = event
=======
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
>>>>>>> movebus

func is_event_just_pressed(rule):
	if !inputHeldCache.has(rule):
		cache_pressed(rule)
		return true
	if inputHeldCache[rule] == false:
		cache_pressed(rule)
		return true
	return false
