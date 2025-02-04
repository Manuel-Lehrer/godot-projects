extends Area3D

const ROT_SPEED = 0.3

func _process(delta):
	rotate_y(deg_to_rad(ROT_SPEED))

func _on_body_entered(body: Node3D) -> void:
	CoinUi.add_coin()
	queue_free()
