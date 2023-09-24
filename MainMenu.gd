extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/treehouse_interior.tscn")


func _on_credits_button_pressed():
	print("Credits")


func _on_quit_button_pressed():
	get_tree().quit()
