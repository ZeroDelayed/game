extends Area2D


@onready var anim = get_node("AnimatedSprite2D")



func _on_body_entered(body):
	if body.name == "Player":
		Game.playerHP += 1
		if Game.playerHP > 3:
			Game.playerHP = 3
		queue_free()
	


func _on_idle_body_entered(body):
	if body.name == "Player":
		anim.play("idle")
