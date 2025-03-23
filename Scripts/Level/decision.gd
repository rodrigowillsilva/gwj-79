extends Node

signal remove_decision_ui()
signal decision_accepted(request: Request)
signal decision_denied(request: Request)
signal start_a_request(request: Request)

@export var _time_to_hide_decision_ui:float= 0.5
@export var max_decisions_per_day: int = 10

var _current_request: Request
var _special_decision_callbacks_array: Array[Callable] = []

@onready var decisions_made: Array[int] = [0,0,0,0,0,0,0]

func _init() -> void:
	CommunicationBus.add_signal(start_a_request)
	CommunicationBus.add_signal(remove_decision_ui)
	CommunicationBus.add_signal(decision_accepted)
	CommunicationBus.add_signal(decision_denied)


func set_up_decision_ui(request: Request) -> void:
	_current_request = request
	start_a_request.emit(_current_request)

func _on_accept_request() -> void:
	_process_response(_current_request, "accept")

func _on_deny_request() -> void:
	_process_response(_current_request, "deny")
	

func _process_response(request: Request, response: String) -> void:
	if response == "accept":
		decision_accepted.emit(request)
	elif response == "deny":
		decision_denied.emit(request)
	

func set_up_remove_decision_ui() -> void:
	remove_decision_ui.emit()
