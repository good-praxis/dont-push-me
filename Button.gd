extends Button

enum FEAR{
	calm,
	agitated,
	anxious,
	panicking
}

var fearLevel = FEAR.calm setget set_fearLevel
var animationDelay = [0.2, 1]
var animationSet = []

func set_fearLevel(newFearLevel):
	fearLevel = newFearLevel
	
	#TODO: Expand to represent dynamic changes
	match fearLevel:
		FEAR.anxious:
			animationSet = ["agitated01", "agitated02", "agitated03", "agitated04", "agitated05"]
			play_rand_animation()
			
			
func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationTimer.start(rand_range(animationDelay[0], animationDelay[1]))

func _on_AnimationTimer_timeout():
	if len(animationSet) < 1:
		pass
		
	play_rand_animation()

func play_rand_animation():
	$AnimationPlayer.play(animationSet[randi()%len(animationSet)])
