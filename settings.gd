extends Control


func _on_exitbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Starting Screen.tscn")
	pass # Replace with function body.


func _on_check_button_toggled(toggled_on: bool):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.
