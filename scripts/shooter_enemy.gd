extends CharacterBody2D

var Laser = preload("res://scenes/laser_2.tscn")

var player = null
var canshoot = true

@onready var Spawnpos = $Spawnlaser

@export var speed = 2

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _physics_process(delta):
	var movement = Vector2 (0, speed)
	
	if player:
		movement = position.direction_to(player.position) * speed
	
	movement = move_and_collide(movement)

func _on_shootspeed_timeout():
	canshoot = true
	if player != null:
		shoot()

func shoot():
	if canshoot:
		var laser = Laser.instance()
		laser.position = Spawnpos.global_position
		get_parent().add_child(laser)
		
		$Shootspeed.start()
		canshoot = false
