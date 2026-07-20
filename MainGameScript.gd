extends Control

# 1. Reference the RichTextLabel node
@onready var rich_label: RichTextLabel = $"MarginContainer2/MarginContainer3/MarginContainer3-1/RichTextLabel"

func _on_button_1_pressed() -> void:
	# 2. Change the text property directly
	rich_label.text = "Hello World!" 
	

func _on_button_2_pressed() -> void:
	
	rich_label.text = "Hello World!2" 


func _on_button_3_pressed() -> void:
	rich_label.text = "Hello World!3" 


func _on_button_4_pressed() -> void:
	rich_label.text = "Hello World!4" 


func _on_button_5_pressed() -> void:
	rich_label.text = "Hello World!5" 


func _on_button_6_pressed() -> void:
	rich_label.text = "Hello World!6" 


func _on_button_7_pressed() -> void:
	rich_label.text = "Hello World!7" 


func _on_button_8_pressed() -> void:
	rich_label.text = "Hello World!8" 


func _on_button_9_pressed() -> void:
	#comment
	rich_label.text = "Hello World!9" 


func _on_button_10_pressed() -> void:
	rich_label.text = "Hello World!10" 
