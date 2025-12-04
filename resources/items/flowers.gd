class_name FlowersItemEffect extends ItemEffect

func trigger() -> void:
	var demon_name = BattleManager.current_demon.demon_name
	DialogPanel.push_text("You gave the Flowers to "+demon_name)
	if demon_name in ["Envy"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Envy: They're nearly as pretty as you :)")
	elif demon_name in ["Lust", "Sloth", "Pride"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text(demon_name+": Thanks.")
	elif demon_name in ["Gluttony", "Wrath"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text(demon_name+": I can't really use these.")
	elif demon_name in ["Greed"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text(demon_name+": So you give me a temporary gift? This is what you think of me?")
