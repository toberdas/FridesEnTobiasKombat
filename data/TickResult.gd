extends Resource
class_name TickResult

enum RESULT{NOTHING,FRAMEINCREASE,MOVEENDED,TIMERINCREASE}

var result : int = RESULT.NOTHING

func _init(_result):
	result = _result
