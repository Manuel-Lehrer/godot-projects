extends Camera3D

@export var player : CharacterBody3D  # Reference to the player node
@export var offset : Vector3 = Vector3(0, 5, -10)  # Adjust the offset for the camera's position

func _process(delta: float) -> void:
	# Keep the camera's x position constant, but follow the player in y and z
	transform.origin.x = player.transform.origin.x + offset.x
	transform.origin.y = player.transform.origin.y + offset.y
