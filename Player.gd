extends CharacterBody3D
@onready var body = $SophiaSkin
signal update_gem( jems :int )

var jem :int = 0
const SPEED = 5.0				# スピード
const JUMP_VELOCITY = 4.5		# ジャンプ力
const TURN_SPEED = 2.5			# 回転速度
var windlift_velocity :Vector3	# 上昇する力
var push_velocity :Vector3		# 押される力

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	
	rotate_y( -input_dir.x * TURN_SPEED * delta )
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	velocity += windlift_velocity * delta	# 上昇する力を加える
	windlift_velocity *= 0.9				# 力を徐々に弱くする
	if windlift_velocity.length() < 0.1:	# ベクトルの長さがほぼ０なら
		windlift_velocity = Vector3.ZERO	# ベクトルを０にする
	
	position += push_velocity * delta		# 押す力を加える
	push_velocity *= 0.9					# 力を徐々に弱くする
	if push_velocity.length() < 0.1:		# ベクトルの長さがほぼ０なら
		push_velocity = Vector3.ZERO		# ベクトルを０にする

	#加速度を反映
	move_and_slide()
	
	#アニメーションの設定
	if is_on_floor():	# 床にいるとき
		if velocity == Vector3.ZERO:	# 移動していない
			body.idle()
		else:							# 移動している
			body.move()
	else:				# 空中にいる時
		if velocity.y > 0:
			body.jump()
		if velocity.y < 0:
			body.fall()
	
	#if is_on_wall_only() and velocity.y < 0:
		#body.wall_slide()
		
	if push_velocity:
		body.fall()
		

# エリアに他のエリアが侵入
func _on_area_3d_area_entered(_area):
	hit_and_restart()


func hit_and_restart():
	hide()	# かくす
	await get_tree().create_timer(1.0).timeout	# 1秒まつ
	position = Vector3( 0,1,0 )	# 場所リセット
	show()	# 表示
	
func wind_lift( liftForce :float ):
	windlift_velocity = Vector3.UP * liftForce
	
# スプリングに押される
func spring_force( pushVelocity: Vector3 ):
	push_velocity = pushVelocity

func get_gem():
	jem += 1
	update_gem.emit(jem)








