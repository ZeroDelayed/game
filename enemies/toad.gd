extends CharacterBody2D

var SPEED = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta):
	#Gravity for Frog
	velocity.y += gravity * delta
	if chase == true:
		if anim.animation != "death":
			anim.play("movement")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if anim.animation != "death":
			anim.play("idle")
		velocity.x = 0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func death():
	Game.Gold += 7
	Utils.saveGame()
	chase = false
	anim.play("death")
	await anim.animation_finished
	self.queue_free()

func _on_toad_death_body_entered(body):
	if body.name == "Player":
		Game.toadHP -= 1
		if Game.toadHP == 0:
			death()
func _on_player_death_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 1
