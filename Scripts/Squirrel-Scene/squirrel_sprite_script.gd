@tool
extends Node3D

@export var appearance: Squirrel_Appearance


@onready var body: Sprite3D = $Body
@onready var head: Sprite3D = $Body/Head
@onready var fluff: Sprite3D = $Body/Fluff
@onready var arm1_r: Sprite3D = $"Body/Arm1-R"
@onready var arm2_r: Sprite3D = $"Body/Arm1-R/Arm2-R"
@onready var hand_r: Sprite3D = $"Body/Arm1-R/Arm2-R/Hand-R"
@onready var arm1_l: Sprite3D = $"Body/Arm1-L"
@onready var arm2_l: Sprite3D = $"Body/Arm1-L/Arm2-L"
@onready var hand_l: Sprite3D = $"Body/Arm1-L/Arm2-L/Hand-L"
@onready var leg_r: Sprite3D = $"Body/Leg-R"
@onready var leg_l: Sprite3D = $"Body/Leg-L"
@onready var tail: Sprite3D = $Body/Tail
@onready var hat: Sprite3D = $Body/Head/Hat
@onready var eye_r: Sprite3D = $"Body/Head/Eye-R"
@onready var eye_l: Sprite3D = $"Body/Head/Eye-L"
@onready var eyebrow_r: Sprite3D = $"Body/Head/Eyebrow-R"
@onready var eyebrow_l: Sprite3D = $"Body/Head/Eyebrow-L"
@onready var accessory: Sprite3D = $Body/Accessory
@onready var object_l: Sprite3D = $"Body/Arm1-L/Arm2-L/Hand-L/Object-L"
@onready var object_r: Sprite3D = $"Body/Arm1-R/Arm2-R/Hand-R/Object-R"

@onready var original_eye_l_position: Vector3 = eye_l.position
@onready var original_eye_r_position: Vector3 = eye_r.position
@onready var original_eyebrow_l_position: Vector3 = eyebrow_l.position
@onready var original_eyebrow_r_position: Vector3 = eyebrow_r.position
@onready var original_accessory_position: Vector3 = accessory.position
@onready var original_object_l_position: Vector3 = object_l.position
@onready var original_object_r_position: Vector3 = object_r.position

func _ready():
	update_all_sprites()
	update_all_transforms()
	appearance.updated_sprites.connect(update_all_sprites)
	appearance.updated_transforms.connect(update_all_transforms)


func _process(delta):
	if not Engine.is_editor_hint():
		return
	
func update_all_sprites():
	body.texture = appearance.base.body_texture
	head.texture = appearance.base.head_texture
	fluff.texture = appearance.base.fluff_texture
	arm1_r.texture = appearance.base.arm_1_texture
	arm1_l.texture = appearance.base.arm_1_texture
	arm2_r.texture = appearance.base.arm_2_texture
	arm2_l.texture = appearance.base.arm_2_texture
	hand_r.texture = appearance.base.hand_texture
	hand_l.texture = appearance.base.hand_texture
	leg_r.texture = appearance.base.leg_texture
	leg_l.texture = appearance.base.leg_texture
	tail.texture = appearance.base.tail_texture
	
	hat.texture.region = Rect2i(appearance.hat_texture * 512, 0, 512, 512)
	eye_r.texture.region = Rect2i(appearance.eye_texture * 64, 0, 64, 64)
	eye_l.texture.region = Rect2i(appearance.eye_texture * 64, 0, 64, 64)
	eyebrow_r.texture.region = Rect2i(appearance.eyebrow_texture * 64, 0, 64, 64)
	eyebrow_l.texture.region = Rect2i(appearance.eyebrow_texture * 64, 0, 64, 64)
	accessory.texture.region = Rect2i(appearance.accessory_texture * 512, 0, 512, 512)
	object_l.texture.region = Rect2i(appearance.held_l_texture * 512, 0, 512, 512)
	object_r.texture.region = Rect2i(appearance.held_r_texture * 512, 0, 512, 512)
	
func update_all_transforms():
	body.scale = Vector3(appearance.body_size, appearance.body_size, 1)
	eye_l.scale = Vector3(appearance.eye_size, appearance.eye_size, 1)
	eye_r.scale = Vector3(appearance.eye_size, appearance.eye_size, 1)
	eyebrow_l.scale = Vector3(appearance.eyebrow_size, appearance.eyebrow_size, 1)
	eyebrow_r.scale = Vector3(appearance.eyebrow_size, appearance.eyebrow_size, 1)
	
	eye_l.position = original_eye_l_position + Vector3(appearance.eye_offset.x, appearance.eye_offset.y, 0)
	eye_r.position = original_eye_r_position + Vector3(appearance.eye_offset.x * -1, appearance.eye_offset.y, 0)
	eyebrow_l.position = original_eyebrow_l_position + Vector3(appearance.eyebrow_offset.x, appearance.eyebrow_offset.y, 0)
	eyebrow_r.position = original_eyebrow_r_position + Vector3(appearance.eyebrow_offset.x * -1, appearance.eyebrow_offset.y, 0)
	accessory.position = original_accessory_position + Vector3(appearance.accessory_offset.x, appearance.accessory_offset.y, 0)
	object_l.position = original_object_l_position + Vector3(appearance.object_l_offset.x, appearance.object_l_offset.y, 0)
	object_r.position = original_object_r_position + Vector3(appearance.object_r_offset.x, appearance.object_r_offset.y, 0)
