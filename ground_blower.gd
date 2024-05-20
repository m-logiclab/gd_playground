extends Node3D
@onready var fan = $Gound_Blower_01/Gound_Blower_01_Fan
@onready var area_3d = %Area3D
var rotate_speed :float = 0.0
var lift_force :float = 15.0
var hit_character :Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_3d.body_entered.connect( _on_area_3d_body_entered )
	area_3d.body_exited.connect( func(_body): hit_character = null )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hit_character:
		rotate_speed *= 1.05
		if hit_character.has_method("wind_lift"):
			hit_character.wind_lift( lift_force )
	else:
		rotate_speed *= 0.95
	
	rotate_speed = clamp( rotate_speed, 0, 10)
	fan.rotate_y(rotate_speed * delta)


func _on_area_3d_body_entered( body ):
	hit_character = body
	rotate_speed = 1.0
	
	
