extends Control

@onready var fade_in_player = $fade_in_player

func _ready():
	fade_in_player.play("main_menu_fadein")

func _on_play_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_leaderboards_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_exit_button_pressed():
	pass # Replace with function body.
