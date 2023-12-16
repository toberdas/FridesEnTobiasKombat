extends Collection
class_name LimitedCollection

enum OVERFLOWMODE{LIMIT,POPBACK,POPFRONT}

var overflowMode = OVERFLOWMODE.POPBACK
var maxSize = 6

func _init(_overflowMode, _maxSize):
	overflowMode = overflowMode
	maxSize = _maxSize

func add_item(item):
	if array.size() > maxSize - 1:
		if overflowMode == OVERFLOWMODE.POPBACK:
			array.pop_back()
		if overflowMode == OVERFLOWMODE.LIMIT:
			return
		if overflowMode == OVERFLOWMODE.POPFRONT:
			array.pop_front()
	array.append(item)
	#print(str(item) + " added to collection, array size is now " + str(array.size()))

