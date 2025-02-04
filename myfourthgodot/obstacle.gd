extends Area3D


func _process(delta):
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":	
		GlobalCanvasLayer.show_death_screen()
