extends Area2D

# Velocidad del disparo enemigo
var speed = 500

var was_on_screen = false

func _process(delta):
	# Mueve el proyectil hacia abajo (dirección del jugador)
	translate(Vector2.DOWN * speed * delta)

# Cuando el proyectil entra en contacto con otra Area2D
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		queue_free()
		

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	was_on_screen = true   # Marcamos que ya estuvo visible


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if was_on_screen:      # Solo se destruye si ya estuvo visible
		queue_free()
