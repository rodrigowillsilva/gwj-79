extends Control

@onready var play_button: Button = $HBoxContainer/VBoxContainer/Play_Button
@onready var options_button: Button = $HBoxContainer/VBoxContainer/Options_Button
@onready var leaderboards_button: Button = $HBoxContainer/VBoxContainer/Leaderboards_Button
@onready var exit_button: Button = $HBoxContainer/VBoxContainer/Exit_Button

@onready var blackout: ColorRect = $AnimatedBG/SubViewport/blackoutBG

@onready var fade_in_player: AnimationPlayer = $fade_in_player
@onready var play_button_sequence: AnimationPlayer = $play_button_sequence

@onready var bg_camera: Camera2D = $AnimatedBG/Camera2D


func _ready():
	bg_camera.zoom = Vector2(1.1, 1.1)
	blackout.visible = false
	fade_in_player.play("main_menu_fadein")

func _on_play_button_pressed():
	play_button.disabled = true
	options_button.disabled = true
	leaderboards_button.disabled = true
	exit_button.disabled = true
	
	blackout.visible = true
	play_button_sequence.play("zoom_onto_tree")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_leaderboards_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
