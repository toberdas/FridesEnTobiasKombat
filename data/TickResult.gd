extends Resource
class_name TickResult

enum RESULT{NOTHING,FRAMEINCREASE,MOVEENDED,TIMERINCREASE}

var result : int = RESULT.NOTHING

var lastFrame : MoveFrameRes
var currentFrame : MoveFrameRes

func _init(_result):
	result = _result

func set_last_frame(frame : MoveFrameRes):
	lastFrame = frame
