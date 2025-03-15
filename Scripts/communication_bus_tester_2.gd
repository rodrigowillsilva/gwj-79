extends Node

@onready var comm_bus = CommunicationBus

func _ready():
	print("Communication Bus Tester 2 ready")
	setup_subscriptions()

func setup_subscriptions():
	# Subscribe with parameters to receive messages from tester 1
	var parameters: Array[Dictionary] = [
		{"name": "data", "type": TYPE_DICTIONARY}
	]
	
	# Subscribe to the parameterized topic
	comm_bus.subscribe("param_test_topic", _on_param_message_received, parameters)
	print("Tester 2: Subscribed to param_test_topic")

# Callback to handle received messages
func _on_param_message_received(data: Dictionary):
	print("Tester 2: Received parameterized message!")
	
	if data.has("value"):
		print("Tester 2: Received value: ", data.value)
	
	if data.has("name"):
		print("Tester 2: Received name: ", data.name)
	
	# You can respond back to tester 1 if needed
	var response = {
		"response_value": data.value * 2,
		"status": "Received by Tester 2"
	}
	
	# Optional: Publish response back
	# comm_bus.publish("response_topic", response)
	
	# Just print the response for now
	print("Tester 2: Would respond with: ", response)

# Button method to manually test unsubscribing
func _on_unsubscribe_button_pressed():
	comm_bus.unsubscribe("param_test_topic", _on_param_message_received)
	print("Tester 2: Unsubscribed from param_test_topic")

# Button method to resubscribe
func _on_resubscribe_button_pressed():
	setup_subscriptions()
