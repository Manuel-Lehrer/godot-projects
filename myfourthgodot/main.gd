extends Node3D

@export var tiles: Array[PackedScene]
@export var tile_length = 20.0
@export var tile_rim = 15.0
@export var max_tiles = 5 
@export var spawn_offset = 10.0 


var current_tile_center = 10
var active_tiles = [] 

func spawn_next():
	var tile_node = tiles.pick_random().instantiate()
	add_child(tile_node)
	current_tile_center -= tile_length
	tile_node.position.z = current_tile_center
	active_tiles.append(tile_node)
	

	if active_tiles.size() > max_tiles:
		var old_tile = active_tiles.pop_front()
		kill_tile(old_tile)

func kill_tile(tile: Node3D):
	remove_child(tile)
	tile.queue_free()

func _ready() -> void:
	for i in range(max_tiles):
		spawn_next()

func _process(delta: float) -> void:
	if $Player.position.z < current_tile_center - tile_length / 2 + tile_rim + spawn_offset:
		spawn_next()
		
