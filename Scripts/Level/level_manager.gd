extends Node

signal start_new_day()
signal start_a_request()

var _decisions_made: int = 0
var _current_day: int = 0

@export var _max_decisions_per_day: int = 10
@export var _time_between_requests: float = 1.0

func _init() -> void:
	CommunicationBus.add_signal(start_new_day)
	CommunicationBus.add_signal(start_a_request)

func _ready() -> void:
	CommunicationBus.listen_to_signal("start_gameplay", _on_start_gameplay)
	CommunicationBus.listen_to_signal("decision_accepted", _on_decision_made)
	CommunicationBus.listen_to_signal("decision_denied", _on_decision_made)

func set_up_new_request() -> void:
	var request_info = _decide_which_request_to_get()

	$Request.set_up_decision_ui(request_info)
	start_a_request.emit()


func _decide_which_request_to_get() -> EnumsClassesConsts.RequestInfo:
	# TODO: Set up a way to decide which request to get based on the current status of everything
	# for now, just get a random request
	return $Request.get_random_request_by_group(EnumsClassesConsts.RequestGroup.RequestNormal)

func _on_decision_made() -> void:
	_decisions_made += 1
	if _decisions_made >= _max_decisions_per_day:
		_set_up_end_of_current_day()
	else:
		_set_up_end_of_current_request()

func _set_up_end_of_current_request() -> void:
	$Timer.timeout.connect(func() -> void:
		set_up_new_request()
		$Timer.stop()
	)
	$Timer.start(_time_between_requests)

func _set_up_end_of_current_day() -> void:
	#TODO: Set up the end of the day
	pass 

func _on_start_gameplay() -> void:
	pass # This is where we would set up teh game to start the first day
