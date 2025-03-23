@tool
extends Resource
class_name Squirrel_Appearance

signal updated_sprites
signal updated_transforms
signal updated_name

@export_category("Base Characteristics")
@export var base: Squirrel_Base_Textures:
	set(val):
		base = val
		_update_sprites()
@export_range(0.4, 1.4) var body_size: float = 1:
	set(val):
		body_size = val
		_update_transforms()

@export_enum ("Simple", "Beady", "Cartoony", "Creepy", "Oblivious", "Dead", "Closed", "Red") var eye_texture: int:
	set(val):
		eye_texture = val
		_update_sprites()
@export_range(0.2, 2.0) var eye_size: float = 1:
	set(val):
		eye_size = val
		_update_transforms()
@export var eye_offset: Vector2 = Vector2.ZERO:
	set(val):
		eye_offset = val
		_update_transforms()

@export_enum ("Simple", "Bushy", "Extra Bushy", "Fine", "Cartoony", "Distinguished", "Rough", "None") var eyebrow_texture: int:
	set(val):
		eyebrow_texture = val
		_update_sprites()
@export_range(0.3, 2.0) var eyebrow_size: float = 1:
	set(val):
		eyebrow_size = val
		_update_transforms()
@export var eyebrow_offset: Vector2 = Vector2.ZERO:
	set(val):
		eyebrow_offset = val
		_update_transforms()

@export_category("Accessories")
@export_enum ("Crown", "Top Hat", "Flowers", "Turd", "Chef's Hat", "Artistic", "Bow", "NONE") var hat_texture: int:
	set(val):
		hat_texture = val
		_update_sprites()

@export_enum ("Scarf", "Necktie", "Badge", "Belt", "Necklace", "Jabot", "Bow", "?", "NONE") var accessory_texture: int:
	set(val):
		accessory_texture = val
		_update_sprites()
@export var accessory_offset: Vector2 = Vector2.ZERO:
	set(val):
		accessory_offset = val
		_update_transforms()

@export_enum ("Sword", "Hammer", "Boquet", "Scepter", "Potion", "Scroll", "Sack","Quill", "Duster", "Cleaver", "Magic Wand", "Rag", "Acorn", "Basket", "?", "None") var held_r_texture: int:
	set(val):
		held_r_texture = val
		_update_sprites()
@export var object_r_offset: Vector2 = Vector2.ZERO:
	set(val):
		object_r_offset = val
		_update_transforms()
@export_enum ("Sword", "Hammer", "Boquet", "Scepter", "Potion", "Scroll", "Sack","Quill", "Duster", "Cleaver", "Magic Wand", "Rag", "Acorn", "Basket", "?", "None") var held_l_texture: int:
	set(val):
		held_l_texture = val
		_update_sprites()
@export var object_l_offset: Vector2 = Vector2.ZERO:
	set(val):
		object_l_offset = val
		_update_transforms()

@export_category("Save Appearance")
const save_location: String = "res://Audio-Visual/Character-Appearances/"
@export var save_name: String = "MagicSquirrelTheFourth":
	set(val):
		save_name = val
		_update_name(val)

@export_tool_button("Save", "Callable") var save_action = save_modified_appearance

func _update_sprites():
	updated_sprites.emit()
	
func _update_transforms():
	updated_transforms.emit()
	
func _update_name(new_name):
	updated_name.emit(new_name)

func save_modified_appearance():
	var save_to: String = (save_location + save_name + ".tres")
	ResourceSaver.save(self, save_to)
	print("Squirrel " + save_name + " saved to: " + save_to)
