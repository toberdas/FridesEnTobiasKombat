extends LimitedCollection
class_name TimedLimitedCollection

var timer = 0.0
var maxTimer = 0.2

func _init(_overflowMode, _maxSize, _time):
	super(_overflowMode, _maxSize)
	maxTimer = _time
	timer = maxTimer
	
func decay_timer(delta):
	timer -= delta 
	if timer <= 0.0:
		pop_at(0)
		timer = maxTimer
	
