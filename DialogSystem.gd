extends Node

onready var dialogBox = $DialogBox
onready var sfx = $DialogSFX
onready var delayTimer = $DelayTimer

var interupted = false
var running = false

var dialogQueue = []


func play_dialog(text, volume, pitch, delay):
	sfx.volume_db = volume
	sfx.pitch_scale = pitch
	
	if running:
		dialogQueue.append({"text": text, "volume": volume, "pitch": pitch, "delay": delay})
		return
		
	dialogBox.text = ""
	
	for character in text:
		running = true
		if interupted:
			break
			
			
		dialogBox.text += character
		if character in " .,'\"":
			continue
			
		delayTimer.start(delay)
			
		#TODO: Play sound
		yield(delayTimer, "timeout")
		
	running = false
	if len(dialogQueue) > 0:
		var qParams = dialogQueue[0]
		dialogQueue.pop_front()
		play_dialog(qParams.text, qParams.volume, qParams.pitch, qParams.delay) 

