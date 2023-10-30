extends Node2D

@export
var hp = 5

func checkDestroy():
	hp -= 1
	if(hp <= 0):
		$AnimatedSprite2D.play("destroyed")
		$GPUParticles2D.emitting = true
		await  get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.visible = false
		await  get_tree().create_timer(0.3).timeout
		queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	if(area.is_in_group("FromPlayer")):
		$AnimatedSprite2D.play(("hit"))
		checkDestroy()
