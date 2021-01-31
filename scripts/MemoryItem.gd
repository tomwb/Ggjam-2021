extends Area2D

func _ready():
	pass
	
func destroy():
	$AudioStreamPlayer.play()
	$AnimatedSprite.play("collected")
	yield($AnimatedSprite,"animation_finished")
	queue_free()
	
