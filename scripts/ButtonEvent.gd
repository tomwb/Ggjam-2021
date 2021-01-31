extends Area2D

var is_off = false setget set_is_off

signal is_off_pressed

func _ready():
	pass
	
func set_is_off(value):
	is_off = value
	if (value == true):
		emit_signal("is_off_pressed")
		$AnimatedSprite.play("off")
	else :
		$AnimatedSprite.play("on")
