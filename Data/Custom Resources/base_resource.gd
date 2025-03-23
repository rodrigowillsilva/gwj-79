extends Resource

class_name Request

@export var title: String
@export var description: String
@export var decision_approve_title: String
@export var decision_approve_subtitle: String
@export var decision_deny_title: String
@export var decision_deny_subtitle: String
@export var approved_acorn_cost: int
@export var approved_consequence_text: String
@export var approved_population_cost: int
@export var approved_loyalty_cost: int
@export var approved_tree_height_cost: int
@export var approved_special_effect: int
@export var denied_acorn_cost: int
@export var denied_consequence_text: String
@export var denied_population_cost: int
@export var denied_loyalty_cost: int
@export var denied_tree_height_cost: int
@export var denied_special_effect: int
@export var pool: EnumsClassesConsts.RequestPool

@export var appearance: Squirrel_Appearance

var request_dictionary: Dictionary = {}

func _init(initialization_dictionary: Dictionary = {}) -> void:
	if initialization_dictionary.is_empty():
		return

	request_dictionary = initialization_dictionary
	title = initialization_dictionary["request_title"]
	description = initialization_dictionary["request_description"]
	decision_approve_title = initialization_dictionary["decision_approve_title"]
	decision_approve_subtitle = initialization_dictionary["decision_approve_subtitle"]
	decision_deny_title = initialization_dictionary["decision_deny_title"]
	decision_deny_subtitle = initialization_dictionary["decision_deny_subtitle"]
	approved_acorn_cost = initialization_dictionary["approved_acorn_cost"]
	approved_consequence_text = initialization_dictionary["approved_consequence_text"]
	approved_population_cost = initialization_dictionary["approved_population_cost"]
	approved_loyalty_cost = initialization_dictionary["approved_loyalty_cost"]
	approved_tree_height_cost = initialization_dictionary["approved_tree_height_cost"]
	approved_special_effect = initialization_dictionary["approved_special_effect"]
	denied_acorn_cost = initialization_dictionary["denied_acorn_cost"]
	denied_consequence_text = initialization_dictionary["denied_consequence_text"]
	denied_population_cost = initialization_dictionary["denied_population_cost"]
	denied_loyalty_cost = initialization_dictionary["denied_loyalty_cost"]
	denied_tree_height_cost = initialization_dictionary["denied_tree_height_cost"]
	denied_special_effect = initialization_dictionary["denied_special_effect"]
	pool = initialization_dictionary["pool"]
	appearance = initialization_dictionary["appearance"]
