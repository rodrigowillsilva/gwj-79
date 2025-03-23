extends Node3D

class_name SquirrelMaster

signal ready_to_request()

@export var enter_the_room_position: Marker3D
@export var exit_the_room_position: Marker3D

var _my_request: Request = null

func _init():
	CommunicationBus.add_signal(ready_to_request)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		$Squirrel_Character_Animations.play("walk_to_the_king")

func _ready():
	var walk_to_king: Animation = $Squirrel_Character_Animations.get_animation("walk_to_the_king")
	walk_to_king.track_set_key_value(0, 0, enter_the_room_position.global_transform.origin)
	walk_to_king.track_set_key_value(0, 1, exit_the_room_position.global_transform.origin)
	print(enter_the_room_position.global_transform.origin)
	print(exit_the_room_position.global_transform.origin)
	print(walk_to_king.track_get_key_value(0, 0))
	print(walk_to_king.track_get_key_value(0, 1))

	var walk_away: Animation = $Squirrel_Character_Animations.get_animation("walk_away_from_king")
	walk_away.track_set_key_value(0, 0, exit_the_room_position.global_transform.origin)
	walk_away.track_set_key_value(0, 1, enter_the_room_position.global_transform.origin)

func prepare_request(request: Request) -> void:
	_my_request = request
	$Sprite.appearance = _my_request.appearance
	$Sprite.update_all_sprites()
	$Sprite.update_all_transforms()

func move(animation_name: String) -> void:
	$Squirrel_Character_Animations.play(animation_name)

func on_ready_to_request() -> void:
	ready_to_request.emit()
