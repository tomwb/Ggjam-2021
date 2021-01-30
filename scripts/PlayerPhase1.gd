extends KinematicBody2D

enum {
	IDLE, WALK, HIT, EVOLVE
}

export var max_speed = 300
export var hit_speed = 50
var acceleration_time = 0.05
var acceleration = Vector2()
var status = IDLE
var last_collision_direction = Vector2()

func _ready():
	$AnimatedSprite.play("idle")
	pass

func _physics_process(delta):
	var direction = Vector2()
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction = direction.normalized()
	
#	caso o player sair e voltar pra parede bate denovo
	if last_collision_direction.x != 0 && direction.x != 0 && last_collision_direction.x == direction.x:
		last_collision_direction = Vector2()
	if last_collision_direction.y != 0 && direction.y != 0 && last_collision_direction.y == direction.y:
		last_collision_direction = Vector2()
	
	walk(direction, delta)
	hit(delta)
	animations()
	
func walk(direction,delta):
	if status == WALK || status == IDLE:
		
		if direction.x != 0 || direction.y != 0 :
			status = WALK
		else:
			status = IDLE
			
		acceleration.x = lerp(acceleration.x, max_speed * direction.x, acceleration_time)
		acceleration.y = lerp(acceleration.y, max_speed * direction.y, acceleration_time)
				
		var collision = move_and_collide(acceleration * delta)
		if (direction.x !=0 || direction.y != 0) && collision:
			acceleration = Vector2()
			last_collision_direction = collision.normal
			$AudioHit.play()
			status = HIT
			# quando a animação acabar
			$AnimatedSprite.play("hit")
			$AnimationLightMask.play("show")
			yield($AnimatedSprite,"animation_finished")
			status = IDLE
				
func hit(delta):
	if status == HIT:
		move_and_collide(last_collision_direction * hit_speed * delta)
	
func animations():
	if status == WALK:
		$AnimatedSprite.play("walk")
	elif status == IDLE :
		$AnimatedSprite.play("idle")


func _on_CollectorArea2D_area_entered(area):
	if area.is_in_group("MemoryItem") :
		area.queue_free()
		$AnimatedSprite.play("evolve")
		$AnimationLightMask.play("finish")
		status = EVOLVE
