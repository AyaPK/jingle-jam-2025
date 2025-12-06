class_name DaggerItemEffect extends ItemEffect

func trigger() -> void:
	var demon_name = BattleManager.current_demon.demon_name
	var demon = BattleManager.current_demon
	DialogPanel.push_text("You gave the dagger to "+demon_name)
	if demon.internal_name in ["Wrath"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("For me? I could do so much crime with this!", demon)
	elif demon.internal_name in ["Greed", "Lust", "Pride"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("I suppose I could make use of this...", demon)
	elif demon.internal_name in ["Gluttony", "Sloth"]:
		BattleManager.demon_seduction -= 20
		DialogPanel.push_text("What am I supposed to do with a dagger?", demon)
	elif demon.internal_name in ["Envy"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("Are you trying to make me want this? NO way!!!", demon)
