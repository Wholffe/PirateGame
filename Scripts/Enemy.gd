extends CharacterBody2D

@export var enemySpeed = 150.0
@export var enemyHP = 3
@export var enemyDamage = 1

const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var playerInDamageZone = false
var enemyDirection = 1
var isDead = false

func _ready():
	checkStatus()

func run():
	$AnimatedSprite2D.play("run")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if(!isDead):
		if is_on_wall():
			if(enemyDirection == -1):
				enemyDirection = 1
				$AnimatedSprite2D.flip_h = true
			else:
				enemyDirection = -1
				$AnimatedSprite2D.flip_h = false
			
		velocity.x = enemyDirection * enemySpeed
		move_and_slide()

func attack():
	if(!isDead):
		enemyDirection = 0
		$AnimatedSprite2D.play("standing")
		await get_tree().create_timer(0.5).timeout
		if(playerInDamageZone and !isDead):
			$AnimatedSprite2D.play("attack")
			Global.playerDamage(enemyDamage)
			await get_tree().create_timer(0.2).timeout
			enemyDirection = 1
		else:
			enemyDirection = 1

func kill_enemy():
	isDead = true
	enemyDirection = 0
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("dead")
	await get_tree().create_timer(10).timeout
	queue_free()
	
func checkStatus():
	if(enemyHP <= 0):
		kill_enemy()
	else:
		if(playerInDamageZone):
			attack()
		else:
			run()

#HIT THE ENEMY
func _on_area_2d_area_entered(area):
	if(!isDead and area.is_in_group("FromPlayer")):
		enemyHP -= 1
		enemyDirection = 0
		$AnimatedSprite2D.play("hit")
		await get_tree().create_timer(1).timeout
		enemyDirection = 1
		checkStatus()

#HIT THE PLAYER
func _on_area_2d_body_entered(body):
	if(!isDead and body.is_in_group("Player")):
		playerInDamageZone = true
		checkStatus()

func _on_area_2d_body_exited(body):
	if(!isDead and body.is_in_group("Player")):
		playerInDamageZone = false
		checkStatus()
