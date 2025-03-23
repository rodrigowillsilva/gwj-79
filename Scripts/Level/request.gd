extends Node
class_name RequestManager

@export var requests: Array[Request]
var _current_day_requests: Array[Request] = []

func _init() -> void:
	pass


func load_current_day_requests() -> void:
	_current_day_requests.clear()
	for request_index in range(0, 10):
		if request_index <= 3:
			_load_early_request()
		elif request_index <= 8:
			_load_anytime_request()
		else:
			_load_late_request()

	# #print the requests
	# for request in _current_day_requests:
	# 	print(request.title)

func _load_early_request() -> void:
	var request_info = get_random_request_by_group(EnumsClassesConsts.RequestPool.Early if randf() < 0.8 else EnumsClassesConsts.RequestPool.All)
	_current_day_requests.append(request_info)

func _load_anytime_request() -> void:
	var request_info = get_random_request_by_group(EnumsClassesConsts.RequestPool.All)
	_current_day_requests.append(request_info)

func _load_late_request() -> void:
	var request_info = get_random_request_by_group(EnumsClassesConsts.RequestPool.Late if randf() < 0.8 else EnumsClassesConsts.RequestPool.All)
	_current_day_requests.append(request_info)

func get_random_request_by_group(request_pool: EnumsClassesConsts.RequestPool) -> Request:
	var request_index = calculate_random_request_index_by_group(request_pool)

	var request = get_specific_request(request_index)

	return request

func get_specific_request(request_index: int) -> Request:
	var request = requests[request_index]
	return request


func calculate_random_request_index_by_group(request_pool: EnumsClassesConsts.RequestPool) -> int:
	var request_index = randi() % requests.size()
	while requests[request_index]["pool"] != request_pool:
		request_index = randi() % requests.size()
	return request_index
			
		
