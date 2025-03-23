extends Button

@onready var fill_pattern: ColorRect = self.get_node("fill-pattern")
@onready var fill_color: ColorRect = self.get_node("fill-color")

@onready var original_fill_color: Color = fill_color.color


func _ready():
	not_hovering()
	
	self.mouse_entered.connect(hovering)
	self.mouse_exited.connect(not_hovering)
	
func hovering():
	fill_pattern.visible = true
	fill_color.color = original_fill_color
	
func not_hovering():
	fill_pattern.visible = false
	fill_color.color.v = original_fill_color.v * 0.5
