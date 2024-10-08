extends Node2D

var directionLeft = true
var pSpeed = 5
var damage = 1
var canMove = true
var range = 500
var startX = 0
var lookLeft = true
var projectiletype = Global.projectileTypes.CANNON

# Called when the node enters the scene tree for the first time.
func _ready():
	startX = self.position.x
	if(lookLeft == false):
		$AnimatedSprite2D.flip_h = true
		
	if(projectiletype == 0):
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("idle_wood")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canMove):
		if (directionLeft):
			self.position.x -= pSpeed
			if(startX - self.position.x > range):
				canMove = false
				explode()
		else:
			self.position.x += pSpeed
			if(self.position.x - startX > range):
				canMove = false
				explode()

func explode():
	if(projectiletype == 0):
		$AnimatedSprite2D.play("explosion")
		$canonExplosion.play()
	else:
		$AnimatedSprite2D.play("destroy_wood")
		$woodDestroy.play()
	await get_tree().create_timer(0.3).timeout
	$AnimatedSprite2D.visible = false
	$Area2D/CollisionShape2D.disabled = true
	await get_tree().create_timer(3).timeout
	queue_free()

# HIT Player
func _on_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		canMove = false
		explode()
		Global.playerDamage(damage)
