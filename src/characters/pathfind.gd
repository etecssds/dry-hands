extends Node

var astar = AStarGrid2D.new()
var grid_size = Vector2i(16, 16)

func setup_grid(layers: Array[TileMapLayer]) -> void:
	if layers.is_empty():
		return
		
	# 1. Calcula o tamanho total do mapa somando todas as camadas
	var total_rect: Rect2i = layers[0].get_used_rect()
	for layer in layers:
		total_rect = total_rect.merge(layer.get_used_rect())
		
	astar.region = total_rect
	astar.cell_size = grid_size
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	# 2. Varre todas as camadas e bloqueia qualquer tile que tenha colisão
	for layer in layers:
		# Verifica se o TileSet dessa camada tem alguma camada de física configurada
		if layer.tile_set == null or layer.tile_set.get_physics_layers_count() == 0:
			continue
			
		for cell in layer.get_used_cells():
			var data = layer.get_cell_tile_data(cell)
			if data and data.get_collision_polygons_count(0) > 0:
				astar.set_point_solid(cell, true)



func get_grid_path(start_pos: Vector2, target_pos: Vector2) -> Array[Vector2i]:
	var start_cell = Vector2i((start_pos / 16).floor())
	var target_cell = Vector2i((target_pos / 16).floor())
	
	if not astar.is_in_boundsv(target_cell) or astar.is_point_solid(target_cell):
		return []
		
	return astar.get_id_path(start_cell, target_cell)
