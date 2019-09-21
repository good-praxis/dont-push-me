extends Node

onready var dialogBox = $DialogBox
onready var sfx = $DialogSFX

var interupted = false
var running = false

var dialogQueue = []


func play_dialog(text, delay=.8, postDelay=0, volume=-25, pitch=1.5):
	sfx.volume_db = volume
	sfx.pitch_scale = pitch
	
	if running:
		dialogQueue.append({"text": text, "delay": delay,  "postDelay": postDelay, "volume": volume, "pitch": pitch})
		return
		
	dialogBox.text = ""
	
	for character in text:
		running = true
		if interupted:
			interupted = false
			break
			
			
		dialogBox.text += character
		if character in " .,'\"!?":
			continue
			
		sfx.play()
		yield(get_tree().create_timer(delay), "timeout")
		
		if postDelay > 0:
			yield(get_tree().create_timer(postDelay), "timeout")

		
	running = false
	if len(dialogQueue) > 0:
		var qParams = dialogQueue[0]
		dialogQueue.pop_front()
		play_dialog(qParams.text, qParams.delay, qParams.postDelay, qParams.volume, qParams.pitch)
		
func interupt(with_empty_queue = false):
	if with_empty_queue:
		empty_queue()
	if running:
		interupted = true
	
func empty_queue():
	dialogQueue = []
	

