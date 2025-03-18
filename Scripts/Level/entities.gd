extends Node
class_name Entities

@export var _entities: Dictionary[String, Node3D] = {}

func _init():
	_format_entities_dictionary()

func _ready() -> void:
	CommunicationBus.listen_to_signal("entity_speak", _on_entity_speak)
	CommunicationBus.listen_to_signal("entity_move", _on_entity_move)


func _on_entity_speak(entity_name: String, message: String) -> void:
	if _entities.has(format(entity_name)):
		_entities[format(entity_name)].speak(message)    
	

func _on_entity_move(entity_name: String, animation_name: String) -> void:
	if _entities.has(format(entity_name)):
		_entities[format(entity_name)].move(animation_name)

func _format_entities_dictionary() -> void:
	var aux_entities = _entities.duplicate()
	_entities = {}
	for entity_name in aux_entities.keys():
		_entities[format(entity_name)] = aux_entities[entity_name]


# Helper function to format the entity names to snake case
# It helps to reduce the size of the code and make it more readable
func format(string: String) -> String:
	return string.to_snake_case()
