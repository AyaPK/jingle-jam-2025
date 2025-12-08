extends Sprite2D

# Shake parameters
var shake_intensity = 0.0
var shake_decay = 5.0  # How quickly shake fades
var original_position = Vector2.ZERO

func _ready():
	Signals.battle_demon_insult_dealt.connect(shake)
	# Store the original position so we can return to it
	original_position = position

func _process(delta):
	# Apply shake if intensity is above 0
	if shake_intensity > 0:
		# Random offset based on intensity
		position = original_position + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		
		# Decay the shake over time
		shake_intensity -= shake_decay * delta
		shake_intensity = max(shake_intensity, 0)
	else:
		# Reset to original position when shake is done
		position = original_position

func shake():
	"""
	Start a shake effect
	intensity: How strong the shake is (pixels)
	duration: If > 0, overrides decay for this shake
	"""
	shake_intensity = 5.0
