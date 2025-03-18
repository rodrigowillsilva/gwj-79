extends Node

signal update_resources(resources_to_update: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int])

@export var _resources: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int] = {}
@export var _max_resources: Dictionary[EnumsClassesConsts.KingdomResourceTypes, int] = {}

func add_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> void:
	if _resources.has(resource_type):
		_calculate_new_resource_amount(resource_type, amount)
		update_resources.emit(_resources)
		

func remove_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> void:
	if _resources.has(resource_type):
		_calculate_new_resource_amount(resource_type, -amount)
		update_resources.emit(_resources)

func _calculate_new_resource_amount(resource_type: EnumsClassesConsts.KingdomResourceTypes, amount: int) -> void:
	_resources[resource_type] += clampi(amount, -_resources[resource_type], _max_resources[resource_type] - _resources[resource_type])

func get_resource(resource_type: EnumsClassesConsts.KingdomResourceTypes) -> int:
	if _resources.has(resource_type):
		return _resources[resource_type]
	return 0

func get_resources() -> Dictionary[EnumsClassesConsts.KingdomResourceTypes, int]:
	return _resources
