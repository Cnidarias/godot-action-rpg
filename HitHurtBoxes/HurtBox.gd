extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var invincibility_timer = $InvincibilityTimer

signal invincibility_start
signal invincibility_end


func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_start")
	else:
		emit_signal("invincibility_end")


func start_invinciblity(duration):
	self.invincible = true
	invincibility_timer.start(duration)


func create_hit_effect():
	var hit_effect = HitEffect.instance()
	var current_scene = get_tree().current_scene
	current_scene.add_child(hit_effect)
	hit_effect.global_position = global_position


func _on_InvincibilityTimer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_start():
	set_deferred("monitorable", false)


func _on_HurtBox_invincibility_end():
	monitorable = true
