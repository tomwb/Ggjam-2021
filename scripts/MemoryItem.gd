extends Area2D

signal collected_animation_finished

func _ready():
	pass
	
func destroy():
	$AudioStreamPlayer.play()
	$AnimatedSprite.play("collected")
	yield($AnimatedSprite,"animation_finished")
	emit_signal("collected_animation_finished")
	queue_free()
	
