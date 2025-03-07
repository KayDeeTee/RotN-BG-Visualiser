extends Button

@export var manager : ColorRect
@export var ui_base : Panel

func _ready() -> void:
	manager.finished.connect( on_finish )

func on_finish():
	ui_base.visible = true
	var path = ProjectSettings.globalize_path("user://")
	OS.shell_open(path)

func _pressed() -> void:
	ui_base.visible = false
	manager.idx = -5
	manager.running = true
