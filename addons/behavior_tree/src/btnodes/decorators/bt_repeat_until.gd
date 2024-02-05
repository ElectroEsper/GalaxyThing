class_name BTRepeatUntil, "res://addons/behavior_tree/icons/btrepeatuntil.svg"
extends BTDecorator

# Repeats until specified state is returned, then sets state to child state

@export var until_what # (int, "Failure", "Success")
@export var frequency: float

@onready var expected_result = bool(until_what)



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = not expected_result
	
	while result != expected_result:
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = await result.completed
		
		await get_tree().create_timer(frequency, false).timeout
	
	return set_state(bt_child.state)
