extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")


export(bool) var show_hit_effect = true


func _on_HurtBox_area_entered(area):
	if show_hit_effect:
		var hit_effect = HitEffect.instance()
		var current_scene = get_tree().current_scene
		current_scene.add_child(hit_effect)
		hit_effect.global_position = global_position
