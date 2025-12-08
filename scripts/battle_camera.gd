extends Camera2D

# Shake parameters
var shake_intensity = 0.0
var shake_decay = 5.0  # How quickly shake fades

func _ready():
	Signals.battle_demon_did_damage.connect(shake)

func _process(delta):
	# Apply shake if intensity is above 0
	if shake_intensity > 0:
		# Random offset based on intensity
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		
		# Decay the shake over time
		shake_intensity -= shake_decay * delta
		shake_intensity = max(shake_intensity, 0)
	else:
		# Reset offset when shake is done
		offset = Vector2.ZERO

func shake():
	"""
	Start a camera shake effect
	intensity: How strong the shake is (pixels)
	duration: If > 0, overrides decay for this shake
	"""
	shake_intensity = 5.0
