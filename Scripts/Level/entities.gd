extends Node
class_name Entities

signal entity_speak(message: String)

@export var _entities: Dictionary[String, SquirrelMaster] = {}

func _init():
	_format_entities_dictionary()


func speak(entity_name: String, message: String) -> void:
	if _entities.has(format(entity_name)):
		_entities[format(entity_name)].speak(message)    
	
func move_requestor(animation_name: String) -> void:
	if _entities.has("requestor"):
		_entities["requestor"].move(animation_name)

func prepare_requestor(request: Request) -> void:
	if _entities.has("requestor"):
		_entities["requestor"].prepare_request(request) 

func _format_entities_dictionary() -> void:
	var aux_entities = _entities.duplicate()
	_entities = {}
	for entity_name in aux_entities.keys():
		_entities[format(entity_name)] = aux_entities[entity_name]


# Helper function to format the entity names to snake case
# It helps to reduce the size of the code and make it more readable
func format(string: String) -> String:
	return string.to_snake_case()
