extends Node

var _signals: Dictionary[String, Signal] = {}

func add_signal(signal_to_add: Signal) -> void:
	_signals[signal_to_add.get_name().to_snake_case()] = signal_to_add

func listen_to_signal(signal_name: String, callback_method: Callable, flags: int = 0) -> void:
	if _check_for_signal(signal_name):
		_signals[signal_name.to_snake_case()].connect(callback_method, flags)

func remove_signal(signal_name: String) -> void:
	if _check_for_signal(signal_name):
		_remove_all_connections(signal_name)
		_signals.erase(signal_name.to_snake_case())

func _check_for_signal(signal_name: String) -> bool:
	return _signals.has(signal_name.to_snake_case())

func _remove_all_connections(signal_name: String) -> void:
	if _check_for_signal(signal_name):
		if _signals[signal_name.to_snake_case()].has_connections():
			var connections = _signals[signal_name.to_snake_case()].get_connections()
			for connection in connections:
				_signals[signal_name.to_snake_case()].disconnect(connection)

# func _create_topic(topic: String, callback_method_name: String, parameters: Array[Dictionary] = []) -> void:
# 	_topics[topic.to_snake_case()] = Signal(self, callback_method_name.to_snake_case())
# 	add_user_signal(callback_method_name.to_snake_case(), parameters)

# func _connect_topic(topic: String, callback_method: Callable, flags: int = 0) -> void:
# 	_topics[topic.to_snake_case()].connect(callback_method, flags)

# func _disconnect_topic(topic: String, callback_method: Callable) -> void:
# 	_topics[topic.to_snake_case()].disconnect(callback_method)

# func _ensure_topic_exists(topic: String) -> bool:
# 	return _topics.has(topic.to_snake_case())

# func _ensure_topic_is_not_connected_to_this_callback(topic: String, callback_method: Callable) -> bool:
# 	return not _topics[topic.to_snake_case()].is_connected(callback_method)

# func subscribe(topic: String, callbackMethod: Callable, parameters: Array[Dictionary] = []) -> void:
# 	if not _ensure_topic_exists(topic):
# 		_create_topic(topic, callbackMethod.get_method(), parameters)

# 	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
# 		_connect_topic(topic, callbackMethod)

# func subscribe_deferred(topic: String, callbackMethod: Callable) -> void:
# 	if not _ensure_topic_exists(topic):
# 		_create_topic(topic, callbackMethod.get_method(),)
	
# 	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
# 		_connect_topic(topic, callbackMethod, CONNECT_DEFERRED)

# func subscribe_one_shot(topic: String, callbackMethod: Callable) -> void:
# 	if not _ensure_topic_exists(topic):
# 		_create_topic(topic, callbackMethod.get_method())
	
# 	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
# 		_connect_topic(topic, callbackMethod, CONNECT_ONE_SHOT)

# func unsubscribe(topic: String, callbackMethod: Callable) -> void:
# 	if _ensure_topic_exists(topic):
# 		_disconnect_topic(topic, callbackMethod)

# func publish(topic: String, data: Variant) -> void:
# 	if _topics.has(topic):
# 		_topics[topic.to_snake_case()].emit(data)

# func has_topic(topic: String) -> bool:
# 	return _topics.has(topic.to_snake_case())

# func get_topics() -> Array:
# 	return _topics.keys()
