extends Node3D

@export var tiles: Array[PackedScene]
@export var title_length = 20.0
@export var tile_rim = 5.0

var current_tile_center = 10
var current_tile: Node3D
var last_tile: Node3D

func spawn_next() -> Node3D:
	var tile_node = tiles.pick_random().instantiate()
	add_child(tile_node)
	current_tile_center -= title_length
	tile_node.position.z = current_tile_center
	return tile_node
	
func kill_tile(tile:Node3D):
	remove_child(tile)
	tile.queue_free()
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_next()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.position.z < current_tile_center - title_length / 2 + tile_rim:
		if last_tile != null:
			kill_tile(last_tile)
		last_tile = current_tile
		spawn_next()
		current_tile = spawn_next()
