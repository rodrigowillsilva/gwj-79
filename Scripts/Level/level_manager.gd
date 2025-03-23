extends Node

signal start_new_day()
signal decision_made()

var _current_day: int = -1
var _current_request: Request
var _approved_special_effects_methods: Array[Callable] = []
var _denied_special_effects_methods: Array[Callable] = []
var _end_of_day_special_effects_methods: Array[Callable] = []
var _start_of_day_special_effects_methods: Array[Callable] = []

@export var _time_between_requests: float = 1.0

func _init() -> void:
	CommunicationBus.add_signal(start_new_day)
	CommunicationBus.add_signal(decision_made)

func _ready() -> void:
	CommunicationBus.listen_to_signal("start_gameplay", _on_start_gameplay)
	CommunicationBus.listen_to_signal("accept_request", _on_decision_accepted)
	CommunicationBus.listen_to_signal("deny_request", _on_decision_denied)
	CommunicationBus.listen_to_signal("ready_to_request", _on_ready_to_request)


func _process(_delta: float) -> void:
	#see if the player prassed the s keyboard key to start a new day
	if Input.is_action_just_pressed("start the game"):
		start_new_day.emit()
		_set_up_new_day()

func _set_up_new_day() -> void:
	_current_day += 1
	#$Decision.decisions_made.append(0)
	$Request.load_current_day_requests()
	start_new_day.emit()
	_set_general_timer(1.0, _set_up_next_requestor)
	$Timer.start()


func _set_up_next_requestor() -> void:
	_current_request = $Request.requests[$Decision.decisions_made[_current_day]]
	$Decision.decisions_made[_current_day] += $Decision.decisions_made[_current_day] + 1
	$Entities.prepare_requestor(_current_request)
	$Entities.move_requestor("walk_to_the_king")
	#continue in the _on_ready_to_request method

func _on_ready_to_request() -> void:
	$Decision.set_up_decision_ui(_current_request)

func _on_decision_accepted() -> void:
	if ($Resources.can_afford_request(_current_request)):
		$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Acorn, _current_request.approved_acorn_cost)
		$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Population, _current_request.approved_population_cost)
		$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Loyalty, _current_request.approved_loyalty_cost)
		$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.TreeHeight, _current_request.approved_tree_height_cost)
		decision_made.emit()
		_set_general_timer(1.0, $Decision.set_up_remove_decision_ui)
		

func _on_decision_denied() -> void:
	$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Acorn, _current_request.denied_acorn_cost)
	$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Population, _current_request.denied_population_cost)
	$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.Loyalty, _current_request.denied_loyalty_cost)
	$Resources.change_resource(EnumsClassesConsts.KingdomResourceTypes.TreeHeight, _current_request.denied_tree_height_cost)
	decision_made.emit()
	_set_general_timer(1.0, $Decision.set_up_remove_decision_ui)


# func _on_decision_made() -> void:
# 	$Decision.decisions_made[_current_day] += 1
# 	if $Decision.decisions_made[_current_day] >= $Decision.max_decisions_per_day:
# 		_set_up_end_of_current_day()
# 	else:
# 		_set_up_end_of_current_request()

func _set_up_end_of_current_request() -> void:
	$Timer.timeout.connect(func() -> void:
		
		$Timer.stop()
	)
	$Timer.start(_time_between_requests)

func _set_up_end_of_current_day() -> void:
	#TODO: Set up the end of the day
	pass 

func _on_start_gameplay() -> void:
	pass # This is where we would set up teh game to start the first day

func _set_general_timer(time: float, callback_method: Callable) -> void:
	if ($Timer.timeout.has_connections()):
		# get_connections() returns an array of Dictionaries {signal: Signal, callable: Callable, flags: int}
		var connections:Array = $Timer.timeout.get_connections()
		for connection in connections:
			$Timer.timeout.disconnect(connection["callable"])

	$Timer.timeout.connect(callback_method)
	$Timer.one_shot = true
	$Timer.wait_time = time
