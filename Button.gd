extends Button

enum FEAR_INDEX {
	calm = -1,
	agitated = 30,
	anxious = 70,
	panicking = 90
}

var fearLevel = 0
var fearDpt = -0.2 setget set_fearZone

onready var animationPlayer = $AnimationPlayer

signal isAgitated
signal isAnxious
signal isPanicking

var animationSet = ["idle01"]


func set_fearZone(newFearZone):
	match newFearZone:
		
		FEAR_INDEX.calm:
			fearDpt = -0.2
		
		
		FEAR_INDEX.agitated:
			emit_signal("isAgitated")
			fearDpt = 0.1
			if fearLevel < 30:
				fearLevel += 30

			
		FEAR_INDEX.anxious:
			emit_signal("isAnxious")
			fearDpt = 0.3
			if fearLevel < 70:
				fearLevel = 70
			
			play_rand_animation()
			
		FEAR_INDEX.panicking:
			emit_signal("isPanicking")
			fearDpt = 1
			if fearLevel < 90:
				fearLevel = 90
			
			play_rand_animation()
			
			
func _on_AnimationPlayer_animation_finished(_anim_name):
	
	
	animationPlayer.playback_speed = 1 # default
	if fearLevel >= FEAR_INDEX.panicking:
		animationSet = ["agitated02"]
		animationPlayer.playback_speed = 2.5
	elif fearLevel >= FEAR_INDEX.anxious:
		animationSet = ["agitated01", "agitated02"]
		animationPlayer.playback_process_mode = 1.7
	elif fearLevel >= FEAR_INDEX.agitated:
		animationSet = ["agitated01"]
	else:
		animationSet = ["idle01"]
	
	play_rand_animation()
	fearLevel += fearDpt
	normalizeFearLevel()




func normalizeFearLevel():
	fearLevel = fearLevel if fearLevel < 100 and fearLevel > 0 else 100 if fearLevel >= 100 else 0 

func play_rand_animation():
	animationPlayer.play(animationSet[randi()%len(animationSet)])
