extends KinematicBody2D

enum {
	IDLE, WALK, HIT, EVOLVE
}

export var speed = 100
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
	animations()
	
func walk(direction,delta):
	if status == WALK || status == IDLE:
		
		if direction.x != 0 || direction.y != 0 :
			status = WALK
		else:
			status = IDLE
		
		var collision  = move_and_collide(direction * speed * delta)
		if (direction.x !=0 || direction.y != 0) && collision:
			if last_collision_direction != collision.normal:
				last_collision_direction = collision.normal
				status = HIT
				# daqui a 4 segundos volta pro idle
				var t = get_tree().create_timer(2.5)
				yield(t,"timeout")
				status = IDLE
	
func animations():
	if status == WALK:
		$AnimatedSprite.play("walk")
	elif status == HIT:
		$AnimatedSprite.play("hit")
	else :
		$AnimatedSprite.play("idle")
