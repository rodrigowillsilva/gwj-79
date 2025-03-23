@tool
class_name squirrel_sprite_controller

extends Node3D
@export var appearance_template: Squirrel_Appearance

@export var raven_sprite: Sprite3D = self.get_parent().get_node("RavenSprite")

@onready var body: Sprite3D = get_node("Body")
@onready var head: Sprite3D = body.get_node("Head")
@onready var fluff: Sprite3D = body.get_node("Fluff")
@onready var arm1_r: Sprite3D = body.get_node("Arm1-R")
@onready var arm2_r: Sprite3D = arm1_r.get_node("Arm2-R")
@onready var hand_r: Sprite3D = arm2_r.get_node("Hand-R")
@onready var arm1_l: Sprite3D = body.get_node("Arm1-L")
@onready var arm2_l: Sprite3D = arm1_l.get_node("Arm2-L")
@onready var hand_l: Sprite3D = arm2_l.get_node("Hand-L")
@onready var leg_r: Sprite3D = body.get_node("Leg-R")
@onready var leg_l: Sprite3D = body.get_node("Leg-L")
@onready var tail: Sprite3D = body.get_node("Tail")
@onready var hat: Sprite3D = head.get_node("Hat")
@onready var eye_r: Sprite3D = head.get_node("Eye-R")
@onready var eye_l: Sprite3D = head.get_node("Eye-L")
@onready var eyebrow_r: Sprite3D = head.get_node("Eyebrow-R")
@onready var eyebrow_l: Sprite3D = head.get_node("Eyebrow-L")
@onready var accessory: Sprite3D = body.get_node("Accessory")
@onready var object_l: Sprite3D = hand_l.get_node("Object-L")
@onready var object_r: Sprite3D = hand_r.get_node("Object-R")

@onready var original_eye_l_offset: Vector2 = eye_l.offset
@onready var original_eye_r_offset: Vector2 = eye_r.offset
@onready var original_eyebrow_l_offset: Vector2 = eyebrow_l.offset
@onready var original_eyebrow_r_offset: Vector2 = eyebrow_r.offset
@onready var original_hat_offset: Vector2 = hat.offset
@onready var original_accessory_offset: Vector2 = accessory.offset
@onready var original_object_l_offset: Vector2 = object_l.offset
@onready var original_object_r_offset: Vector2 = object_r.offset

@onready var hat_atlas: AtlasTexture = hat.texture.duplicate()
@onready var accessory_atlas: AtlasTexture = accessory.texture.duplicate()
@onready var held_atlas_l: AtlasTexture = object_l.texture.duplicate()
@onready var held_atlas_r: AtlasTexture = object_r.texture.duplicate()
@onready var eye_atlas: AtlasTexture = eye_r.texture.duplicate()
@onready var eyebrow_atlas: AtlasTexture = eyebrow_r.texture.duplicate()

@onready var appearance: Squirrel_Appearance

func _ready():
	raven_sprite.visible = false
	change_appearance(appearance_template)
	
	hat.texture = hat_atlas
	accessory.texture = accessory_atlas
	object_l.texture = held_atlas_l
	object_r.texture = held_atlas_r
	eye_l.texture = eye_atlas
	eye_r.texture = eye_atlas
	eyebrow_l.texture = eyebrow_atlas
	eyebrow_r.texture = eyebrow_atlas
	appearance = appearance_template
	
	
	update_all_sprites()
	update_all_transforms()
	notify_property_list_changed()

func make_raven():
	raven_sprite.visible = true
	self.visible = false


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
	if appearance.eye_texture >= 1:
		eye_l.set_flip_h(true)
	else:
		eye_l.set_flip_h(false)
	eyebrow_r.texture.region = Rect2i(appearance.eyebrow_texture * 128, 0, 128, 128)
	eyebrow_l.texture.region = Rect2i(appearance.eyebrow_texture * 128, 0, 128, 128)
	accessory.texture.region = Rect2i(appearance.accessory_texture * 512, 0, 512, 512)
	object_l.texture.region = Rect2i(appearance.held_l_texture * 512, 0, 512, 512)
	object_r.texture.region = Rect2i(appearance.held_r_texture * 512, 0, 512, 512)
	
func update_all_transforms():
	body.scale = Vector3(appearance.body_size, appearance.body_size, 1)
	eye_l.scale = Vector3(appearance.eye_size, appearance.eye_size, 1)
	eye_r.scale = Vector3(appearance.eye_size, appearance.eye_size, 1)
	eyebrow_l.scale = Vector3(appearance.eyebrow_size, appearance.eyebrow_size, 1)
	eyebrow_r.scale = Vector3(appearance.eyebrow_size, appearance.eyebrow_size, 1)
	
	eye_l.offset = appearance.eye_offset
	eye_r.offset = appearance.eye_offset * -1
	eye_r.offset.y = eye_l.offset.y
	hat.offset = appearance.hat_offset
	eyebrow_l.offset = appearance.eyebrow_offset
	eyebrow_r.offset =  appearance.eyebrow_offset
	eyebrow_r.offset.y = eyebrow_l.offset.y
	accessory.offset = appearance.accessory_offset
	object_l.offset = appearance.object_l_offset
	object_r.offset = appearance.object_r_offset

func change_appearance(new_appearance: Squirrel_Appearance):
	
	if is_instance_valid(appearance):
		disconnect_appearance_signals(appearance)
	
	appearance = new_appearance
	appearance.updated_sprites.connect(update_all_sprites)
	appearance.updated_transforms.connect(update_all_transforms)
	
	update_all_sprites()
	update_all_transforms()

func disconnect_appearance_signals(old_appearance: Resource):
	if old_appearance.is_class("Squirrel_Appearance"):
		if old_appearance.updated_sprites.is_connected(update_all_sprites):
			old_appearance.updated_sprites.disconnect(update_all_sprites)
			
		if old_appearance.updated_transforms.is_connected(update_all_transforms):
			old_appearance.updated_transforms.disconnect(update_all_transforms)
