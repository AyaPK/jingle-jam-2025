extends TextureProgressBar

func _ready():
	Signals.battle_single_turn.connect(_on_battle_turn_end)

func _on_battle_turn_end():
	value = float(PlayerManager.hp) / PlayerManager.MAX_HP
