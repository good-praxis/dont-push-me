extends Node

onready var button = $UI/Button


func _on_PersonalSpace_mouse_entered():
	button.set_fearLevel(button.FEAR.agitated)


func _on_InnerSpace_mouse_entered():
	button.set_fearLevel(button.FEAR.anxious)
	


func _on_FreeMovementSpace_mouse_entered():
	button.set_fearLevel(button.FEAR.calm)


func _on_Button_mouse_entered():
	button.set_fearLevel(button.FEAR.panicking)
