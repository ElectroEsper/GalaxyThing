class_name BTRepeat, "res://addons/behavior_tree/icons/btrepeat.svg"
extends BTDecorator

# Executes child "iterations" times and returns the last state and tick result
 
@export var times_to_repeat: int = 1 # (int, 0, 999)
@export var frequency: float



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result
	
	for i in times_to_repeat:
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = await result.completed
	
		await get_tree().create_timer(frequency, false).timeout
	
	return set_state(bt_child.state)
