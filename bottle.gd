extends RigidBody2D

var on_area : bool
var held : bool = false
var mouse_pressed = false
var mouse_offset
var has_seed : bool = false
var plant
var previous_velocity = 0
var previous_wiggle = 0.0
var screen_size

func _ready() -> void:
    screen_size= get_viewport_rect().size

func _process(delta):
    var velocity = Input.get_last_mouse_velocity()
    var wiggle = deg_to_rad(velocity.y - previous_velocity/800)*delta
    previous_velocity = velocity.y
    
    if held:
        var new_position = get_global_mouse_position() + mouse_offset
        new_position = new_position.clamp(Vector2.ZERO, screen_size)
        move_and_collide(new_position - global_transform.origin)

        rotation = lerp(0.0,wiggle,.5)
        previous_wiggle = wiggle
        
        if Input.is_action_just_pressed("mouse_left") or\
            Input.is_action_just_pressed("mouse_right"):
            held = false
            velocity = 0
            $CollisionShape2D.disabled=false
            $pot_picked.visible = false
            $pot_onfloor.visible = true
        
    elif on_area && Input.is_action_just_pressed("mouse_left"):
            held = true
            mouse_offset = global_transform.origin - get_global_mouse_position()
            $CollisionShape2D.disabled=false #we use move and collide kasi
            $pot_picked.visible = true #tmp
            $pot_onfloor.visible = false #temp
            $pot_picked2.play()