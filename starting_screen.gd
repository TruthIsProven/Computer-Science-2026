extends Control
# Comment comment


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/newgame_scene.tscn")
	pass # Replace with function body.



func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_settiings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings_scene.tscn")
	pass # Replace with function body.
