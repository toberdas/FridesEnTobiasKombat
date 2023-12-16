extends Resource
class_name InputData

var inputCollection : InputCollection = preload("res://assets/input/DefaultInputCollection.tres")
var heldFrames : int
var inputBus = InputBus.new(InputBus.OVERFLOWMODE.LIMIT, 6, 0.8)
var eventCache = {}

func handle_event(event : InputEvent):
	var inputRule = get_rule(event)
	if inputRule != null:
		if can_rule_enter_bus(inputRule):
			put_rule_in_bus(inputRule)
		cache_input(inputRule, event)
		return inputRule
	return null

##TODO: dit opnieuw uitdenken
func process(delta):
	inputBus.decay_timer(delta)

func get_rule(event : InputEvent):
	return inputCollection.get_rule_for_event(event)

func can_rule_enter_bus(inputRule : InputRule):
	if is_last_input(inputRule):
		return false
	if is_event_just_pressed(inputRule):
		return true
	if inputRule.canBeHeld:
		heldFrames += 1
		if heldFrames >= inputRule.holdBufferFrames:
			heldFrames = 0
			return true

func put_rule_in_bus(inputRule : InputRule):
	inputBus.add_item(inputRule)
	print(inputBus.get_all())

func is_last_input(inputRule : InputRule):
	if inputBus.get_last() == inputRule:
		return true
	return false

func get_last_input_rule():
	return inputBus.get_last()

func get_first_input_rule():
	return inputBus.get_first()

func pop_first_input_rule():
	return inputBus.pop_at(0)

func cache_input(rule : InputRule, event : InputEvent):
	eventCache[rule] = event

func is_event_just_pressed(rule):
	if !eventCache.has(rule):
		return true
	else:
		if eventCache[rule].is_pressed() == false:
			return true
	return false
