extends Node3D

@export var speed = 15
@export var rot_speed = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, Godot")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var h = speed * delta
	if Input.is_key_pressed(KEY_UP):
		position.x -= h * sin(rotation.y)
		position.z -= h * cos(rotation.y)
	if Input.is_key_pressed(KEY_DOWN):
		position.x += h * sin(rotation.y)
		position.z += h * cos(rotation.y)
	if Input.is_key_pressed(KEY_LEFT):
		rotation.y += rot_speed * delta
	if Input.is_key_pressed(KEY_RIGHT):
		rotation.y -= rot_speed * delta
