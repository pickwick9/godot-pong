extends CharacterBody2D

var SPEED: float = 150.0
var direction: Vector2 = Vector2.ZERO

func _ready():
    direction.x = [-1, 1].pick_random()
    direction.y = [-1, 1].pick_random()

func _physics_process(delta):
    velocity = direction * SPEED
    move_and_slide()

