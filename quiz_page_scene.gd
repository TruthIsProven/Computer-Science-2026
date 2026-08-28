extends Node2D


func _on_button_11_pressed() -> void:
	$MarginContainer/Start_button.visible = false
	$"Incoming Call".visible = true
	pass # Replace with function body.



func _on_pickup_call_pressed() -> void:
	$"Incoming Call".visible = false
	
	pass # Replace with function body.
