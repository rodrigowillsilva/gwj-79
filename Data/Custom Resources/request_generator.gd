@tool
extends Node

class_name RequestGenerator


@export var title: String = "Request Title"
@export var description: String = "Request Description"
@export var squirrel_text_line: String = "Squirrel Voice Line"
@export var decision_approve_title: String = "Approve Title"
@export var decision_deny_title: String = "Deny Title"
@export var decision_approved_text: String  = "Approved Squirrel Voice Line"
@export var decision_denied_text: String = "Denied Squirrel Voice Line"
@export var approved_acorn_cost: int = 0
@export var approved_consequence_text: String = "Approved Consequence Text"
@export var approved_population_cost: int = 0
@export var approved_loyalty_cost: int = 0
@export var approved_tree_height_cost: int = 0
@export var denied_acorn_cost: int = 0
@export var denied_consequence_text: String = "Denied Consequence Text"
@export var denied_population_cost: int = 0
@export var denied_loyalty_cost: int = 0
@export var denied_tree_height_cost: int = 0
@export var pool: EnumsClassesConsts.RequestPool = EnumsClassesConsts.RequestPool.All

@export_tool_button("Create Request", "Callable") var create_request_button = create_request
func create_request():
# Create a new instance of the Request resource
	var request_resource = Request.new({
		"request_title": title,
		"request_description": description,
		"squirrel_text_line": squirrel_text_line,
		"decision_approve_title": decision_approve_title,
		"decision_deny_title": decision_deny_title,
		"decision_approved_text": decision_approved_text,
		"decision_denied_text": decision_denied_text,
		"approved_acorn_cost": approved_acorn_cost,
		"approved_consequence_text": approved_consequence_text,
		"approved_population_cost": approved_population_cost,
		"approved_loyalty_cost": approved_loyalty_cost,
		"approved_tree_height_cost": approved_tree_height_cost,
		"denied_acorn_cost": denied_acorn_cost,
		"denied_consequence_text": denied_consequence_text,
		"denied_population_cost": denied_population_cost,
		"denied_loyalty_cost": denied_loyalty_cost,
		"denied_tree_height_cost": denied_tree_height_cost,
		"pool": pool
	}
	)

	# Folder path where requests are saved
	var folder_path = "res://Data/Custom Resources/Requests"
	var dir = DirAccess.open(folder_path)
	
	var number_of_files: int = 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				number_of_files += 1
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Failed to open folder: " + folder_path)
	
	# Generate a unique file name based on system time and number of files
	var file_name = "request_%d.tres" % [number_of_files]
	var resource_path = folder_path + "/" + file_name
	
	var err = ResourceSaver.save(request_resource, resource_path)
	if err == OK:
		print("Request resource successfully created and saved at: ", resource_path)
	else:
		push_error("Failed to save the Request resource. Error code: %d" % err)
