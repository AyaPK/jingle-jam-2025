class_name FlowersItemEffect extends ItemEffect

func trigger() -> void:
	var demon_name = BattleManager.current_demon.demon_name
	var demon = BattleManager.current_demon
	DialogPanel.push_text("You gave the Flowers to "+demon_name)
	if demon_name in ["Envy"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("They're nearly as pretty as you :)", demon)
	elif demon_name in ["Lust", "Sloth", "Pride"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Thanks.", demon)
	elif demon_name in ["Gluttony", "Wrath"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("I can't really use these.", demon)
	elif demon_name in ["Greed"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("So you give me a temporary gift? This is what you think of me?", demon)
