extends Resource

class_name Request

@export var title: String
@export var description: String
@export var squirrel_text_line: String
@export var decision_approve_title: String
@export var decision_deny_title: String
@export var decision_approved_text: String
@export var decision_denied_text: String
@export var approved_acorn_cost: int
@export var approved_consequence_text: String
@export var approved_population_cost: int
@export var approved_loyalty_cost: int
@export var approved_tree_height_cost: int
@export var denied_acorn_cost: int
@export var denied_consequence_text: String
@export var denied_population_cost: int
@export var denied_loyalty_cost: int
@export var denied_tree_height_cost: int
@export var pool: String

func _init(initialization_dictionary: Dictionary) -> void:
    title = initialization_dictionary["request_title"]
    description = initialization_dictionary["request_description"]
    squirrel_text_line = initialization_dictionary["squirrel_text_line"]
    decision_approve_title = initialization_dictionary["decision_approve_title"]
    decision_deny_title = initialization_dictionary["decision_deny_title"]
    decision_approved_text = initialization_dictionary["decision_approved_text"]
    decision_denied_text = initialization_dictionary["decision_denied_text"]
    approved_acorn_cost = initialization_dictionary["approved_acorn_cost"]
    approved_consequence_text = initialization_dictionary["approved_consequence_text"]
    approved_population_cost = initialization_dictionary["approved_population_cost"]
    approved_loyalty_cost = initialization_dictionary["approved_loyalty_cost"]
    approved_tree_height_cost = initialization_dictionary["approved_tree_height_cost"]
    denied_acorn_cost = initialization_dictionary["denied_acorn_cost"]
    denied_consequence_text = initialization_dictionary["denied_consequence_text"]
    denied_population_cost = initialization_dictionary["denied_population_cost"]
    denied_loyalty_cost = initialization_dictionary["denied_loyalty_cost"]
    denied_tree_height_cost = initialization_dictionary["denied_tree_height_cost"]
    pool = initialization_dictionary["pool"]
    