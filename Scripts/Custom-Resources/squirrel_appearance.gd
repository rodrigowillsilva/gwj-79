extends Resource
class_name Squirrel_Appearance

@export_category("Base Characteristics")
@export var base: Squirrel_Base_Textures
@export_range(0.4, 1.4) var body_size: float = 1

@export_enum ("Simple", "Beady", "Cartoony", "Creepy", "Oblivious", "Dead", "Closed", "Red") var eye_texture: int
@export_range(0.2, 2.0) var eye_size: float = 1
@export_group("Eye Offset")
@export var eye_offset_X: float = 0
@export var eye_offset_Y: float = 0
@export_group("")

@export_enum ("Simple", "Bushy", "Extra Bushy", "Fine", "Cartoony", "Distinguished", "Rough", "None") var eyebrow_texture: int
@export_range(0.3, 2.0) var eyebrow_size: float = 1
@export_group("Eyebrow Offset")
@export var eyebrow_offset_X: float = 0
@export var eyebrow_offset_Y: float = 0
@export_group("")

@export_category("Accessories")
@export_enum ("Crown", "Top Hat", "Flowers", "Turd", "Sprout", "Artistic", "Bow", "None") var hat_texture: int

@export_enum ("Scarf", "Necktie", "Badge", "Belt", "Necklace", "Jabot", "Bow", "None") var accessory_texture: int
@export_group("Accessory Offset")
@export var accessory_offset_X: float = 0
@export var accessory_offset_Y: float = 0
@export_group("")

@export_enum ("Sword", "Hammer", "Boquet", "Scepter", "Potion", "Scroll", "Sack", "None") var held_R_texture: int
@export_group("Held Object Offset (Right Hand)")
@export var object_R_offset_X: float = 0
@export var object_R_offset_Y: float = 0
@export_group("")
@export_enum ("Sword", "Hammer", "Boquet", "Scepter", "Potion", "Scroll", "Sack", "None") var held_L_texture: int
@export_group("Held Object Offset (Left Hand)")
@export var object_L_offset_X: float = 0
@export var object_L_offset_Y: float = 0
