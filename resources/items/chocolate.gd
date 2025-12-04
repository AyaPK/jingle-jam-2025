class_name ChocolateEffect extends ItemEffect

func trigger() -> void:
	DialogPanel.push_text("You used the chocolate!")
	var demon = BattleManager.current_demon
	if BattleManager.current_demon.demon_name in ["Gluttony"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Oh! I love chocolate!", demon)
	elif BattleManager.current_demon.demon_name in ["Lust", "Sloth", "Greed"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Thanks.", demon)
	elif BattleManager.current_demon.demon_name in ["Wrath", "Envy"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("I'm not a fan of chocolate.", demon)
	elif BattleManager.current_demon.demon_name in ["Pride"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("oh! Ew ew ew! No way! Too fattening!", demon)
	
