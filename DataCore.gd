# Copyright 2023 "BetaMax Hero"
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

# "DataCore.gd"
extends Node2D

var HighScoreName = []
var HighScoreLevel = []
var HighScoreScore = []

var PlayerWithHighestScore
var NewHighScoreRank

const FILE_NAME = "user://TetriStory-3_0_0_4e-game-data.json"

#----------------------------------------------------------------------------------------
func CheckForNewHighScore():
	PlayerWithHighestScore = 0

	if (LogicCore.Score[1] > LogicCore.Score[0]):
		PlayerWithHighestScore = 1
	
	if (LogicCore.Score[2] > LogicCore.Score[1]):
		PlayerWithHighestScore = 2

	NewHighScoreRank = 999
	for index in range(9, -1, -1):
		if (LogicCore.Score[PlayerWithHighestScore] > HighScoreScore[LogicCore.GameMode][index]):
			NewHighScoreRank = index

	if (LogicCore.PlayerInput[PlayerWithHighestScore] == InputCore.InputCPU):
		return

	if (NewHighScoreRank == 999):
		return

	for index in range(9, NewHighScoreRank, -1):
		HighScoreName[LogicCore.GameMode][index] = HighScoreName[LogicCore.GameMode][index-1]
		HighScoreLevel[LogicCore.GameMode][index] = HighScoreLevel[LogicCore.GameMode][index-1]
		HighScoreScore[LogicCore.GameMode][index] = HighScoreScore[LogicCore.GameMode][index-1]

	HighScoreName[LogicCore.GameMode][NewHighScoreRank] = " "
	HighScoreLevel[LogicCore.GameMode][NewHighScoreRank] = LogicCore.Level
	HighScoreScore[LogicCore.GameMode][NewHighScoreRank] = LogicCore.Score[PlayerWithHighestScore]

	pass

#----------------------------------------------------------------------------------------
func ClearHighScores():
	for mode in range(0, 6):
		HighScoreName[mode][0] = "JeZxLee"
		HighScoreName[mode][1] = "Daotheman"
		HighScoreName[mode][2] = "theweirdn8"
		HighScoreName[mode][3] = "mattmatteh"
		HighScoreName[mode][4] = "Oshi Bobo"
		HighScoreName[mode][5] = "D.J. Fading Twilight"
		HighScoreName[mode][6] = "Godot Engine"
		HighScoreName[mode][7] = "You"
		HighScoreName[mode][8] = "Them"
		HighScoreName[mode][9] = "Us"

		HighScoreLevel[mode][0] = 10
		HighScoreLevel[mode][1] = 9
		HighScoreLevel[mode][2] = 8
		HighScoreLevel[mode][3] = 7
		HighScoreLevel[mode][4] = 6
		HighScoreLevel[mode][5] = 5
		HighScoreLevel[mode][6] = 4
		HighScoreLevel[mode][7] = 3
		HighScoreLevel[mode][8] = 2
		HighScoreLevel[mode][9] = 1

		HighScoreScore[mode][0] = 10000
		HighScoreScore[mode][1] = 9000
		HighScoreScore[mode][2] = 8000
		HighScoreScore[mode][3] = 7000
		HighScoreScore[mode][4] = 6000
		HighScoreScore[mode][5] = 5000
		HighScoreScore[mode][6] = 4000
		HighScoreScore[mode][7] = 3000
		HighScoreScore[mode][8] = 2000
		HighScoreScore[mode][9] = 1000
	pass

#----------------------------------------------------------------------------------------
func LoadOptionsAndHighScores():
#	var player
#	var file = File.new()
#	if file.file_exists(FILE_NAME):
#		file.open(FILE_NAME, File.READ)
#		var data = parse_json(file.get_as_text())
#		file.close()
#		if typeof(data) == TYPE_DICTIONARY:
#			player = data
#		else:
#			printerr("Corrupted data!")
#			return false
#	else:
#		printerr("No saved data!")
#		return false
#
#	AudioCore.MusicVolume = player.MusicVolumeValue
#	AudioCore.EffectsVolume = player.EffectsVolumeValue
#	LogicCore.GameMode = player.GameModeValue
#	LogicCore.AllowComputerPlayers = player.AllowComputerPlayers
#	LogicCore.GameSpeed = player.GameSpeedValue
#	HighScoreName = player.HighscoreNameValue
#	HighScoreLevel = player.HighScoreLevelValue
#	HighScoreScore = player.HighScoreScoreValue
#	LogicCore.SecretCode = player.SecretCode
#	VisualsCore.KeepAspectRatio = player.KeepAspectRatio
#	InputCore.JoyUpMapped = player.JoyUpMapped
#	InputCore.JoyDownMapped = player.JoyDownMapped
#	InputCore.JoyLeftMapped = player.JoyLeftMapped
#	InputCore.JoyRightMapped = player.JoyRightMapped
#	InputCore.JoyButtonOneMapped = player.JoyButtonOneMapped
#	InputCore.JoyButtonTwoMapped = player.JoyButtonTwoMapped
#
#	LogicCore.SecretCodeCombined = (LogicCore.SecretCode[0]*1000)+(LogicCore.SecretCode[1]*100)+(LogicCore.SecretCode[2]*10)+(LogicCore.SecretCode[3]*1)

	pass

#----------------------------------------------------------------------------------------
func SaveOptionsAndHighScores():
#	var player = {
#		"MusicVolumeValue": AudioCore.MusicVolume,
#		"EffectsVolumeValue": AudioCore.EffectsVolume,
#		"GameModeValue": LogicCore.GameMode,
#		"AllowComputerPlayers": LogicCore.AllowComputerPlayers,
#		"GameSpeedValue": LogicCore.GameSpeed,
#		"HighscoreNameValue": HighScoreName,
#		"HighScoreLevelValue": HighScoreLevel,
#		"HighScoreScoreValue": HighScoreScore,
#		"SecretCode": LogicCore.SecretCode,
#		"KeepAspectRatio": VisualsCore.KeepAspectRatio,
#		"JoyUpMapped": InputCore.JoyUpMapped,
#		"JoyDownMapped": InputCore.JoyDownMapped,
#		"JoyLeftMapped": InputCore.JoyLeftMapped,
#		"JoyRightMapped": InputCore.JoyRightMapped,
#		"JoyButtonOneMapped": InputCore.JoyButtonOneMapped,
#		"JoyButtonTwoMapped": InputCore.JoyButtonTwoMapped
#		
#	}
#
#	var file = File.new()
#	file.open(FILE_NAME, File.WRITE)
#	file.store_string(to_json(player))
#	file.close()

	pass

#----------------------------------------------------------------------------------------
func _ready():
	for x in range(6):
		HighScoreName.append([])
		HighScoreName[x].resize(10)
		for y in range(10):
			HighScoreName[x][y] = null

	for xL in range(6):
		HighScoreLevel.append([])
		HighScoreLevel[xL].resize(10)
		for yL in range(10):
			HighScoreLevel[xL][yL] = null

	for xS in range(6):
		HighScoreScore.append([])
		HighScoreScore[xS].resize(10)
		for yS in range(10):
			HighScoreScore[xS][yS] = null

	ClearHighScores()

	PlayerWithHighestScore = 1
	NewHighScoreRank = 999

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass
