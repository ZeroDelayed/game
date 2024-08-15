extends Area2D

@onready var anim = get_node("AnimatedSprite2D")

func teleport():
	Utils.saveGame()
	if Game.bossKills >= 1 or Game.Gold >= 40:
		get_tree().change_scene_to_file("res://worlds/game_won.tscn")
func _on_body_entered(body):
	if body.name == "Player":
		teleport()
	
func _on_idle_body_entered(body):
	if body.name == "Player":
		anim.play("idle")
