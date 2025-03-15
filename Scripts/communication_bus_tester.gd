extends Node

@onready var comm_bus = CommunicationBus

func _ready():
	print("Communication Bus Tester 1 ready")
	$Timer.timeout.connect(send_test_messages)
	$Timer.start()

func send_test_messages():
	print("Tester 1: Sending test messages...")
	
	# Send a simple message
	var data = {
		"value": 42,
		"name": "Message from Tester 1"
	}
	comm_bus.publish("param_test_topic", data)
	
	# Send another message with different values
	var data2 = {
		"value": 100,
		"name": "Another message from Tester 1"
	}
	comm_bus.publish("param_test_topic", data2)
	
	print("Tester 1: Messages sent!")

# Button method for manual testing
func _on_send_button_pressed():
	send_test_messages()
