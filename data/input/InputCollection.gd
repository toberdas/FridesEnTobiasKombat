extends Resource
class_name InputCollection

@export var inputRules : Array[InputRule]

func get_rule_for_event(incomingInputEvent):
	for inputRule in inputRules:
		if inputRule.matches_event(incomingInputEvent):
			return inputRule
	return null
