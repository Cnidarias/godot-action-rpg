extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const MoneyScene  = preload("res://scenes/Interactables/Money.tscn") 

func create_grass_effect():
	var grass_effect = GrassEffect.instance()
	get_parent().add_child(grass_effect)
	grass_effect.global_position = global_position
	

func random_money_generation(chance):
	if randf() < chance:
		var money_instance = MoneyScene.instance()
		get_parent().add_child(money_instance)
		money_instance.global_position = global_position
		


func _on_HurtBox_area_entered(_area):
	create_grass_effect()
	random_money_generation(0.5)
	queue_free()
