extends Node

enum KingdomResourceTypes {
	Acorn,
	Population,
	Loyalty,
	TreeHeight
}

enum RequestGroup {
	RequestNormal,
	RequestTest
}

enum EntityTypes {
	King,
	Requester
}

const ENTITY_TYPE_NAMES = {
	EntityTypes.King: "King",
	EntityTypes.Requester: "Requester"
}


class RequestInfo:
	var title: String
	var description: String
	var squirrel_voice_line: String
	var decision_approved_description: String
	var decision_denied_description: String
	var decision_approved_squirrel_voice_line: String
	var decision_denied_squirrel_voice_line: String
	var acorn_cost: int
	var population_cost: int
	var loyalty_cost: int
	var tree_height_cost: int
	var group: String 

	func _init(initialization_dictionary: Dictionary) -> void:
		title = initialization_dictionary["request_title"]
		description = initialization_dictionary["request_description"]
		squirrel_voice_line = initialization_dictionary["squirrel_voice_line"]
		decision_approved_description = initialization_dictionary["decision_approved_description"]
		decision_denied_description = initialization_dictionary["decision_denied_description"]
		decision_approved_squirrel_voice_line = initialization_dictionary["decision_approved_squirrel_voice_line"]
		decision_denied_squirrel_voice_line = initialization_dictionary["decision_denied_squirrel_voice_line"]
		acorn_cost = initialization_dictionary["acorn_cost"]
		population_cost = initialization_dictionary["population_cost"]
		loyalty_cost = initialization_dictionary["loyalty_cost"]
		tree_height_cost = initialization_dictionary["tree_height_cost"]
		group = initialization_dictionary["group"]
