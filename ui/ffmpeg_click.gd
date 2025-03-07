extends RichTextLabel

func _ready():
	if OS.get_name() == "Linux":
		text = """[center]Once it finishes it will open the output folder with the images it made.
		Run ff.sh (Probably have to make executable) in that folder.
You probably already have ffmpeg installed, but you can figure it out if you don't.
[/center]"""
	else:
		text = """[center]Once it finishes it will open the output folder with the images it made.
Download ffmpeg (release-essentials.zip)
 [url]https://www.gyan.dev/ffmpeg/builds/[/url] 
Direct link to zip:
[url]https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip[/url]
 And put ffmpeg.exe (from the bin folder in the zip) into the output folder, then run ff.bat[/center]"""

func _on_meta_clicked(meta: Variant) -> void:
	OS.shell_open( meta )
