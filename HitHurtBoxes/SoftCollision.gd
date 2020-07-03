extends Area2D


func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 


func get_push_vector():
	if !is_colliding():
		return Vector2.ZERO
	return get_overlapping_areas()[0].global_position.direction_to(global_position)
	
