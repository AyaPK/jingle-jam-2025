class_name PlushieItemEffect extends ItemEffect

func trigger() -> void:
	var demon = BattleManager.current_demon

	DialogPanel.push_text("You gave %s a cute teddy bear" % demon.demon_name)

	if BattleManager.current_demon.internal_name in ["Sloth"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Thanks buddy. This is great.", demon)
	elif BattleManager.current_demon.internal_name in ["Envy", "Lust"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("What a flirt.", demon)
	elif BattleManager.current_demon.internal_name in ["Wrath"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Oh, I'm definitely going to tear this to pieces later", demon)
	elif BattleManager.current_demon.internal_name in ["Pride", "Greed"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("You really think I'd enjoy this", demon)
	elif BattleManager.current_demon.internal_name in ["Gluttony"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("This is tiny. Awful...", demon)
	
