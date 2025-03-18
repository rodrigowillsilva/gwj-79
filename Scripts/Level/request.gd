extends Node
class_name RequestManager

const REQUEST_DATA_PATH = "res://Data/Requests/"

var _requests: Dictionary = {}

func _init() -> void:
	pass
	#load_requests()


func get_random_request_by_group(request_group: EnumsClassesConsts.RequestGroup) -> EnumsClassesConsts.RequestInfo:
	var request_index = calculate_random_request_index_by_group(request_group)

	var request_data = _get_request_data(request_index)

	var request_info:EnumsClassesConsts.RequestInfo = EnumsClassesConsts.RequestInfo.new(
			request_data)

	return request_info

func get_specific_request(request_index: int) -> EnumsClassesConsts.RequestInfo:
	var request_data = _get_request_data(request_index)

	var request_info:EnumsClassesConsts.RequestInfo = EnumsClassesConsts.RequestInfo.new(
			request_data)
	
	return request_info

#func load_requests() -> void:
	
		

						
							
func _get_request_data(request_index: int) -> Dictionary:
	return _requests["req" + str(request_index)]

func calculate_random_request_index_by_group(request_group: EnumsClassesConsts.RequestGroup) -> int:
	var request_index = randi() % _requests.size() + 1
	while _requests["req" + str(request_index)]["group"] != str(request_group):
		request_index = randi() % _requests.size() + 1
	return request_index	
			
		
