extends KinematicBody2D

const EnemeyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var KNOCK_BACK_FRICTION = 200
export var KNOCK_BACK_INIT = 120

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 80

var velocity = Vector2.ZERO
var knock_back = Vector2.ZERO

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

onready var stats = $Stats
onready var player_detection_zone = $PlayerDetectionZone
onready var sprite = $Sprite
onready var hurt_box = $HurtBox
onready var soft_collision = $SoftCollision


func _physics_process(delta):
	knock_back = knock_back.move_toward(Vector2.ZERO, KNOCK_BACK_FRICTION * delta)
	knock_back = move_and_slide(knock_back)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * 200)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = player_detection_zone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE
	
	velocity += soft_collision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knock_back = area.knock_back_vector * KNOCK_BACK_INIT
	hurt_box.create_hit_effect()


func _on_Stats_no_health():
	var enemey_death_effect = EnemeyDeathEffect.instance()
	get_parent().add_child(enemey_death_effect)
	enemey_death_effect.global_position = global_position
	queue_free()
