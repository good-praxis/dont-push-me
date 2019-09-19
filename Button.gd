extends Button

enum FEAR{
	calm,
	agitated,
	anxious,
	panicking
}

var fearLevel = FEAR.calm setget set_fearLevel

var animationSet = []


func set_fearLevel(newFearLevel):
	fearLevel = newFearLevel
	
	#TODO: Expand to represent dynamic changes
	match fearLevel:
		
		FEAR.calm:
			animationSet = []
		
		
		FEAR.agitated:
			$AnimationPlayer.playback_speed = 1
			animationSet = ["agitated01", "agitated02"]
			
			play_rand_animation()
			
		FEAR.anxious:
			animationSet = ["agitated02", "agitated03", "agitated04", "agitated05"]
			
			$AnimationPlayer.playback_speed = 1.7
			animationSet = ["agitated01", "agitated02"]
			
			play_rand_animation()
			
		FEAR.panicking:
			animationSet = ["agitated02"]
			$AnimationPlayer.playback_speed = 2.5
			
			play_rand_animation()
			
			
func _on_AnimationPlayer_animation_finished(_anim_name):
	play_rand_animation()


func play_rand_animation():
	if len(animationSet) == 0:
		return
	$AnimationPlayer.play(animationSet[randi()%len(animationSet)])
