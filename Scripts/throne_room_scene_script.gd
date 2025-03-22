extends Node3D

func _ready():
	pass
	
func spawn_squirrel(parent: Node, appearance: Squirrel_Appearance, spawn_location: Vector3, spawn_rotation: Vector3 = Vector3.ZERO, spawn_scale: Vector3 = Vector3.ONE) -> NodePath:
	var squirrel_scene = preload("res://Scenes/squirrel.tscn")
	var new_squirrel: squirrel_character = squirrel_scene.instantiate()
	parent.add_child(new_squirrel)
	
	new_squirrel.sprite_controller.change_appearance(appearance)
	
	new_squirrel.position = spawn_location
	new_squirrel.rotation = spawn_rotation
	new_squirrel.scale = spawn_scale
	
	return new_squirrel.get_path()
