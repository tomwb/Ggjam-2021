extends Area2D

func _ready():
	pass
	
func destroy():
	$AnimatedSprite.play("collected")
	yield($AnimatedSprite,"animation_finished")
	queue_free()
	
