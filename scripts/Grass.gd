extends Node2D


func create_grass_effect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn")
	var grass_effect = GrassEffect.instance()
	
	var world_scene = get_tree().current_scene
	world_scene.add_child(grass_effect)
	grass_effect.global_position = global_position


func _on_HurtBox_area_entered(area):
	create_grass_effect()
	queue_free()
