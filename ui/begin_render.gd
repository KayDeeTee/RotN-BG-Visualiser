extends Button

@export var manager : ColorRect
@export var ui_base : Panel

func _ready() -> void:
	manager.finished.connect( on_finish )

func on_finish():
	ui_base.visible = true
	var path = ProjectSettings.globalize_path("user://")	
	OS.shell_open(path)
	
	if OS.get_name() == "Linux":
		var file_text = "ffmpeg -framerate 30 -pattern_type glob -i '*.png' -c:v libvpx -c:a libvorbis -b:v 20M out.webm"
		var fa = FileAccess.open( path+"/ff.sh", FileAccess.WRITE )
		fa.store_string(file_text)
	else: #windows
		var file_text = "ffmpeg.exe -framerate 30 -pattern_type sequence -i 'frame-%04d.png' -c:v libvpx -c:a libvorbis -b:v 20M out.webm"
		var fa = FileAccess.open( path+"/ff.bat", FileAccess.WRITE )
		fa.store_string(file_text)

func _pressed() -> void:
	ui_base.visible = false
	manager.idx = -5
	manager.running = true
