extends Node2D

var score_p1: int = 0
var score_p2: int = 0

var is_paused: bool = false
var speed: float

# game objects
@onready var ball = $game_objects/ball
@onready var paddle_left = $game_objects/paddle_left
@onready var paddle_right = $game_objects/paddle_right

# ui
@onready var p1_score = $ui/counters/p1_score
@onready var p2_score = $ui/counters/p2_score
@onready var rally_count = $ui/counters/rally_count
@onready var pause_menu = $ui/pause_menu

# audio
@onready var top_bottom_collision_sound = $audio/top_bottom_collision
@onready var player_scores_sound = $audio/player_scores

##################################################

func handle_collisions_left_right(body):
    # reset game state (except for player scores)
    body.global_position = Vector2(0, 0)
    body.SPEED = 150.0
    body.direction.x = [-1, 1].pick_random()
    body.direction.y = [-1, 1].pick_random()
    rally_count.text = str(0)
    # play score sound
    player_scores_sound.play()

func handle_collisions_top_bottom(body):
    if body.name == "ball":
        # bounce the ball
        body.direction.y *= -1
        # play collision sound
        top_bottom_collision_sound.play()

##################################################

func _on_left_body_entered(body):
    handle_collisions_left_right(body)
    score_p2 += 1
    p2_score.text = str(score_p2)

func _on_right_body_entered(body):
    handle_collisions_left_right(body)
    score_p1 += 1
    p2_score.text = str(score_p1)

func _on_top_body_entered(body):
    handle_collisions_top_bottom(body)

func _on_bottom_body_entered(body):
    handle_collisions_top_bottom(body)

##################################################

func _process(delta):
    if Input.is_action_just_pressed("pause"):
        if is_paused:
            # set is_paused to false and hide pause menu
            is_paused = false
            pause_menu.visible = false
            # unfreeze ball
            ball.SPEED = speed
        else:
            # store speed
            speed = ball.SPEED
            # freeze ball
            ball.SPEED = 0.0
            # show pause menu and set is_paused to true
            pause_menu.visible = true
            is_paused = true

func _on_unpause_pressed():
    # set is_paused to false and hide pause menu
    is_paused = false
    pause_menu.visible = false
    # unfreeze ball
    ball.SPEED = speed

func _on_restart_pressed():
    # set is_paused to false and hide pause menu
    is_paused = false
    pause_menu.visible = false
    # reset game state
    paddle_left.position.y = 0
    paddle_right.position.y = 0
    ball.global_position = Vector2(0, 0)
    ball.SPEED = 150.0
    ball.direction.x = [-1, 1].pick_random()
    ball.direction.y = [-1, 1].pick_random()
    p1_score.text = str(0)
    p2_score.text = str(0)
    rally_count.text = str(0)

func _on_quit_pressed():
    get_tree().quit()

