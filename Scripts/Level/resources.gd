extends Node

signal update_resources(resources_to_update: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int])

@export var _resources: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int] = {}
@export var _max_resources: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int] = {}

func _init() -> void:
	CommunicationBus.add_signal(update_resources)


func _ready():
	CommunicationBus.listen_to_signal("start_new_day", _on_start_new_day)

func change_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> void:
	if not _resources.has(resource_type):
		return

	_calculate_new_resource_amount(resource_type, amount)
	update_resources.emit(_resources)


func _calculate_new_resource_amount(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> void:
	_resources[resource_type] += amount
	_resources[resource_type] = clampi(_resources[resource_type], 0, _max_resources[resource_type])

func get_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes) -> int:
	if _resources.has(resource_type):
		return _resources[resource_type]
	return 0

func get_resources() -> Dictionary[EnumsClassesConsts.KingdomResourceTypes, int]:
	return _resources

func check_if_enough_of_a_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> bool:
	if _resources.has(resource_type):
		return _resources[resource_type] >= amount
	return false

func can_afford_request(request: Request) -> bool:
	var can_afford = true
	
	if not check_if_enough_of_a_resource(EnumsClassesConsts.KingdomResourceTypes.Acorn, request.approved_acorn_cost):
		can_afford = false
	elif not check_if_enough_of_a_resource(EnumsClassesConsts.KingdomResourceTypes.Population, request.approved_population_cost):
		can_afford = false

	return can_afford

func _on_start_new_day() -> void:
	update_resources.emit(_resources)
