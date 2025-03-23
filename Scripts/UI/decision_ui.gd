extends Control

signal accept_request()
signal deny_request()

@onready var title: Label = $Paper/Title
@onready var description: Label = $"Paper/Description Text"
@onready var decision_approve_title: Label = $Paper/Accept/Label
@onready var decision_approve_subtitle: Label = $Paper/Refuse/Label
@onready var aprove_costs: Label = $Paper/Accept/Costs
@onready var deny_costs: Label = $Paper/Refuse/Costs
@onready var decision_made: Label = $"Paper/Decision Made"
@onready var after_decision: Label = $"Paper/After Decision"

func _init() -> void:
	CommunicationBus.add_signal(accept_request)
	CommunicationBus.add_signal(deny_request)
	
func _ready() -> void:
	CommunicationBus.listen_to_signal("start_a_request", _on_start_a_request)
	CommunicationBus.listen_to_signal("remove_decision_ui", _on_remove_decision_ui)
	CommunicationBus.listen_to_signal("decision_made", _on_decision_made)

func _on_start_a_request(request: Request) -> void:
	_move_request_paper_to_screen()

	_clear_decision_ui()

	title.text = request.title
	description.text = request.description
	decision_approve_title.text = request.decision_approve_title
	decision_approve_subtitle.text = request.decision_deny_title
	if request.approved_acorn_cost != 0:
		aprove_costs.text = "Acorn: " + str(request.approved_acorn_cost)
	if decision_approve_subtitle.text == "":
		aprove_costs.text += "\n" + request.decision_approve_subtitle
	if request.decision_deny_subtitle == "":
		deny_costs.text = request.decision_deny_subtitle
	if request.approved_population_cost != 0:
		aprove_costs.text += "\nPopulation: " + str(request.approved_population_cost)
	if request.approved_loyalty_cost != 0:
		aprove_costs.text += "\nLoyalty: " + str(request.approved_loyalty_cost)
	if request.approved_tree_height_cost != 0:
		aprove_costs.text += "\nTree Height: " + str(request.approved_tree_height_cost)
	if request.denied_acorn_cost != 0:
		deny_costs.text = "Acorn: " + str(request.denied_acorn_cost)
	if request.denied_population_cost != 0:
		deny_costs.text += "\nPopulation: " + str(request.denied_population_cost)
	if request.denied_loyalty_cost != 0:
		deny_costs.text += "\nLoyalty: " + str(request.denied_loyalty_cost)
	if request.denied_tree_height_cost != 0:
		deny_costs.text += "\nTree Height: " + str(request.denied_tree_height_cost)


func _clear_decision_ui() -> void:
	title.text = ""
	description.text = ""
	decision_approve_title.text = ""
	decision_approve_subtitle.text = ""
	aprove_costs.text = ""
	deny_costs.text = ""
	decision_made.text = ""
	after_decision.text = ""
	$Paper/Finish.disabled = true
	$Paper/Finish.set_deferred("visible", false)
	$"Paper/After Decision".set_deferred("visible", false)
	
func _move_request_paper_to_screen() -> void:
	$AnimationPlayer.play("show_request_paper")

func _on_accept_pressed() -> void:
	accept_request.emit()
	
func _on_refuse_pressed() -> void:
	deny_request.emit()

func _on_decision_made() -> void:
	$Paper/Finish.disabled = false
	$Paper/Finish.set_deferred("visible", true)
	$"Paper/After Decision".set_deferred("visible", true)

func _on_remove_decision_ui() -> void:
	$AnimationPlayer.play("hide_request_paper")
	$Paper/Finish.disabled = true
	$Paper/Finish.set_deferred("visible", false)
	$"Paper/After Decision".set_deferred("visible", false)
	$"Paper/Decision Made".set_deferred("visible", false)
