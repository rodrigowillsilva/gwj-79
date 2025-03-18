extends Node

signal show_decision_ui(request_info: EnumsClassesConsts.RequestInfo)
signal remove_decision_ui()
signal decision_accepted(request_info: EnumsClassesConsts.RequestInfo)
signal decision_denied(request_info: EnumsClassesConsts.RequestInfo)

@export var _time_to_hide_decision_ui:float= 0.5

var _current_request: EnumsClassesConsts.RequestInfo

func _init() -> void:
	CommunicationBus.add_signal(show_decision_ui)
	CommunicationBus.add_signal(remove_decision_ui)
	CommunicationBus.add_signal(decision_accepted)
	CommunicationBus.add_signal(decision_denied)

func _ready() -> void:
	CommunicationBus.listen_to_signal("accept_request", _on_accept_request)
	CommunicationBus.listen_to_signal("deny_request", _on_deny_request)

func set_up_decision_ui(request_info: EnumsClassesConsts.RequestInfo) -> void:
	_current_request = request_info
	show_decision_ui.emit(_current_request)

func _on_accept_request() -> void:
	_process_response(_current_request, "accept")
	_set_up_remove_decision_ui()

func _on_deny_request() -> void:
	_process_response(_current_request, "deny")
	_set_up_remove_decision_ui()
	

func _process_response(request_info: EnumsClassesConsts.RequestInfo, response: String) -> void:
	if response == "accept":
		decision_accepted.emit(request_info)
	elif response == "deny":
		decision_denied.emit(request_info)

func _set_up_remove_decision_ui() -> void:
	$Timer.start(_time_to_hide_decision_ui)
	$Timer.timout.connect(func() -> void:
		remove_decision_ui.emit()
	)
