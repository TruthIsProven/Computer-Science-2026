extends Control


const WIKI_FILE_PATH := "res://entries/entries.json" #unchangeable value

@onready var rich_label: RichTextLabel = \
	$"MarginContainer2/MarginContainer3/MarginContainer3-1/RichTextLabel"


var wiki_articles: Dictionary = {}


func _ready() -> void: #Function that calls the designated article in the JSON file through the article number labelled with the button
	load_wiki_articles() #call the loading article/wiki file function

	if wiki_articles.has("article_1"): #starting from article one and match the same numbered article to the same title in the JSON file
		open_article("article_1")


func load_wiki_articles() -> void:#function that loads the designated articles and show error message when the JSON file is not found

	var file := FileAccess.open(WIKI_FILE_PATH, FileAccess.READ)

	var json_text := file.get_as_text()
	file.close()

	var json := JSON.new()
	var _parse_result := json.parse(json_text)
	
	wiki_articles = json.data

	print("Loaded ", wiki_articles.size(), " wiki articles.")


func open_article(article_id: String) -> void: #Get the different part of the article and show error message when not found

	var article: Dictionary = wiki_articles[article_id]

	var title: String = article.get("title", "Untitled Article")
	var description: String = article.get(
		"description",
		"No description is available."
	)
	var traits: Array = article.get("traits", [])
	var recommended_action: String = article.get(
		"recommended_action",
		"No recommended action is available."
	)

	var page_text := "" #Stylize the fonts (size, font) and formatting on a wiki page

	page_text += "[font_size=40][b]"
	page_text += title
	page_text += "[/b][/font_size]\n"

	page_text += "\n[font_size=30][b]Description[/b][/font_size]\n"
	page_text += "[font_size=18]"
	page_text += description
	page_text += "[/font_size]"
	page_text += "\n\n"

	page_text += "[font_size=30][b]Traits[/b][/font_size]\n"

	for sign_text in traits:
		page_text += "[font_size=18]"
		page_text += str(sign_text) + "\n"
		page_text += "[/font_size]"

	page_text += "\n"
	page_text += "[font_size=30][b]Recommended Action[/b][/font_size]\n"
	page_text += recommended_action

	rich_label.text = "[center]" + page_text + "[/center]"


func _on_button_1_pressed() -> void:
	open_article("article_1")


func _on_button_2_pressed() -> void:
	open_article("article_2")


func _on_button_3_pressed() -> void:
	open_article("article_3")


func _on_button_4_pressed() -> void:
	open_article("article_4")


func _on_button_5_pressed() -> void:
	open_article("article_5")


func _on_button_6_pressed() -> void:
	open_article("article_6")


func _on_button_7_pressed() -> void:
	open_article("article_7")


func _on_button_8_pressed() -> void:
	open_article("article_8")


func _on_button_9_pressed() -> void:
	open_article("article_9")

func _on_button_10_pressed() -> void:
	open_article("article_10")


func _on_exitbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/desktop_scene.tscn")
	pass # Replace with function body.
