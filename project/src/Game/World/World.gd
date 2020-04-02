extends Node2D

signal tree_cutted

onready var map : TileMap = $Map
onready var world_objects : Node = $YSort


func _ready() -> void:
	var characters = get_tree().get_nodes_in_group("character")
	
	map.world_objects = world_objects
	map.hide()
	
	for c in characters:
		c.tile_map = map
		map.set_cellv(map.world_to_map(c.position), c.type)
	
	map.connect("tree_cutted", self, "_on_tree_cutted")
	
	call_deferred("_count_trees")


func _on_tree_cutted() -> void:
	emit_signal("tree_cutted")


func count_trees() -> int:
	var trees_arr : Array = map.get_used_cells_by_id_in_map_range(map.TREE_ID)
	var trees_count := trees_arr.size()
	return trees_count
