extends ColorRect

signal finished()

var idx = -5

var running = false

func _ready() -> void:
	get_window().files_dropped.connect( update_texture )
	
func update_texture( files ):
	var file = files[0]
	var texture = ImageTexture.create_from_image( Image.load_from_file( file ) )
	material.set_shader_parameter( "cover", texture )

func _process(delta: float) -> void:
	take_screenshot()

func take_screenshot():
	if running and idx > 0 and idx <= 300:
		var capture = get_viewport().get_texture().get_image()
		var filename = "user://frame-%04d.png" % idx
		capture.save_png( filename )
	if idx == 301 and running:
		finished.emit()
		running = false
	
	idx += 1
	var m = ShaderMaterial
	material.set_shader_parameter( "current_time", idx / 60.0  )
