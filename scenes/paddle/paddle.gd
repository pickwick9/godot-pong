extends CharacterBody2D


const SPEED: float = 300.0
@export var side: String = "left" # default

@onready var rally_count = $ui/counters/rally_count

##################################################

func _physics_process(delta):

    assert( side == "left" or side == "right" )

    if side == "left":
        if Input.is_key_pressed(KEY_W):
            velocity.y = -SPEED
        elif Input.is_key_pressed(KEY_S):
            velocity.y = SPEED
        else:
            velocity.y = 0

    else:
        if Input.is_key_pressed(KEY_UP):
            velocity.y = -SPEED
        elif Input.is_key_pressed(KEY_DOWN):
            velocity.y = SPEED
        else:
            velocity.y = 0

    move_and_slide()

##################################################

func _on_area_2d_body_entered(body):
    body.direction.x *= -1
    body.SPEED *= 1.05
    get_node("/root/Main/ui/counters/rally_count").text = str(int(get_node("/root/Main/ui/counters/rally_count").text) + 1)
    get_node("/root/Main/audio/paddle_collision").play()

