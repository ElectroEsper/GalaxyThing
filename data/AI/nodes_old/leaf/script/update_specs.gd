extends BehaviorTree

# UPDATE A FLEET'S SPECS

func tick(actor, blackboard):
	
	var wings = actor.wings_node.get_children()	
	var check_arr = blackboard.get("WINGS")
	
	if wings == check_arr:
		return FAILED
	
	#UPDATE WINGS
	for a in wings:
		if not a in blackboard.get("WINGS"):
			var bb_wings = blackboard.get("WINGS")
			bb_wings.append(a)
			blackboard.set("WINGS",bb_wings)
	
	#UPDATE SPEED
	var speed = 999
	for a in wings:
		if a.w_speed < speed:
			speed = a.w_speed
	
	#UPDATE ATK/DEF DICES
	for a in wings:
		match a.w_weapon:
			"STRIKE" :
				var dict = blackboard.get("ATK DICE")
				dict["STRIKE"] += 1
				blackboard.set("ATK DICE",dict)
			"LIGHT" :
				var dict = blackboard.get("ATK DICE")
				dict["LIGHT"] += 1
				blackboard.set("ATK DICE",dict)
			"MEDIUM" :
				var dict = blackboard.get("ATK DICE")
				dict["MEDIUM"] += 1
				blackboard.set("ATK DICE",dict)
			"HEAVY" :
				var dict = blackboard.get("ATK DICE")
				dict["HEAVY"] += 1
				blackboard.set("ATK DICE",dict)
			"SUPER" :
				var dict = blackboard.get("ATK DICE")
				dict["SUPER"] += 1
				blackboard.set("ATK DICE",dict)
		match a.w_armor:
			"STRIKE" :
				var dict = blackboard.get("DEF DICE")
				dict["FLAK"] += 1
				blackboard.set("DEF DICE",dict)
			"LIGHT" :
				var dict = blackboard.get("DEF DICE")
				dict["LIGHT"] += 1
				blackboard.set("DEF DICE",dict)
			"MEDIUM" :
				var dict = blackboard.get("DEF DICE")
				dict["MEDIUM"] += 1
				blackboard.set("DEF DICE",dict)
			"HEAVY" :
				var dict = blackboard.get("DEF DICE")
				dict["HEAVY"] += 1
				blackboard.set("DEF DICE",dict)
			"SUPER" :
				var dict = blackboard.get("DEF DICE")
				dict["SUPER"] += 1
				blackboard.set("DEF DICE",dict)
	 
	#print("SUCCESS")
	return SUCCESS

