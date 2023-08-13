extends Area2D

@export var damage : int = 5

# deals damage to player when enemy and player collide
func _on_body_entered(body):
	for child in body.get_children():
		if child is PlayerDamageable:
			child.hit(damage, Vector2.LEFT)
