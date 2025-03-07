extends ColorPickerButton

@export var manager : ColorRect
@export var shader_param : String

func _ready() -> void:
	color_changed.connect( update_colour )
	
func update_colour( c : Color ):
	manager.material.set_shader_parameter( shader_param, c  )
