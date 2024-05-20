extends Node3D
@onready var swing_node = $Hanging_Hammer_05

var max_range :float = 90.0	# スイングの範囲（度）
var speed :float = 5.0		# スイングの速度（度/秒）
var offset :float = 0.0		# スイングの距離


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += speed * delta	#揺れた距離
	var sin_val = sin(offset)	# -1.0から1.0の値に変換
	var swing_amount = sin_val * max_range	# MAXの角度
	swing_node.rotation_degrees.z = swing_amount	# 度で代入
