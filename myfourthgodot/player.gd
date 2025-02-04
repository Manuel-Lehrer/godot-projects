extends CharacterBody3D

const SPEED = 15.0
const JUMP_VELOCITY = 4.5
const LANE_DISTANCE = 2.5  
var coin_counter = 0

var target_x = 0.0  
var gravity = ProjectSettings.get("physics/3d/default_gravity")

func _ready() -> void:
	target_x = global_transform.origin.x

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.z = -SPEED  

	# Handle lane switching
	if Input.is_action_just_pressed("ui_left"):
		target_x -= LANE_DISTANCE
	elif Input.is_action_just_pressed("ui_right"):
		target_x += LANE_DISTANCE
	
	global_transform.origin.x = target_x

	move_and_slide()


func set_count(new_coin_count:int) -> void:
	coin_counter = new_coin_count
