# Copyright 2023 Team "BetaMax Heroes"
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# "InputCore.gd"
extends Node2D

var DelayAllUserInput

var KeyboardSpacebarPressed
var KeyboardEnterPressed
var KeyboardBackspacePressed

var KeyTypedOnKeyboard
var ShiftPressedOnKeyboard = false

const JoyCentered			= 0
const JoyUp				 	= 1
const JoyRight				= 2
const JoyDown				= 3
const JoyLeft				= 4
var JoystickDirection = []

const NotPressed			= 0
const Pressed				= 1
var JoyButtonOne = []
var JoyButtonTwo = []
var JoyButtonOneWasPressed = []
var JoyButtonTwoWasPressed = []

var JoyButtonOnePressedDuration = []
var JoyButtonOnePressedCounter = []

var ThereAreGamepads = false

var _GamepadsConnected = []

var JoyUpMapped = []
var JoyDownMapped = []
var JoyLeftMapped = []
var JoyRightMapped = []
var JoyButtonOneMapped = []
var JoyButtonTwoMapped = []

const JoyDPadUp					= 1
const JoyDPadDown				= 2
const JoyDPadLeft				= 3
const JoyDPadRight				= 4
const JoyAnalogVertical			= 5
const JoyAnalogHorizontal		= 6
const JoyButton0				= 7
const JoyButton1				= 8
const JoyButton2				= 9
const JoyButton3				= 10
const JoyButton4				= 11
const JoyButton5				= 12
const JoyButton6				= 13
const JoyButton7				= 14
const JoyButton8				= 15
const JoyButton9				= 16
const JoyButton10				= 17
const JoyButton11				= 18
const JoyButton12				= 19
const JoyButton13				= 20
const JoyButton14				= 21
const JoyButton15				= 22
const JoyButton16				= 23
const JoyButton17				= 24
const JoyButton18				= 25
const JoyButton19				= 26
const JoyButton20				= 27

var MouseButtonLeftPressed

var MouseScreenX
var MouseScreenY

var OldMusicVolume

const InputNone			= -1
const InputKeyboard		= 0
const InputMouse		= 1
const InputTouchOne		= 2
const InputTouchTwo		= 3
const InputJoyOne		= 4
const InputJoyTwo		= 5
const InputJoyThree		= 6
const InputCPU			= 7
const InputAny			= 8

var TouchTwoScreenX
var TouchTwoScreenY

var TouchTwoPressed

var InputThatStartedNewGame

#----------------------------------------------------------------------------------------
func _ready():
	set_process_input(true)
	
	DelayAllUserInput = 0
	
	KeyboardSpacebarPressed = false
	KeyboardEnterPressed = false

	var _warnErase = JoystickDirection.resize(9)
	_warnErase = JoyButtonOne.resize(9)
	_warnErase = JoyButtonOneWasPressed.resize(9)
	_warnErase = JoyButtonTwo.resize(9)
	_warnErase = JoyButtonTwoWasPressed.resize(9)

	_warnErase = JoyButtonOnePressedDuration.resize(10)
	for x in range(0, 10):
		JoyButtonOnePressedDuration[x] = []
		_warnErase = JoyButtonOnePressedDuration[x].resize(10)
		for y in range(0, 10):
			JoyButtonOnePressedDuration[x][y] = []

	for x in range(0, 10):
		for y in range(0, 10):
			JoyButtonOnePressedDuration[x][y] = 0

	_warnErase = JoyButtonOnePressedCounter.resize(10)
	for x in range(0, 10):
		JoyButtonOnePressedCounter[x] = []
		_warnErase = JoyButtonOnePressedCounter[x].resize(10)
		for y in range(0, 10):
			JoyButtonOnePressedCounter[x][y] = []

	for x in range(0, 10):
		for y in range(0, 10):
			JoyButtonOnePressedCounter[x][y] = 0

	for index in range(0, 9):
		JoystickDirection[index] = JoyCentered
		JoyButtonOne[index] = NotPressed
		JoyButtonOneWasPressed[index] = 0
		JoyButtonTwo[index] = NotPressed
		JoyButtonTwoWasPressed[index] = 0

	ThereAreGamepads = false
	for index in range(0, 4):
		if (Input.get_joy_name(index) != ""):
			ThereAreGamepads = true
	for index in range(0, 4):
		if (Input.get_joy_guid (index) != ""):
			ThereAreGamepads = true

#	_GamepadsConnected = Input.get_connected_joypads()

	if (Input.get_connected_joypads().size() > 0):  _GamepadsConnected = true
	else:  _GamepadsConnected = false


	_warnErase = JoyUpMapped.resize(9)
	for x in range(9):
		JoyUpMapped[x] = []
		_warnErase = JoyUpMapped[x].resize(1)
		for y in range(1):
			JoyUpMapped[x][y] = []

	_warnErase = JoyDownMapped.resize(9)
	for x in range(9):
		JoyDownMapped[x] = []
		_warnErase = JoyDownMapped[x].resize(1)
		for y in range(1):
			JoyDownMapped[x][y] = []

	_warnErase = JoyLeftMapped.resize(9)
	for x in range(9):
		JoyLeftMapped[x] = []
		_warnErase = JoyLeftMapped[x].resize(1)
		for y in range(1):
			JoyLeftMapped[x][y] = []

	_warnErase = JoyRightMapped.resize(9)
	for x in range(9):
		JoyRightMapped[x] = []
		_warnErase = JoyRightMapped[x].resize(1)
		for y in range(1):
			JoyRightMapped[x][y] = []

	_warnErase = JoyButtonOneMapped.resize(9)
	for x in range(9):
		JoyButtonOneMapped[x] = []
		_warnErase = JoyButtonOneMapped[x].resize(1)
		for y in range(1):
			JoyButtonOneMapped[x][y] = []

	_warnErase = JoyButtonTwoMapped.resize(9)
	for x in range(9):
		JoyButtonTwoMapped[x] = []
		_warnErase = JoyButtonTwoMapped[x].resize(1)
		for y in range(1):
			JoyButtonTwoMapped[x][y] = []

	for index in range(0, 9):
		JoyUpMapped[index][0] = JoyDPadUp
		JoyDownMapped[index][0] = JoyDPadDown
		JoyLeftMapped[index][0] = JoyDPadLeft
		JoyRightMapped[index][0] = JoyDPadRight
		JoyButtonOneMapped[index][0] = JoyButton0
		JoyButtonTwoMapped[index][0] = JoyButton1

	MouseButtonLeftPressed = false
	
	TouchTwoPressed = false

	pass

#----------------------------------------------------------------------------------------
func GetJoystickInputForMapping(index, _buttons):
	if (DelayAllUserInput > 0):
		return(-1)
	
	if (Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_UP) == true):
		return(JoyDPadUp)
	elif (Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_DOWN) == true):
		return(JoyDPadDown)
	elif (Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_LEFT) == true):
		return(JoyDPadLeft)
	elif (Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_RIGHT) == true):
		return(JoyDPadRight)

	elif (Input.get_joy_axis(index, JOY_AXIS_LEFT_Y) < -0.5):
		return(JoyAnalogVertical)
	elif (Input.get_joy_axis(index, JOY_AXIS_LEFT_Y) > 0.5):
		return(JoyAnalogVertical)
	elif (Input.get_joy_axis(index, JOY_AXIS_LEFT_X) < -0.5):
		return(JoyAnalogHorizontal)
	elif (Input.get_joy_axis(index, JOY_AXIS_LEFT_X) > 0.5):
		return(JoyAnalogHorizontal)

	for indexTwo in range(7, 28):
		if (Input.is_joy_button_pressed (index, indexTwo-7) == true):
			return(indexTwo)

	return(-1)

#	pass

#----------------------------------------------------------------------------------------
func _process(_delta):
	for index in range(0, 9):
		JoystickDirection[index] = JoyCentered
		JoyButtonOne[index] = NotPressed
		JoyButtonTwo[index] = NotPressed

	if DelayAllUserInput > -1:
		DelayAllUserInput-=1
		return

	if Input.is_action_pressed("KeyboardUp"):
		JoystickDirection[InputKeyboard] = JoyUp
	elif Input.is_action_pressed("KeyboardRight"):
		JoystickDirection[InputKeyboard] = JoyRight
	elif Input.is_action_pressed("KeyboardDown"):
		JoystickDirection[InputKeyboard] = JoyDown
	elif Input.is_action_pressed("KeyboardLeft"):
		JoystickDirection[InputKeyboard] = JoyLeft

	if (Input.is_action_pressed("ButtonOne")):
		if (ScreensCore.ScreenToDisplay != ScreensCore.NewHighScoreScreen):  JoyButtonOne[InputKeyboard] = Pressed
		InputThatStartedNewGame = InputKeyboard

	if (Input.is_action_pressed("ButtonTwo")):
		if (ScreensCore.ScreenToDisplay != ScreensCore.NewHighScoreScreen):  JoyButtonTwo[InputKeyboard] = Pressed

	for index in range (0, 3):
		if (JoyUpMapped[index][0] == JoyDPadUp && Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_UP) == true):
			JoystickDirection[InputJoyOne+index] = JoyUp
		elif (JoyDownMapped[index][0] == JoyDPadDown && Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_DOWN) == true):
			JoystickDirection[InputJoyOne+index] = JoyDown
		elif (JoyLeftMapped[index][0] == JoyDPadLeft && Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_LEFT) == true):
			JoystickDirection[InputJoyOne+index] = JoyLeft
		elif (JoyRightMapped[index][0] == JoyDPadRight && Input.is_joy_button_pressed (index, JOY_BUTTON_DPAD_RIGHT) == true):
			JoystickDirection[InputJoyOne+index] = JoyRight
		elif (JoyUpMapped[index][0] == JoyAnalogVertical && Input.get_joy_axis(index, JOY_AXIS_LEFT_Y) < -0.5):
			JoystickDirection[InputJoyOne+index] = JoyUp
		elif (JoyDownMapped[index][0] == JoyAnalogVertical && Input.get_joy_axis(index, JOY_AXIS_LEFT_Y) > 0.5):
			JoystickDirection[InputJoyOne+index] = JoyDown
		elif (JoyLeftMapped[index][0] == JoyAnalogHorizontal && Input.get_joy_axis(index, JOY_AXIS_LEFT_X) < -0.5):
			JoystickDirection[InputJoyOne+index] = JoyLeft
		elif (JoyRightMapped[index][0] == JoyAnalogHorizontal && Input.get_joy_axis(index, JOY_AXIS_LEFT_X) > 0.5):
			JoystickDirection[InputJoyOne+index] = JoyRight

		for indexThree in range(0, 10):
			if (JoyUpMapped[index][0] == JoyButton0+indexThree && Input.is_joy_button_pressed (index, JoyButton0-7+indexThree) == true):
				JoystickDirection[InputJoyOne+index] = JoyUp
			elif (JoyDownMapped[index][0] == JoyButton0+indexThree && Input.is_joy_button_pressed (index, JoyButton0-7+indexThree) == true):
				JoystickDirection[InputJoyOne+index] = JoyDown
			elif (JoyLeftMapped[index][0] == JoyButton0+indexThree && Input.is_joy_button_pressed (index, JoyButton0-7+indexThree) == true):
				JoystickDirection[InputJoyOne+index] = JoyLeft
			elif (JoyRightMapped[index][0] == JoyButton0+indexThree && Input.is_joy_button_pressed (index, JoyButton0-7+indexThree) == true):
				JoystickDirection[InputJoyOne+index] = JoyRight

		if (ScreensCore.ScreenToDisplay != ScreensCore.OptionsScreen):  JoyButtonOnePressedDuration[index][0] = 0

		if (ScreensCore.ScreenToDisplay != ScreensCore.OptionsScreen):
			if (Input.is_joy_button_pressed (index, JoyButtonOneMapped[index][0]-7) == true):
				JoyButtonOne[InputJoyOne+index]  = Pressed
				InputThatStartedNewGame = (InputJoyOne+index)
		elif (ScreensCore.ScreenToDisplay == ScreensCore.OptionsScreen):
			for indexTwo in range(0, 10):
				if (Input.is_joy_button_pressed (index, indexTwo) == true):
					JoyButtonOnePressedDuration[index][indexTwo]+=1
				elif (Input.is_joy_button_pressed (index, indexTwo) == false && JoyButtonOnePressedDuration[index][indexTwo] > 0):
					if (indexTwo == JOY_BUTTON_A):  JoyButtonOne[InputJoyOne+index]  = Pressed
					JoyButtonOnePressedCounter[index][indexTwo] = JoyButtonOnePressedDuration[index][indexTwo]
					JoyButtonOnePressedDuration[index][indexTwo] = 0

					if ((ThereAreGamepads == true or _GamepadsConnected == true or ScreensCore.OperatingSys == ScreensCore.OSHTMLFive) && JoyButtonOnePressedCounter[index][indexTwo] > 30):
						if (ScreensCore.JoystickSetupIndex == ScreensCore.JoySetupNotStarted):
							ScreensCore.ScreenToDisplayNext = ScreensCore.OptionsScreen
							ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
							ScreensCore.JoystickSetupIndex = ScreensCore.JoySetup1Up
				else:
					JoyButtonOnePressedCounter[index][indexTwo] = 0

		if (Input.is_joy_button_pressed (index, JoyButtonTwoMapped[index][0]-7) == true):
			JoyButtonTwo[InputJoyOne+index]  = Pressed

	for index in range (0, 8):
		if (JoystickDirection[index] != JoyCentered):
			JoystickDirection[InputAny] = JoystickDirection[index]

		if (JoyButtonOne[index] != NotPressed):
			JoyButtonOne[InputAny] = JoyButtonOne[index]

		if (JoyButtonTwo[index] != NotPressed):
			JoyButtonTwo[InputAny] = JoyButtonTwo[index]

	if Input.is_action_pressed("Shift"):
		ShiftPressedOnKeyboard = true
	else:
		ShiftPressedOnKeyboard = false

	if Input.is_action_pressed("Pause"):
		if (DelayAllUserInput < 1 && ScreensCore.ScreenToDisplay == ScreensCore.PlayingGameScreen):
			if (LogicCore.PAUSEgame == false):
				LogicCore.PAUSEgame = true
				LogicCore.PauseWasJustPressed = true

				OldMusicVolume = AudioCore.MusicVolume
				AudioCore.MusicPlayer.set_volume_db(AudioCore.ConvertLinearToDB(0.0))
			elif (LogicCore.PAUSEgame == true):
				LogicCore.PAUSEgame = false
				LogicCore.PauseWasJustPressed = true

				AudioCore.MusicVolume = OldMusicVolume
				AudioCore.MusicPlayer.set_volume_db(AudioCore.ConvertLinearToDB(AudioCore.MusicVolume))

			AudioCore.PlayEffect(1)
			DelayAllUserInput = 20
	elif Input.is_action_pressed("SeeEnding"):
		if (ScreensCore.ScreenToDisplay == ScreensCore.TitleScreen):
			ScreensCore.SeeEndingStaff = true
			ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack

	pass

 #----------------------------------------------------------------------------------------
func _unhandled_input(event):
	if DelayAllUserInput > -1:
		MouseButtonLeftPressed = false
		TouchTwoPressed = false
		MouseScreenX = -9999
		MouseScreenY = -9999
		TouchTwoScreenX = -9999
		TouchTwoScreenY = -9999
		return

	if ScreensCore.OperatingSys == ScreensCore.OSAndroid && ScreensCore.ScreenToDisplay == ScreensCore.PlayingGameScreen:
		if event is InputEventScreenDrag:
			var screenX = event.position.x
			for index in range(0, 2):
				if event.get_index() == index:
					if (screenX < VisualsCore.ScreenWidth/2.0):# Touch One
						MouseButtonLeftPressed = true
						MouseScreenX = event.position.x
						MouseScreenY = event.position.y
					elif (screenX > (VisualsCore.ScreenWidth/2.0)-1):# Touch Two
						TouchTwoPressed = true
						TouchTwoScreenX = event.position.x
						TouchTwoScreenY = event.position.y
		elif event is InputEventScreenTouch:
			if event.pressed == true:
				var screenX = event.position.x
				for index in range(0, 2):
					if event.get_index() == index:
						if (screenX < VisualsCore.ScreenWidth/2.0):# Touch One
							MouseButtonLeftPressed = true
							MouseScreenX = event.position.x
							MouseScreenY = event.position.y
						elif (screenX > (VisualsCore.ScreenWidth/2.0)-1.0):# Touch Two
							TouchTwoPressed = true
							TouchTwoScreenX = event.position.x
							TouchTwoScreenY = event.position.y

	pass

#----------------------------------------------------------------------------------------
func _input(event):
	KeyboardSpacebarPressed = false
	KeyboardEnterPressed = false
	KeyboardBackspacePressed = false

	KeyTypedOnKeyboard = "`"

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if (ScreensCore.ScreenToDisplay != ScreensCore.PlayingGameScreen):
			MouseButtonLeftPressed = false

		TouchTwoPressed = false
	elif (ScreensCore.ScreenToDisplay != ScreensCore.PlayingGameScreen):
		MouseButtonLeftPressed = false
		TouchTwoPressed = false

	if DelayAllUserInput > -1:
		MouseButtonLeftPressed = false
		TouchTwoPressed = false
		MouseScreenX = -9999
		MouseScreenY = -9999
		TouchTwoScreenX = -9999
		TouchTwoScreenY = -9999
		return false

	if ScreensCore.ScreenFadeStatus != ScreensCore.FadingIdle:  return false

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid || ScreensCore.VideoAndroid == true):
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				ScreensCore.ScreenToDisplayNext = ScreensCore.TitleScreen
				ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
				AudioCore.PlayEffect(1)
				AudioCore.PlayMusic(0)
			elif event.keycode == KEY_SPACE and event.pressed:
				KeyboardSpacebarPressed = true
				KeyTypedOnKeyboard = "_"
			elif event.keycode == KEY_ENTER and event.pressed:
				KeyboardEnterPressed = true
			elif event.keycode == KEY_BACKSPACE and event.pressed:
				KeyboardBackspacePressed = true

			if (event.pressed && event.keycode != KEY_SHIFT):
				if (event.unicode > 32 && event.unicode < 137):
					KeyTypedOnKeyboard = char(event.unicode)

		if event is InputEventMouseMotion:
			MouseScreenX = event.position.x
			MouseScreenY = event.position.y

		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if (event.is_pressed() == true):
					MouseButtonLeftPressed = true
					MouseScreenX = event.position.x
					MouseScreenY = event.position.y
					InputThatStartedNewGame = InputKeyboard
				else:
					MouseButtonLeftPressed = false

	if ScreensCore.OperatingSys == ScreensCore.OSAndroid && ScreensCore.ScreenToDisplay != ScreensCore.PlayingGameScreen:
		if event is InputEventScreenTouch:
			if event.pressed:
				MouseScreenX = event.position.x
				MouseScreenY = event.position.y
				MouseButtonLeftPressed = true
	else:
		if event is InputEventScreenDrag:
			var screenX = event.position.x
			for index in range(0, 2):
				if event.get_index() == index:
					if (LogicCore.Player == 1 && screenX < VisualsCore.ScreenWidth/2.0):# Touch One
						MouseButtonLeftPressed = true
						MouseScreenX = event.position.x
						MouseScreenY = event.position.y

					if (LogicCore.Player == 2 && screenX > (VisualsCore.ScreenWidth/2.0)-1.0):# Touch Two
						TouchTwoPressed = true
						TouchTwoScreenX = event.position.x
						TouchTwoScreenY = event.position.y
		elif event is InputEventScreenTouch:
			if event.pressed == true:
				var screenX = event.position.x
				for index in range(0, 2):
					if event.get_index() == index:
						if (LogicCore.Player == 1 && screenX < VisualsCore.ScreenWidth/2.0):# Touch One
							MouseButtonLeftPressed = true
							MouseScreenX = event.position.x
							MouseScreenY = event.position.y

						if (LogicCore.Player == 2 && screenX > (VisualsCore.ScreenWidth/2.0)-1.0):# Touch Two
							TouchTwoPressed = true
							TouchTwoScreenX = event.position.x
							TouchTwoScreenY = event.position.y
			else:
				MouseScreenX = -999
				TouchTwoScreenX = -999
	pass
