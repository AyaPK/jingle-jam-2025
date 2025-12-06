extends TextureProgressBar

func _ready():
	Signals.battle_single_turn.connect(_on_battle_turn_end)

func _on_battle_turn_end():
	value = float(BattleManager.demon_hp) / BattleManager.current_demon.hp
