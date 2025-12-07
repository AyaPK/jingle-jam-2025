class_name MirrorItemEffect extends ItemEffect

func trigger() -> void:
	var demon = BattleManager.current_demon

	DialogPanel.push_text("You handed %s a small mirror" % demon.demon_name)

	if BattleManager.current_demon.internal_name in ["Pride"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Who is this gorgeous demon", demon)
	elif BattleManager.current_demon.internal_name in ["Greed", "Lust"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("I could use this.", demon)
	elif BattleManager.current_demon.internal_name in ["Wrath", "Gluttony", "Sloth"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("I've already got one of these", demon)
	elif BattleManager.current_demon.internal_name in ["Envy"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("What are you trying to say about me?", demon)
	
