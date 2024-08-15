extends CharacterBody2D


var SPEED = 78
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta):
	#Gravity for Frog
	velocity.y += gravity * delta
	
	if chase == true:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.y < 0:
			anim.play("run")
		if direction.x > 0:
			anim.flip_h = false
		else:
			anim.flip_h = true
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
	Utils.saveGame()
	chase = false
	anim.play("death")
	await anim.animation_finished
	self.queue_free()
	
	Game.bossKills += 1
	if Game.bossKills >= 1:
		get_tree().change_scene_to_file("res://worlds/after_boss.tscn")
	
	
func _on_boss_death_body_entered(body):
	if body.name == "Player":
		Game.bossHP -= randf_range(1, 10)
		if Game.bossHP <= 0:
			death()
			
			
	
func _on_player_death_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 2
		
