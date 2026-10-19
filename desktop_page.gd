extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://quiz_page_scene.tscn")
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	$Settings.visible = true
	pass # Replace with function body.


func _on_exitbutton_pressed() -> void:
	$Settings.visible = false
	$"User Manual".visible = false
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	$"User Manual".visible = true
	pass # Replace with function body.
