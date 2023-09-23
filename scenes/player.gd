extends CharacterBody3D

@onready var player_sprite = $PlayerSprite

@onready var interactions = []
@onready var interact_popup = $InteractionComponents/InteractSprite

const SPEED = 3.6

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if input_dir.x != 0:
		player_sprite.flip_h = (input_dir.x == -1)

	move_and_slide()


# Interaction

func _on_interaction_area_area_entered(area):
	interact_popup.visible = true
	interactions.insert(0, area)


func _on_interaction_area_area_exited(area):
	interactions.erase(area)
	if !interactions:
		interact_popup.visible = false
