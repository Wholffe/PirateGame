extends Node2D

@export var minWaitTime = 2
@export var maxWaitTime = 5
@export var lookLeft = true
@export var damageValue = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	
	if(lookLeft == false):
		$AnimatedSprite2D.flip_h = true
		$FireEffect.position *= -1
		$FireEffect.flip_h = true
		
	while(true):
		randomize()
		var waitTimer = randi_range(minWaitTime,maxWaitTime)
		await get_tree().create_timer(waitTimer).timeout
		fire()

func fire():
	$FireEffect.visible = true
	$AnimatedSprite2D.play("fire")
	await  get_tree().create_timer(0.2).timeout
	$FireEffect.play("fireeffect")
	await  get_tree().create_timer(0.3).timeout
	$FireEffect.visible = false
	$AnimatedSprite2D.play("idle")
