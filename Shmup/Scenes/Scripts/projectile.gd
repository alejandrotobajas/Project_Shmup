extends Area2D
var speed = 1000
func _process(delta: float) -> void:
	translate(Vector2.UP * speed * delta)

# Cuando colisiona con el Area2D del enemigo
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
