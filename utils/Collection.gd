extends Resource
class_name Collection

@export var array : Array
@export var dictionary : Dictionary

func get_random_item():
	if array.size() > 0:
		return array[randi() % (array.size())]
	return null

func get_item(item):
	return array.find(item)

func erase(item):
	array.erase(item)

func get_first():
	if array.size()>0:
		return array[0]

func get_last():
	if array.size()>0:
		return array[-1]

func size():
	return array.size()

func get_at(ind):
	if ind < array.size():
		return array[ind]
	return null

func pop_at(ind):
	if array.size()>0:
		#print(str(self) + " popped index " + str(ind))
		return array.pop_at(ind)
	return null

func remove_at(i):
	array.remove_at(i)

func get_all():
	return array

func erase_all():
	array = []
