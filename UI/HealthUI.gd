extends Control


const HEART_SIZE = 15

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heart_ui_full = $HeartUIFull
onready var heart_ui_empty = $HeartUIEmpty


func _ready():
	PlayerStats.connect("health_changed", self, "set_hearts")
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heart_ui_full != null:
		heart_ui_full.rect_size.x = hearts * HEART_SIZE


func set_max_hearts(value):
	max_hearts = max(value, 1)
	if heart_ui_empty != null:
		heart_ui_empty.rect_size.x = max_hearts * HEART_SIZE
