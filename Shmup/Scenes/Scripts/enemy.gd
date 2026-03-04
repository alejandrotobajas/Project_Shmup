extends Area2D
var speed = 50

var ExplosionScene = preload("res://Scenes/Explosion.tscn")

# Escena del proyectil enemigo
var EnemyProjectileScene = preload("res://Scenes/enemy_projectile.tscn")

# Temporizador interno de disparo
var shoot_timer = 1.5

# Tiempo entre disparos (puedes ajustarlo)
var shoot_cooldown = 1.5

var can_shoot = false

var was_on_screen = false

func _process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)
	position.y += sin(position.x * delta) *0.4
	
	if can_shoot:
		shoot_timer -= delta
		# Si el tiempo llega a 0, dispara
	if shoot_timer <= 0:
		shoot()
		shoot_timer = shoot_cooldown


# Función que crea el disparo
func shoot():
	
	# Instanciamos el proyectil
	var projectile = EnemyProjectileScene.instantiate()
	
	# Lo colocamos en la posición del enemigo
	projectile.global_position = global_position
	
	# Lo añadimos a la escena
	get_parent().add_child(projectile)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerProjectile"):
		explode()
		
	if area.is_in_group("Player"):
		explode()


func explode():
		var explosion = ExplosionScene.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	can_shoot = true
	was_on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
		if was_on_screen:   
			queue_free()
