extends Button

enum FEAR{
	calm,
	agitated,
	anxious,
	panicking
}

var fearLevel = FEAR.calm setget set_fearLevel
var animationDelay = [0, 0]
var animationSet = []


func set_fearLevel(newFearLevel):
	fearLevel = newFearLevel
	
	#TODO: Expand to represent dynamic changes
	match fearLevel:
		
		FEAR.calm:
			animationDelay = [0, 0]
			animationSet = []
			$AnimationTimer.stop()
		
		FEAR.anxious:
			animationDelay = [0.2, 1]
			animationSet = ["agitated01", "agitated02", "agitated03", "agitated04", "agitated05"]
			
			play_rand_animation()
			
		FEAR.agitated:
			animationSet = ["agitated01", "agitated02", "agitated03", "agitated04", "agitated05"]
			animationDelay = [1, 2]
			if $AnimationTimer.time_left == 0:
				play_rand_animation()
			
			
func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationTimer.start(rand_range(animationDelay[0], animationDelay[1]))

func _on_AnimationTimer_timeout():		
	play_rand_animation()

func play_rand_animation():
	if len(animationSet) == 0:
		return
	$AnimationPlayer.play(animationSet[randi()%len(animationSet)])
