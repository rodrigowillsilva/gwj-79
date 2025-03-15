extends Node

var _topics: Dictionary[String, Signal] = {}


func create_topic(topic: String, callback_method_name: String, parameters: Array[Dictionary] = []) -> void:
	_topics[topic] = Signal(self, callback_method_name.to_snake_case())
	add_user_signal(callback_method_name.to_snake_case(), parameters)

func connect_topic(topic: String, callback_method: Callable, flags: int = 0) -> void:
	_topics[topic].connect(callback_method, flags)

func disconnect_topic(topic: String, callback_method: Callable) -> void:
	_topics[topic].disconnect(callback_method)

func _ensure_topic_exists(topic: String) -> bool:
	return _topics.has(topic)

func _ensure_topic_is_not_connected_to_this_callback(topic: String, callback_method: Callable) -> bool:
	return not _topics[topic].is_connected(callback_method)

func subscribe(topic: String, callbackMethod: Callable, parameters: Array[Dictionary] = []) -> void:
	if not _ensure_topic_exists(topic):
		create_topic(topic, callbackMethod.get_method(), parameters)

	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
		connect_topic(topic, callbackMethod)

func subscribe_deferred(topic: String, callbackMethod: Callable) -> void:
	if not _ensure_topic_exists(topic):
		create_topic(topic, callbackMethod.get_method(),)
	
	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
		connect_topic(topic, callbackMethod, CONNECT_DEFERRED)

func subscribe_one_shot(topic: String, callbackMethod: Callable) -> void:
	if not _ensure_topic_exists(topic):
		create_topic(topic, callbackMethod.get_method())
	
	if _ensure_topic_is_not_connected_to_this_callback(topic, callbackMethod):
		connect_topic(topic, callbackMethod, CONNECT_ONE_SHOT)

func unsubscribe(topic: String, callbackMethod: Callable) -> void:
	if _ensure_topic_exists(topic):
		disconnect_topic(topic, callbackMethod)

func publish(topic: String, data: Variant) -> void:
	if _topics.has(topic):
		_topics[topic].emit(data)

func has_topic(topic: String) -> bool:
	return _topics.has(topic)

func get_topics() -> Array:
	return _topics.keys()
