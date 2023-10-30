extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animSprite = $AnimatedSprite2D

var hasSword = false

func _physics_process(delta):
	
	var swordExtra = "_nos"
	
	if(hasSword):
		swordExtra = "_hs"
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if(velocity.y > 0):
			animSprite.play("fall" + swordExtra)
		else:
			animSprite.play("jump" + swordExtra)
	else:
		if(velocity.x == 0):
			animSprite.play("idle" + swordExtra)
		else :
			animSprite.play("run" + swordExtra)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		# Prüfung, ob Character nach limks oder rechts geht und dann entsprechend Flip_h true/false
		if velocity.x < 0:
			animSprite.flip_h = true
		else:
			animSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
