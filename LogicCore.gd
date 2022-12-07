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

# "LogicCore.gd"
extends Node2D

var Version = "Version 3.0.0.21 - Beta 0.95% [Godot 4.0 Beta 6]"

const ChildMode				= 0
const TeenMode				= 1
const AdultMode				= 2
const TurboMode				= 3

var GameMode = AdultMode

var AllowComputerPlayers = 2

var GameSpeed = 30

var SecretCode = []
var SecretCodeCombined = 0

var Level

var PieceData = []

var Playfield = []
var PlayfieldMoveAI = []

var Piece = [];

var PieceBagIndex = []
var PieceBag = []
var PieceSelectedAlready = []

var NextPiece = []

const Current			= 0
const Next				= 1
const DropShadow		= 2
const Temp				= 3
const Fallen			= 4

var PieceRotation = []
var PiecePlayfieldX = []
var PiecePlayfieldY = []

const CollisionNotTrue			= 0
const CollisionWithPlayfield	= 1
const CollisionWithPiece		= 3

var PieceDropTimer = []
var TimeToDropPiece = []

const GameOver 					= -1
const NewPieceDropping 			= 0
const PieceFalling 				= 1
const FlashingCompletedLines 	= 2
const ClearingCompletedLines 	= 3
const ClearingPlayfield 		= 4
var PlayerStatus = []

var PAUSEgame = false
var PauseWasJustPressed = false

var PieceDropStartHeight = []

var PieceBagFirstUse = []

var PieceMovementDelay = []

var PieceRotatedOne = []
var PieceRotatedTwo = []

var PieceRotatedUp = []

var FlashCompletedLinesTimer
var ClearCompletedLinesTimer

var PlayfieldAlpha
var PlayfieldAlphaDir

var BoardFlip

var Score = []
var ScoreChanged

var DropBonus = []

var DrawEverything
var PieceMoved

var AndroidMovePieceDownDelay = []
var AndroidMovePieceDownPressed = []
var AndroidMovePieceLeftDelay = []
var AndroidMovePieceRightDelay = []

var PlayerInput = []

var PlayersCanJoinIn

var Player

var MovePieceCollision = []
var MovePieceHeight = []
var MoveTrappedHoles = []
var MoveOneBlockCavernHoles = []
var MovePlayfieldBoxEdges = []
var MoveCompletedLines = []

var BestMoveX = []
var BestRotation = []
var MovedToBestMove = []

var MaxRotationArray = []

var CPUPlayerMovementSkip = []

const CPUForcedFree			= 0
const CPUForcedLeft			= 1
const CPUForcedRight		= 2
var CPUPlayerForcedDirection = []

var CPUPieceTestX = []
var CPURotationTest = []
var CPUComputedBestMove = []

var pTXStep = []
var bestValue = []

var TotalLines
var LevelCleared

var GameWon

var AddRandomBlocksToBottomTimer

var PlayfieldBackup = []

var StillPlaying

var ScoreOneText
var ScoreTwoText
var ScoreThreeText
var LinesLeftText

var MouseTouchRotateDir

#----------------------------------------------------------------------------------------
func InitializePieceData():
	var _warnErase = PieceData.resize(8)
	for piece in range(8):
		PieceData[piece] = []
		PieceData[piece].resize(5)
		for rotations in range(5):
			PieceData[piece][rotations] = []
			PieceData[piece][rotations].resize(17)
	
	for piece in range(8):
		for rotations in range(5):
			for box in range(17):
				PieceData[piece][rotations][box] = 0

	# RED "S" Piece
	PieceData [1] [1] [10] = 1 # 01 02 03 04
	PieceData [1] [1] [11] = 1 # 05 06 07 08
	PieceData [1] [1] [13] = 1 # 09 [] [] 12
	PieceData [1] [1] [14] = 1 # [] [] 15 16

	PieceData [1] [2] [ 5] = 1
	PieceData [1] [2] [ 9] = 1
	PieceData [1] [2] [10] = 1
	PieceData [1] [2] [14] = 1

	PieceData [1] [3] [10] = 1
	PieceData [1] [3] [11] = 1
	PieceData [1] [3] [13] = 1
	PieceData [1] [3] [14] = 1

	PieceData [1] [4] [ 5] = 1
	PieceData [1] [4] [ 9] = 1
	PieceData [1] [4] [10] = 1
	PieceData [1] [4] [14] = 1

	# ORANGE "Z" Piece
	PieceData [2] [1] [ 9] = 1
	PieceData [2] [1] [10] = 1
	PieceData [2] [1] [14] = 1
	PieceData [2] [1] [15] = 1

	PieceData [2] [2] [ 6] = 1
	PieceData [2] [2] [ 9] = 1
	PieceData [2] [2] [10] = 1
	PieceData [2] [2] [13] = 1

	PieceData [2] [3] [ 9] = 1
	PieceData [2] [3] [10] = 1
	PieceData [2] [3] [14] = 1
	PieceData [2] [3] [15] = 1

	PieceData [2] [4] [ 6] = 1
	PieceData [2] [4] [ 9] = 1
	PieceData [2] [4] [10] = 1
	PieceData [2] [4] [13] = 1

	# AQUA "T" Piece
	PieceData [3] [1] [ 9] = 1
	PieceData [3] [1] [10] = 1
	PieceData [3] [1] [11] = 1
	PieceData [3] [1] [14] = 1

	PieceData [3] [2] [ 6] = 1
	PieceData [3] [2] [ 9] = 1
	PieceData [3] [2] [10] = 1
	PieceData [3] [2] [14] = 1

	PieceData [3] [3] [ 6] = 1
	PieceData [3] [3] [ 9] = 1
	PieceData [3] [3] [10] = 1
	PieceData [3] [3] [11] = 1

	PieceData [3] [4] [ 6] = 1
	PieceData [3] [4] [10] = 1
	PieceData [3] [4] [11] = 1
	PieceData [3] [4] [14] = 1

	# YELLOW "L" Piece
	PieceData [4] [1] [ 9] = 1
	PieceData [4] [1] [10] = 1
	PieceData [4] [1] [11] = 1
	PieceData [4] [1] [13] = 1

	PieceData [4] [2] [ 5] = 1
	PieceData [4] [2] [ 6] = 1
	PieceData [4] [2] [10] = 1
	PieceData [4] [2] [14] = 1

	PieceData [4] [3] [ 7] = 1
	PieceData [4] [3] [ 9] = 1
	PieceData [4] [3] [10] = 1
	PieceData [4] [3] [11] = 1

	PieceData [4] [4] [ 6] = 1
	PieceData [4] [4] [10] = 1
	PieceData [4] [4] [14] = 1
	PieceData [4] [4] [15] = 1

	# GREEN "Backwards L" Piece
	PieceData [5] [1] [ 9] = 1
	PieceData [5] [1] [10] = 1
	PieceData [5] [1] [11] = 1
	PieceData [5] [1] [15] = 1

	PieceData [5] [2] [ 6] = 1
	PieceData [5] [2] [10] = 1
	PieceData [5] [2] [13] = 1
	PieceData [5] [2] [14] = 1

	PieceData [5] [3] [ 5] = 1
	PieceData [5] [3] [ 9] = 1
	PieceData [5] [3] [10] = 1
	PieceData [5] [3] [11] = 1

	PieceData [5] [4] [ 6] = 1
	PieceData [5] [4] [ 7] = 1
	PieceData [5] [4] [10] = 1
	PieceData [5] [4] [14] = 1

	# BLUE "Box" Piece
	PieceData [6] [1] [10] = 1
	PieceData [6] [1] [11] = 1
	PieceData [6] [1] [14] = 1
	PieceData [6] [1] [15] = 1

	PieceData [6] [2] [10] = 1
	PieceData [6] [2] [11] = 1
	PieceData [6] [2] [14] = 1
	PieceData [6] [2] [15] = 1

	PieceData [6] [3] [10] = 1
	PieceData [6] [3] [11] = 1
	PieceData [6] [3] [14] = 1
	PieceData [6] [3] [15] = 1

	PieceData [6] [4] [10] = 1
	PieceData [6] [4] [11] = 1
	PieceData [6] [4] [14] = 1
	PieceData [6] [4] [15] = 1

	# PURPLE "Line" Piece
	PieceData [7] [1] [ 9] = 1
	PieceData [7] [1] [10] = 1
	PieceData [7] [1] [11] = 1
	PieceData [7] [1] [12] = 1
	
	PieceData [7] [2] [ 2] = 1
	PieceData [7] [2] [ 6] = 1
	PieceData [7] [2] [10] = 1
	PieceData [7] [2] [14] = 1

	PieceData [7] [3] [ 9] = 1
	PieceData [7] [3] [10] = 1
	PieceData [7] [3] [11] = 1
	PieceData [7] [3] [12] = 1

	PieceData [7] [4] [ 2] = 1
	PieceData [7] [4] [ 6] = 1
	PieceData [7] [4] [10] = 1
	PieceData [7] [4] [14] = 1

	pass

#----------------------------------------------------------------------------------------
func ClearPlayfieldWithCollisionDetection():
	for x in range(0, 35):
		for y in range(0, 26):
			Playfield[x][y] = 255

	for x in range(2, 32):
		for y in range(4, 24):
			Playfield[x][y] = 0

	for x in range(5, 9):
		for y in range(0, 4):
			Playfield[x][y] = 0

	for x in range(15, 19):
		for y in range(0, 4):
			Playfield[x][y] = 0

	for x in range(25, 29):
		for y in range(0, 4):
			Playfield[x][y] = 0

	if (LogicCore.SecretCodeCombined == 8888):
		for x in range(2, 31):
			for y in range(9, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

	pass

#----------------------------------------------------------------------------------------
func FillPieceBag(player):
	var done = false

	PieceBagIndex[player] = 1
	for index in range (0, 8):
		PieceBag[player][0][index] = -1
		PieceSelectedAlready[player][index] = false

	if PieceBagFirstUse[player] == true:
		PieceBagFirstUse[player] = false

		PieceBag[player][0][1] = ( (randi() % 7) + 1 )
		Piece[player] = PieceBag[player][0][1]
		PieceSelectedAlready[player][ PieceBag[player][0][1] ] = true
	else:
		PieceBag[player][0][1] = PieceBag[player][0][8]
		Piece[player] = PieceBag[player][0][1]
		PieceSelectedAlready[player][ PieceBag[player][0][1] ] = true

	while done == false:
		for x in range(2, 8):
			var randomPieceToTry = ( (randi() % 7) + 1 )
			while PieceSelectedAlready[player][randomPieceToTry] == true:
				randomPieceToTry = ( (randi() % 7) + 1 )

			PieceBag[player][0][x] = randomPieceToTry
			PieceSelectedAlready[player][randomPieceToTry] = true

			if x == 7:
				done = true
				x = 777

	PieceBag[player][0][8] = ( (randi() % 7) + 1 )

	if (SecretCodeCombined == 2778 or SecretCodeCombined == 8888):
		Piece[0] = 7
		NextPiece[0] = 7
		for index in range(0, 9):
			PieceBag[0][0][index] = 7
			PieceBag[0][1][index] = 7
		Piece[1] = 7
		NextPiece[1] = 7
		for index in range(0, 9):
			PieceBag[1][0][index] = 7
			PieceBag[1][1][index] = 7
		Piece[2] = 7
		NextPiece[2] = 7
		for index in range(0, 9):
			PieceBag[2][0][index] = 7
			PieceBag[2][1][index] = 7

	pass

#----------------------------------------------------------------------------------------
func PieceCollision(player):
	var box = 1
	var returnValue = CollisionNotTrue

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 1000)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 1010) )  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPiece

			box+=1

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollisionDown(player):
	var box = 1
	var returnValue = CollisionNotTrue

	for y in range(1, 5):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	for y in range(1, 5):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 1000)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 1010) )  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPiece

			box+=1

	return(returnValue)

#-----------------------------------AddCurrentPieceToPlayfieldMemory-----------------------------------------------------
func PieceCollisionLeft(player):
	var box = 1
	var returnValue = CollisionNotTrue

	for y in range(0, 4):
		for x in range(-1, 3):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	for y in range(0, 4):
		for x in range(-1, 3):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 1000)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 1010) )  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPiece

			box+=1

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollisionRight(player):
	var box = 1
	var returnValue = CollisionNotTrue

	for y in range(0, 4):
		for x in range(1, 5):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	for y in range(0, 4):
		for x in range(1, 5):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 1000)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 1010) )  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPiece

			box+=1

	return(returnValue)

#----------------------------------------------------------------------------------------
func RotatePieceCounterClockwise(player):
	if PlayerStatus[player] == NewPieceDropping:  return

	if PieceRotation[player] > 1:
		PieceRotation[player]-=1
	else:
		PieceRotation[player] = 4

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		PieceMoved = 1
		return(true)
	else:
		if PieceRotation[player] < 4:
			PieceRotation[player]+=1
		else:
			PieceRotation[player] = 1

		if (MouseTouchRotateDir == 0):  MouseTouchRotateDir = 1
		else:  MouseTouchRotateDir = 0

	return(false)

#----------------------------------------------------------------------------------------
func RotatePieceClockwise(player):
	if PlayerStatus[player] == NewPieceDropping:  return

	if PieceRotation[player] < 4:
		PieceRotation[player]+=1
	else:
		PieceRotation[player] = 1

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		PieceMoved = 1
		return(true)
	else:
		if PieceRotation[player] > 1:
			PieceRotation[player]-=1
		else:
			PieceRotation[player] = 4

		if (MouseTouchRotateDir == 0):  MouseTouchRotateDir = 1
		else:  MouseTouchRotateDir = 0

	return(false)

#----------------------------------------------------------------------------------------
func AddPieceToPlayfieldMemory(player, TempOrCurrentOrNextOrDropShadowOrFallen):
	if (LogicCore.PlayerStatus[player] == LogicCore.GameOver):  return

	if (ThereAreCompletedLines() == true):  return

	var TEMP_Piece = Piece[player]
	var TEMP_PieceRotation = PieceRotation[player]
	var TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
	var TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

	var value = (Piece[player] + 10)

	if (TempOrCurrentOrNextOrDropShadowOrFallen == Fallen):
		value = (Piece[player] + 30)
	elif TempOrCurrentOrNextOrDropShadowOrFallen == Next:
		DrawEverything = 1
		Piece[player] = NextPiece[player]
		value = (NextPiece[player] + 10)
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (TempOrCurrentOrNextOrDropShadowOrFallen == DropShadow && PlayerStatus[player] == PieceFalling):
		for y in range (PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if y - TEMP_PiecePlayfieldY > 4:
					value = 2000
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = TEMP_Piece
					PieceRotation[player] = TEMP_PieceRotation
					PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
					PiecePlayfieldY[player] = TEMP_PiecePlayfieldY
					return
	elif TempOrCurrentOrNextOrDropShadowOrFallen == Temp:
		value = (1000 + Piece[player])

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = value

	Piece[player] = TEMP_Piece
	PieceRotation[player] = TEMP_PieceRotation
	PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
	PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

	pass

#----------------------------------------------------------------------------------------
func ThereAreCompletedLines():
	var returnValue = false

	for y in range(4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1
			elif (Playfield[x][y] == 99999):
				boxTotal+=1

		if (boxTotal == 30):  returnValue = true

	return(returnValue)

#----------------------------------------------------------------------------------------
func DeletePieceFromPlayfieldMemory(player, CurrentOrNextOrDropShadow):
	if (LogicCore.PlayerStatus[player] == LogicCore.GameOver):  return

	if (PlayerStatus[player] == FlashingCompletedLines || PlayerStatus[player] == ClearingCompletedLines):  return

	if (ThereAreCompletedLines() == true):  return

	var TEMP_Piece = Piece[player]
	var TEMP_PieceRotation = PieceRotation[player]
	var TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
	var TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

	if CurrentOrNextOrDropShadow == Next:
		Piece[player] = NextPiece[player]
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (CurrentOrNextOrDropShadow == DropShadow && PlayerStatus[player] == PieceFalling):
		for y in range(PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if (y - TEMP_PiecePlayfieldY) > 4:
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = TEMP_Piece
					PieceRotation[player] = TEMP_PieceRotation
					PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
					PiecePlayfieldY[player] = TEMP_PiecePlayfieldY
					return

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = 0

	Piece[player] = TEMP_Piece
	PieceRotation[player] = TEMP_PieceRotation
	PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
	PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

	pass

#----------------------------------------------------------------------------------------
func SetupNewPiece(player):
	AndroidMovePieceDownDelay[player] = 0
	AndroidMovePieceDownPressed[player] = false
	AndroidMovePieceLeftDelay[player] = 0
	AndroidMovePieceRightDelay[player] = 0

	PieceRotation[player] = 1

	if player == 0:
		PiecePlayfieldX[player] = 5
	elif player == 1:
		PiecePlayfieldX[player] = 15
	elif player == 2:
		PiecePlayfieldX[player] = 25

	PiecePlayfieldY[player] = 0

	if PieceBagIndex[player] < 7:
		PieceBagIndex[player]+=1
		Piece[player] = (PieceBag[player][0][ PieceBagIndex[player] ])
		NextPiece[player] = PieceBag[player][0][ PieceBagIndex[player] + 1 ]
	elif PieceBagIndex[player] == 7:
		FillPieceBag(player)
		Piece[player] = PieceBag[player][0][1]
		NextPiece[player] = PieceBag[player][0][2]
		PieceBagIndex[player] = 1

	PlayerStatus[player] = NewPieceDropping

	PieceDropTimer[player] = 0

	PieceRotatedOne[player] = false
	PieceRotatedTwo[player] = false
	
	PieceRotatedUp[player] = false

	BestMoveX[player] = -1
	BestRotation[player] = -1
	MovedToBestMove[player] = false

	CPUPlayerMovementSkip[player] = 0

	CPUPlayerForcedDirection[player] = CPUForcedFree

	CPUPieceTestX[player] = 0
	CPURotationTest[player] = 1
	CPUComputedBestMove[player] = false

	pTXStep[player] = 1

	CPUPieceTestX[player] = 0

	bestValue[player] = 99999

	BestMoveX[player] = -1
	BestRotation[player] = -1

	CPUPieceTestX[player] = PiecePlayfieldX[player]

	pass

#----------------------------------------------------------------------------------------
func FlashCompletedLines(player):
	var _numberOfCompletedLines = 0

	if (FlashCompletedLinesTimer < 21):
		FlashCompletedLinesTimer+=1

	for y in range (4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1
			elif (Playfield[x][y] == 99999):
				boxTotal+=1

		if (boxTotal == 30):
			DrawEverything = 1
			_numberOfCompletedLines+=1

			if (FlashCompletedLinesTimer % 2 == 0):
				for xTwo in range (2, 32):
					Playfield[xTwo][y] = 99999
			else:
				for yThree in range(4, 24):
					for xThree in range(2, 32):
						Playfield[xThree][yThree] = PlayfieldBackup[xThree][yThree]

	if FlashCompletedLinesTimer == 21:
		PlayerStatus[player] = ClearingCompletedLines
		ClearCompletedLinesTimer = 0

	pass

#----------------------------------------------------------------------------------------
func ClearCompletedLines(player):
	var thereWasACompletedLine = false

	for y in range (4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1
				
		if boxTotal == 30:
			thereWasACompletedLine = true

			DrawEverything = 1

			if ClearCompletedLinesTimer < 40:
				ClearCompletedLinesTimer+=1

			if ClearCompletedLinesTimer % 10 == 0:
				for yTwo in range (y, 4, -1):
					for xTwo in range (2, 32):
						Playfield[xTwo][yTwo] = Playfield[xTwo][yTwo-1]

				for xTwo in range (2, 32):
					Playfield[xTwo][4] = 0

				AudioCore.PlayEffect(5)

	if thereWasACompletedLine == false:
		DrawEverything = 1
		SetupNewPiece(player)
		PlayerStatus[player] = NewPieceDropping

	pass

#----------------------------------------------------------------------------------------
func CheckForCompletedLines(player):
	var numberOfCompletedLines = 0

	DrawEverything = 1

	AddPieceToPlayfieldMemory(player, Fallen)

	for y in range(4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1

		if (boxTotal == 30):
		
			numberOfCompletedLines+=1

	if (numberOfCompletedLines > 0):
		if (numberOfCompletedLines == 1):
			Score[player] += (40 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=1
		elif (numberOfCompletedLines == 2):
			Score[player] += (100 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=2
		elif (numberOfCompletedLines == 3):
			Score[player] += (300 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=3
		elif (numberOfCompletedLines == 4):
			Score[player] += (1200 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=4
			AudioCore.PlayEffect(6)
		ScoreChanged = true

		for y in range(4, 24):
			for x in range(2, 32):
				PlayfieldBackup[x][y] = Playfield[x][y]

		PlayerStatus[player] = FlashingCompletedLines
		FlashCompletedLinesTimer = 0
	else:
		SetupNewPiece(player)

	pass

#----------------------------------------------------------------------------------------
func MovePieceDown(player, _force):
	if (InputCore.DelayAllUserInput > -1):
		return
	
	PieceMoved = 1
	
	DeletePieceFromPlayfieldMemory(player, Current)

	PiecePlayfieldY[player]+=1

	if (PieceCollision(player) != CollisionNotTrue):
		for pIndex in range(0, 3):
			CPUComputedBestMove[pIndex] = false

	if PieceCollision(player) == CollisionWithPlayfield:
		if (PlayersCanJoinIn == true && AllowComputerPlayers < 2):
			var iconIndex = 4
			if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
				iconIndex = 8

			PlayersCanJoinIn = false
			InterfaceCore.Icons.IconScreenX[iconIndex+1] = -9999
			InterfaceCore.Icons.IconScreenY[iconIndex+1] = -9999

			if (AllowComputerPlayers > 0):
				PlayerInput[0] = InputCore.InputCPU
				PlayerStatus[0] = NewPieceDropping

				if (PlayerStatus[2] == GameOver):
					PlayerInput[2] = InputCore.InputCPU
					PlayerStatus[2] = NewPieceDropping

		PiecePlayfieldY[player]-=1

		AudioCore.PlayEffect(4)

		Score[player]+=DropBonus[player]
		ScoreChanged = true
		DropBonus[player] = 0

		if PlayerStatus[player] == NewPieceDropping:
			AddPieceToPlayfieldMemory(player, Current)
			PlayerStatus[player] = GameOver
		else:
			CheckForCompletedLines(player)

	pass

#----------------------------------------------------------------------------------------
func MovePieceLeft(player):
	PieceMoved = 1

	if PlayerStatus[player] == NewPieceDropping:  return

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] > -6:
			PieceMovementDelay[player]-=1
		
		if (PieceMovementDelay[player] == -1 || PieceMovementDelay[player] < -5):
			PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]+=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceLeftDelay[player] == 1 || AndroidMovePieceLeftDelay[player] == 1+5 || AndroidMovePieceLeftDelay[player] == 6+4 || AndroidMovePieceLeftDelay[player] == 10+3 || AndroidMovePieceLeftDelay[player] > 10+4):
			PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]+=1
	elif (PlayerInput[player] == InputCore.InputCPU):
		PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]+=1
	pass

#----------------------------------------------------------------------------------------
func MovePieceRight(player):
	PieceMoved = 1

	if PlayerStatus[player] == NewPieceDropping:  return

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] < 6:
			PieceMovementDelay[player]+=1
		
		if (PieceMovementDelay[player] == 1 || PieceMovementDelay[player] > 5):
			PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]-=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceRightDelay[player] == 1 || AndroidMovePieceRightDelay[player] == 1+5 || AndroidMovePieceRightDelay[player] == 6+4 || AndroidMovePieceRightDelay[player] == 10+3 || AndroidMovePieceRightDelay[player] > 10+4):
			PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]-=1
	elif (PlayerInput[player] == InputCore.InputCPU):
		PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]-=1
	pass

#----------------------------------------------------------------------------------------
func SetupForNewGame():
	ClearPlayfieldWithCollisionDetection()

	for player in range(0, 3):
		PieceBagFirstUse[player] = true
		FillPieceBag(player)
		NextPiece[player] = PieceBag[player][0][2]
		
		PieceRotation[player] = 1

		PieceDropTimer[player] = 0
		TimeToDropPiece[player] = 47

		PieceRotatedOne[player] = false
		PieceRotatedTwo[player] = false
		
		PieceRotatedUp[player] = false

		Score[player] = 0

		DropBonus[player] = 0

		AndroidMovePieceDownDelay[player] = 0
		AndroidMovePieceDownPressed[player] = false
		AndroidMovePieceLeftDelay[player] = 0
		AndroidMovePieceRightDelay[player] = 0

		BestMoveX[player] = -1
		BestRotation[player] = -1
		MovedToBestMove[player] = false

		PieceMovementDelay[player] = 0

		CPUPlayerMovementSkip[player] = 0

		CPUPlayerForcedDirection[player] = CPUForcedFree

		CPUPieceTestX[player] = 0
		CPURotationTest[player] = 1
		CPUComputedBestMove[player] = false

		pTXStep[player] = 1

		CPUPieceTestX[player] = 0

		bestValue[player] = 99999

		CPUPieceTestX[player] = PiecePlayfieldX[player]

	ScoreChanged = true

	if (SecretCodeCombined == 8889 || SecretCodeCombined == 3777):
		Score[0] = 0
		Score[1] = 203565
		Score[2] = 216054

	Level = 1

	PiecePlayfieldX[0] = 5
	PiecePlayfieldY[0] = 0

	PiecePlayfieldX[1] = 15
	PiecePlayfieldY[1] = 0

	PiecePlayfieldX[2] = 25
	PiecePlayfieldY[2] = 0

	for index in range (0, 9):
		VisualsCore.PlayfieldSpriteCurrentIndex[index] = 0

	for index in range (0, 8):
		VisualsCore.PieceSpriteCurrentIndex[index] = 0

	PlayerStatus[0] = GameOver
	PlayerStatus[1] = NewPieceDropping
	PlayerStatus[2] = GameOver

	PAUSEgame = false

	VisualsCore.KeyboardControlsAlphaTimer = 1.0

	FlashCompletedLinesTimer = 0
	ClearCompletedLinesTimer = 0

	PlayfieldAlpha = 1
	PlayfieldAlphaDir = 0

	BoardFlip = 0

	DrawEverything = 1
	PieceMoved = 1

	for index in range(0, 4):
		InterfaceCore.Icons.IconAnimationTimer[index] = -1

	PlayersCanJoinIn = true

	if (AllowComputerPlayers == 2):
		PlayerStatus[0] = NewPieceDropping
		PlayerStatus[1] = NewPieceDropping
		PlayerStatus[2] = NewPieceDropping
		PlayerInput[0] = InputCore.InputCPU
		PlayerInput[1] = InputCore.InputCPU
		PlayerInput[2] = InputCore.InputCPU
		PlayersCanJoinIn = false
	elif (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		PlayerInput[0] = InputCore.InputNone
		PlayerInput[1] = InputCore.InputKeyboard
		PlayerInput[2] = InputCore.InputNone
	else:
		PlayerInput[0] = InputCore.InputNone
		PlayerInput[1] = InputCore.InputTouchOne
		PlayerInput[2] = InputCore.InputNone

	TotalLines = 0
	LevelCleared = false

	GameWon = false

	AddRandomBlocksToBottomTimer = 0

	StillPlaying = true

	if (SecretCodeCombined == 6161):
		PlayerStatus[0] = NewPieceDropping
		PlayerStatus[1] = NewPieceDropping
		PlayerStatus[2] = NewPieceDropping
		PlayerInput[0] = InputCore.InputJoyOne
		PlayerInput[1] = InputCore.InputKeyboard
		PlayerInput[2] = InputCore.InputMouse

		PlayersCanJoinIn = false

		Score[0] = 1257465
		Score[1] = 1166456
		Score[2] = 1299665

		Level = 8

		Piece[0] = 7
		PieceRotation[0] = 2
		Piece[1] = 7
		Piece[2] = 7

		for x in range(2, 31):
			for y in range(20, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

		for y in range(20, 24):
			Playfield[6][y] = 0

		for y in range(20, 24):
			Playfield[6+7][y] = 0
	elif (SecretCodeCombined == 2778):
		for x in range(2, 30):#31):
			for y in range(20, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

	pass

#----------------------------------------------------------------------------------------
func SetupForNewLevel():
	if (Level == 1 or SecretCodeCombined == 6161):
		return

	ClearPlayfieldWithCollisionDetection()

	for player in range(0, 3):
		PieceBagFirstUse[player] = true
		FillPieceBag(player)
		NextPiece[player] = PieceBag[player][0][2]
		
		PieceRotation[player] = 1

		PieceDropTimer[player] = 0
		TimeToDropPiece[player] = 47

		PieceRotatedOne[player] = false
		PieceRotatedTwo[player] = false
		
		PieceRotatedUp[player] = false

		DropBonus[player] = 0

		AndroidMovePieceDownDelay[player] = 0
		AndroidMovePieceDownPressed[player] = false
		AndroidMovePieceLeftDelay[player] = 0
		AndroidMovePieceRightDelay[player] = 0

		BestMoveX[player] = -1
		BestRotation[player] = -1
		MovedToBestMove[player] = false

		PieceMovementDelay[player] = 0

		CPUPlayerMovementSkip[player] = 0

		CPUPlayerForcedDirection[player] = CPUForcedFree

		CPUPieceTestX[player] = 0
		CPURotationTest[player] = 1
		CPUComputedBestMove[player] = false

		pTXStep[player] = 1

		CPUPieceTestX[player] = 0

		bestValue[player] = 99999

		CPUPieceTestX[player] = PiecePlayfieldX[player]

	ScoreChanged = true

	PiecePlayfieldX[0] = 5
	PiecePlayfieldY[0] = 0

	PiecePlayfieldX[1] = 15
	PiecePlayfieldY[1] = 0

	PiecePlayfieldX[2] = 25
	PiecePlayfieldY[2] = 0

	for index in range (0, 9):
		VisualsCore.PlayfieldSpriteCurrentIndex[index] = 0

	for index in range (0, 8):
		VisualsCore.PieceSpriteCurrentIndex[index] = 0

	PAUSEgame = false

	VisualsCore.KeyboardControlsAlphaTimer = 0.0

	FlashCompletedLinesTimer = 0
	ClearCompletedLinesTimer = 0

	PlayfieldAlpha = 1
	PlayfieldAlphaDir = 0

	BoardFlip = 0

	DrawEverything = 1

	for index in range(0, 4):
		InterfaceCore.Icons.IconAnimationTimer[index] = -1

	PlayersCanJoinIn = false

	TotalLines = 0
	LevelCleared = false

	AddRandomBlocksToBottomTimer = 0

	pass

#----------------------------------------------------------------------------------------
func AddCurrentPieceToPlayfieldMemory(player):
	var value = (1000 + Piece[player])

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = value

	pass

#----------------------------------------------------------------------------------------
func DeleteCurrentPieceFromPlayfieldMemory(player):
	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = 0

	pass

#----------------------------------------------------------------------------------------
func AddRandomBlocksToBottom():
	if (SecretCodeCombined == 8888):  return

	DrawEverything = 1
	PieceMoved = 1

	var thereWillBeNoDownwardCollisions = true
	if (PlayerStatus[0] == PieceFalling):
		if (PieceCollisionDown(0) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false
	if (PlayerStatus[1] == PieceFalling):
		if (PieceCollisionDown(1) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false
	if (PlayerStatus[2] == PieceFalling):
		if (PieceCollisionDown(2) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false

	if (thereWillBeNoDownwardCollisions == false):
		return

	for y in range(4, 24):
		for x in range(2, 32):
			Playfield[x][y] = Playfield[x][y+1]

	var boxCount = 0
	for x in range(2, 32):
		if (boxCount < 29):
			var randomBox= (  ( randi() % 8 )  )
			if (randomBox > 0):
				Playfield[x][23] = (randomBox + 30)
			else:
				Playfield[x][23] = 0
		else:
			Playfield[x][23] = 0

		if (Playfield[x][23] > 0):
			boxCount+=1

	AudioCore.PlayEffect(7)

	pass

#----------------------------------------------------------------------------------------
func CheckForNewPlayers():
	if (PlayersCanJoinIn == true):
		if (InputCore.JoyButtonOne[InputCore.InputKeyboard] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputKeyboard && PlayerInput[1] != InputCore.InputKeyboard && PlayerInput[2] != InputCore.InputKeyboard):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputKeyboard
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputKeyboard
		elif (InputCore.JoyButtonOne[InputCore.InputJoyOne] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyOne && PlayerInput[1] != InputCore.InputJoyOne && PlayerInput[2] != InputCore.InputJoyOne):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyOne
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyOne
		elif (InputCore.JoyButtonOne[InputCore.InputJoyTwo] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyTwo && PlayerInput[1] != InputCore.InputJoyTwo && PlayerInput[2] != InputCore.InputJoyTwo):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyTwo
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyTwo
		elif (InputCore.JoyButtonOne[InputCore.InputJoyThree] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyThree && PlayerInput[1] != InputCore.InputJoyThree && PlayerInput[2] != InputCore.InputJoyThree):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyThree
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyThree

	pass

#----------------------------------------------------------------------------------------
func AddIncompleteLineToBottom(player):
	if (player == 2):
		var allPiecesAreFalling = true
		if (PlayerStatus[0] != PieceFalling && PlayerStatus[0] != GameOver):
			allPiecesAreFalling = false
		if (PlayerStatus[1] != PieceFalling && PlayerStatus[1] != GameOver):
			allPiecesAreFalling = false
		if (PlayerStatus[2] != PieceFalling && PlayerStatus[2] != GameOver):
			allPiecesAreFalling = false

		if (allPiecesAreFalling == true):
			AddRandomBlocksToBottomTimer+=1

			var timeForCrisis = 375+(100*2)
			if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
				timeForCrisis+=175

			if (AddRandomBlocksToBottomTimer > timeForCrisis):
				AddRandomBlocksToBottom()
				AddRandomBlocksToBottomTimer = 0

	pass

#----------------------------------------------------------------------------------------
func DoAnyPlayersHaveCompletedLine():
	var returnValue = false
	if (PlayerStatus[0] == FlashingCompletedLines || PlayerStatus[0] == ClearingCompletedLines):
		returnValue = true
	if (PlayerStatus[1] == FlashingCompletedLines || PlayerStatus[1] == ClearingCompletedLines):
		returnValue = true
	if (PlayerStatus[2] == FlashingCompletedLines || PlayerStatus[2] == ClearingCompletedLines):
		returnValue = true

	return(returnValue)
	
#----------------------------------------------------------------------------------------
func ProcessPieceFall(player):
	if PieceDropTimer[player] > TimeToDropPiece[player]:
		if PieceCollisionDown(player) != CollisionWithPiece:
			if (InputCore.JoystickDirection[PlayerInput[player]] != InputCore.JoyDown):
				AudioCore.PlayEffect(3)

			MovePieceDown(player, false)
			PieceDropTimer[player] = 0

#----------------------------------------------------------------------------------------
func GetHumanPlayersKeyboardAndGameControllersMoves(player):
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyLeft):
			MovePieceLeft(player)
		elif (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyRight):
			MovePieceRight(player)
		else:
			PieceMovementDelay[player] = 0

		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyUp):
			if PieceRotatedUp[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedUp[player] = true
		else:
			PieceRotatedUp[player] = false

		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyDown):
			PieceDropTimer[player] = (1 + TimeToDropPiece[player])
			DropBonus[player]+=1
		else:
			DropBonus[player] = 0

		if InputCore.JoyButtonOne[PlayerInput[player]] == InputCore.Pressed:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

		if InputCore.JoyButtonTwo[PlayerInput[player]] == InputCore.Pressed:
			if PieceRotatedTwo[player] == false:
				var _warnErase = RotatePieceCounterClockwise(player)
				PieceRotatedTwo[player] = true
		else:
			PieceRotatedTwo[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerMouseMoves(player):
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceDropTimer[player] > TimeToDropPiece[player]:
			if PieceCollisionDown(player) != CollisionWithPiece:
				if DropBonus[player] == 0:
					AudioCore.PlayEffect(3)

				MovePieceDown(player, false)
				PieceDropTimer[player] = 0

		if InterfaceCore.ThisIconWasPressed(0, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(1, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(2, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(3, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase
				if (MouseTouchRotateDir == 0):
					_warnErase = RotatePieceClockwise(player)
				elif (MouseTouchRotateDir == 1):
					_warnErase = RotatePieceCounterClockwise(player)

				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerTouchOneMoves(player):
	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		if InterfaceCore.ThisIconWasPressed(0, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(1, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(2, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(3, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerTouchTwoMoves(player):
	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		if InterfaceCore.ThisIconWasPressed(4, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(5, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(6, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(7, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
func CheckForLevelAdvance():
	if (TotalLines > 10):
		InputCore.DelayAllUserInput = 25
		ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
		ScreensCore.ScreenToDisplayNext = ScreensCore.CutSceneScreen
		Level+=1
		ScreensCore.CutSceneScene = 1
		Engine.physics_ticks_per_second = 30

		LevelCleared = true

		if (Level < 10):
			AudioCore.PlayMusic(Level)
		elif (Level == 10):
			InputCore.DelayAllUserInput = 100
			StillPlaying = false
			GameWon = true
			Engine.physics_ticks_per_second = 30

			ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
			ScreensCore.ScreenToDisplayNext = ScreensCore.WonGameScreen

			SecretCode[0] = 5
			SecretCode[1] = 4
			SecretCode[2] = 3
			SecretCode[3] = 1
			SecretCodeCombined = (SecretCode[0]*1000)+(SecretCode[1]*100)+(SecretCode[2]*10)+(SecretCode[3]*1)

	pass

#----------------------------------------------------------------------------------------
func CheckForGameOver():
	if (PlayerStatus[0] == GameOver && PlayerStatus[1] == GameOver && PlayerStatus[2] == GameOver):
		Engine.physics_ticks_per_second = 30

		AudioCore.PlayMusic(0)

		StillPlaying = false

		ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack

	pass

#----------------------------------------------------------------------------------------
func AddToPlayfieldAllPlayerPiecesAndDropShadows():
	if PlayerStatus[1] == PieceFalling:
		AddPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[0] == PieceFalling:
		AddPieceToPlayfieldMemory(0, DropShadow)

	if (PlayerStatus[1] == PieceFalling):  DeletePieceFromPlayfieldMemory(1, Current)
	if (PlayerStatus[2] == PieceFalling):  DeletePieceFromPlayfieldMemory(2, Current)

	if PlayerStatus[0] == PieceFalling:
		AddPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddPieceToPlayfieldMemory(1, DropShadow)

	if (PlayerStatus[0] == PieceFalling):  DeletePieceFromPlayfieldMemory(0, Current)
	if (PlayerStatus[2] == PieceFalling):  DeletePieceFromPlayfieldMemory(2, Current)

	if PlayerStatus[0] == PieceFalling:
		AddPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddPieceToPlayfieldMemory(2, DropShadow)

	if (PlayerStatus[0] == PieceFalling):  DeletePieceFromPlayfieldMemory(0, Current)
	if (PlayerStatus[1] == PieceFalling):  DeletePieceFromPlayfieldMemory(1, Current)

	if (PlayerStatus[0] == PieceFalling):
		AddPieceToPlayfieldMemory(0, Temp)
	if (PlayerStatus[1] == PieceFalling):
		AddPieceToPlayfieldMemory(1, Temp)
	if (PlayerStatus[2] == PieceFalling):
		AddPieceToPlayfieldMemory(2, Temp)

	pass

#----------------------------------------------------------------------------------------
func DeleteFromPlayfieldAllPlayerPiecesAndDropShadows():
	for player in range(0, 3):
		if PlayerStatus[player] == PieceFalling:
			DeletePieceFromPlayfieldMemory(player, Current)

	if PlayerStatus[1] == PieceFalling:
		AddPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[0] == PieceFalling:
		DeletePieceFromPlayfieldMemory(0, DropShadow)

	if PlayerStatus[1] == PieceFalling:  DeletePieceFromPlayfieldMemory(1, Current)
	if PlayerStatus[2] == PieceFalling:  DeletePieceFromPlayfieldMemory(2, Current)

	if PlayerStatus[0] == PieceFalling:
		AddPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[1] == PieceFalling:
		DeletePieceFromPlayfieldMemory(1, DropShadow)

	if PlayerStatus[0] == PieceFalling: DeletePieceFromPlayfieldMemory(0, Current)
	if PlayerStatus[2] == PieceFalling:  DeletePieceFromPlayfieldMemory(2, Current)

	if PlayerStatus[0] == PieceFalling:
		AddPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		DeletePieceFromPlayfieldMemory(2, DropShadow)

	if PlayerStatus[0] == PieceFalling:  DeletePieceFromPlayfieldMemory(0, Current)
	if PlayerStatus[1] == PieceFalling:  DeletePieceFromPlayfieldMemory(1, Current)

	if PlayerStatus[0] == PieceFalling:  DeletePieceFromPlayfieldMemory(0, Current)
	if PlayerStatus[1] == PieceFalling:  DeletePieceFromPlayfieldMemory(1, Current)
	if PlayerStatus[2] == PieceFalling:  DeletePieceFromPlayfieldMemory(2, Current)

	pass

#----------------------------------------------------------------------------------------
# /\/\________.__  _____  __    ________   _____    _________.__       .__     __ /\/\
# )/)/  _____/|__|/ ____\/  |_  \_____  \_/ ____\  /   _____/|__| ____ |  |___/  |)/)/
#   /   \  ___|  \   __\\   __\  /   |   \   __\   \_____  \ |  |/ ___\|  |  \   __\  
#   \    \_\  \  ||  |   |  |   /    |    \  |     /        \|  / /_/  >   Y  \  |    
#    \______  /__||__|   |__|   \_______  /__|    /_______  /|__\___  /|___|  /__|    
#           \/                          \/                \/   /_____/      \/v2.0
#
# Cooperative Puzzle Artificial Intelligence A.I. By "JeZxLee" & "flairetic"
#
# Single - 100%
# Multi - Not 100%

func ComputeComputerPlayerMove(player):
	var notReady = false
	for index in range(0, 3):
		if (PlayerStatus[index] != PieceFalling and PlayerStatus[index] != GameOver):
			notReady = true

	if (notReady == true):  return

	DeleteCurrentPieceFromPlayfieldMemory(player)

	if (CPUComputedBestMove[player] == false):
		var TEMP_BreakFromDoubleForLoop

		var TEMP_PieceRotation
		var TEMP_PiecePlayfieldX
		var TEMP_PiecePlayfieldY

		for posX in range (0, 32):
			for rot in range (1, MaxRotationArray[Piece[player]]+1):
				MovePieceHeight[player][posX][rot] = 0.0
				MoveTrappedHoles[player][posX][rot] = 99999.0
				MoveOneBlockCavernHoles[player][posX][rot] = 99999.0
				MovePlayfieldBoxEdges[player][posX][rot] = 99999.0
				MoveCompletedLines[player][posX][rot] = 0.0
				MovePieceCollision[player][posX][rot] = true

#		print("-----------------------------------------------------------------------------------")
#-- Compute, prioritize, & store all player moves ------------------------------
		var left = -1
		var right = 1
		var done = 0
		var direction = left
		var testLimitX
		var testStepX

		while (direction != done):
			if (direction == left):
				testLimitX = -1
				testStepX = -1
			elif (direction == right):
				testLimitX = 32
				testStepX = 1

			TEMP_BreakFromDoubleForLoop = false
			for NewCPUPieceTestX in range (PiecePlayfieldX[player], testLimitX, testStepX):
				if (TEMP_BreakFromDoubleForLoop == false):
					for NewCPURotationTest in range (1, MaxRotationArray[Piece[player]]+1):
#						print("Player="+str(player)+" /TestX="+str(NewCPUPieceTestX)+" /TestRot="+str(NewCPURotationTest))

						TEMP_PieceRotation = PieceRotation[player]
						TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
						TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

						PiecePlayfieldX[player] = NewCPUPieceTestX
						PieceRotation[player] = NewCPURotationTest

						MovePieceCollision[player][NewCPUPieceTestX][NewCPURotationTest] = false
						if (PieceCollision(player) != CollisionWithPiece):
							var TEMP_BreakFromForLoop = false
							for posY in range(PiecePlayfieldY[player], 23):
								if (TEMP_BreakFromForLoop == false):
									PiecePlayfieldY[player] = posY
									if ( PieceCollision(player) == CollisionWithPiece ):
										MovePieceCollision[player][NewCPUPieceTestX][NewCPURotationTest] = true
										PieceRotation[player] = TEMP_PieceRotation
										PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
										PiecePlayfieldY[player] = TEMP_PiecePlayfieldY
										TEMP_BreakFromForLoop = true
#												TEMP_BreakFromDoubleForLoop = true
#										print("Player="+str(player)+" - Piece to piece downward collision! - posY="+str(posY))
									elif ( PieceCollision(player) == CollisionWithPlayfield ):
										PiecePlayfieldY[player] = (posY-1)
										MovePieceHeight[player][NewCPUPieceTestX][NewCPURotationTest] = PiecePlayfieldY[player]
										TEMP_BreakFromForLoop = true

										AddCurrentPieceToPlayfieldMemory(player)

										MoveTrappedHoles[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posX in range(2, 32):
											var numberOfEmpties = 0
											for posYtwo in range(22, 4, -1):
												if (Playfield[posX][posYtwo] == 0):
													numberOfEmpties+=1
												elif (Playfield[posX][posYtwo] > 30 && Playfield[posX][posYtwo] < 40):
													MoveTrappedHoles[player][NewCPUPieceTestX][NewCPURotationTest]+=numberOfEmpties
													numberOfEmpties = 0

										MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posYthree in range(5, 23):
											for posX in range(2, 32):
												if ( (Playfield[posX][posYthree] > 30 && Playfield[posX][posYthree] < 40) || (Playfield[posX][posYthree] > 1000 && Playfield[posX][posYthree] < 1010) || Playfield[posX][posYthree] == 255 ):
													if (Playfield[posX][(posYthree-1)] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (Playfield[posX][(posYthree+1)] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (Playfield[(posX-1)][posYthree] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (Playfield[(posX+1)][posYthree] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										MoveCompletedLines[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for y in range(4, 24):
											var boxTotal = 0
											for x in range (2, 32):
												if ( (Playfield[x][y] > 30 && Playfield[x][y] < 40) || (Playfield[x][y] > 1000 && Playfield[x][y] < 1010) ):
													boxTotal+=1

											if (boxTotal == 30):
												MoveCompletedLines[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										MoveOneBlockCavernHoles[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posYfour in range(5, 23):
											for posX in range(2, 32):
												if (Playfield[posX][posYfour] == 0 && Playfield[(posX-1)][posYfour] != 0 && Playfield[(posX+1)][posYfour] != 0):
													MoveOneBlockCavernHoles[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										DeleteCurrentPieceFromPlayfieldMemory(player)
										PieceRotation[player] = TEMP_PieceRotation
										PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
										PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

#										print("X="+str(NewCPUPieceTestX)+" /Rot="+str(NewCPURotationTest)+" /Height="+str(MovePieceHeight[player][NewCPUPieceTestX][NewCPURotationTest])+" /Trap="+str(MoveTrappedHoles[player][NewCPUPieceTestX][NewCPURotationTest])+" /Edges="+str(MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest])+" /CompLines="+str(MoveCompletedLines[player][NewCPUPieceTestX][NewCPURotationTest]))
						else:
#							print("Player="+str(player)+" - Piece to piece collision (left/right)!")

							if (direction == left):
								CPUPlayerForcedDirection[player] = CPUForcedRight
							elif (direction == right):
								CPUPlayerForcedDirection[player] = CPUForcedLeft

							MovePieceCollision[player][NewCPUPieceTestX][NewCPURotationTest] = true
							PieceRotation[player] = TEMP_PieceRotation
							PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
							PiecePlayfieldY[player] = TEMP_PiecePlayfieldY
							
							TEMP_BreakFromDoubleForLoop = true

			if (direction == left):
				direction = right
			else:
				direction = done

#-- Choose best move & rotation in either left or right direction ----------------------------------
		var TEMP_BestValue = 9999999.0
		for posX in range (0, 32):
			for rot in range (1, MaxRotationArray[Piece[player]]+1):
				if (MovePieceCollision[player][posX][rot] == false):
					MovePieceHeight[player][posX][rot]+=MoveCompletedLines[player][posX][rot]

					var testValue
					testValue = ( (3.0*MoveTrappedHoles[player][posX][rot])
					+(1.0*MoveOneBlockCavernHoles[player][posX][rot])
					+(1.0*MovePlayfieldBoxEdges[player][posX][rot])
					-(1.0*MovePieceHeight[player][posX][rot])
					-(1000000.0*MoveCompletedLines[player][posX][rot]) )

#					print("posX="+str(posX)+" /rot="+str(rot)+" /testValue="+str(testValue))

					if (testValue <= TEMP_BestValue):
						TEMP_BestValue = testValue
						BestMoveX[player] = posX
						BestRotation[player] = rot

		CPUComputedBestMove[player] = true
		MovedToBestMove[player] = false

#		print("************* BestMoveX="+str(BestMoveX[player])+" /BestRot="+str(BestRotation[player]))

#-- Rotate & move falling piece to best ------------------------------------------------------------
	elif (CPUComputedBestMove[player] == true):
		if (MovedToBestMove[player] == false):
			if (PieceRotation[player] < BestRotation[player]):
				var _warnErase = RotatePieceClockwise(player)
			elif (PieceRotation[player] > BestRotation[player]):
				var _warnErase = RotatePieceCounterClockwise(player)

			if (BestMoveX[player] < PiecePlayfieldX[player]):
				MovePieceLeft(player)
			elif (BestMoveX[player] > PiecePlayfieldX[player]):
				MovePieceRight(player)
			else:
				MovedToBestMove[player] = true
		elif (MovedToBestMove[player] == true):
				MovePieceDown(player, true)

	if (PieceCollision(player) == CollisionNotTrue):  AddCurrentPieceToPlayfieldMemory(player)

	pass

#   /\/\________.__  _____  __    ________   _____    _________.__       .__     __ /\/\
#   )/)/  _____/|__|/ ____\/  |_  \_____  \_/ ____\  /   _____/|__| ____ |  |___/  |)/)/
#     /   \  ___|  \   __\\   __\  /   |   \   __\   \_____  \ |  |/ ___\|  |  \   __\  
#     \    \_\  \  ||  |   |  |   /    |    \  |     /        \|  / /_/  >   Y  \  |    
#      \______  /__||__|   |__|   \_______  /__|    /_______  /|__\___  /|___|  /__|    
#             \/                          \/                \/   /_____/      \/v2.0
#
#              Cooperative Puzzle Artificial Intelligence A.I. By "JeZxLee" & "flairetic"

#----------------------------------------------------------------------------------------
func RunPuzzleGameCore():
	if PAUSEgame == false:
		CheckForNewPlayers()

		if (LogicCore.SecretCodeCombined == 2778 or LogicCore.SecretCodeCombined == 2779):
			PlayerStatus[0] = GameOver
			PlayerStatus[2] = GameOver

		for player in range(0, 3):
			Player = player

			if (DoAnyPlayersHaveCompletedLine() == false and ThereAreCompletedLines() == false):
				if PlayerStatus[0] == PieceFalling:
					if player != 0:
						AddCurrentPieceToPlayfieldMemory(0)
				if PlayerStatus[1] == PieceFalling:
					if player != 1:
						AddCurrentPieceToPlayfieldMemory(1)
				if PlayerStatus[2] == PieceFalling:
					if player != 2:
						AddCurrentPieceToPlayfieldMemory(2)

				if PlayerStatus[player] != GameOver:
					if SecretCodeCombined != 8888 && SecretCodeCombined != 8889 && SecretCodeCombined != 3777:
						PieceDropTimer[player]+=1
					
					if PlayerStatus[player] == NewPieceDropping:
						DrawEverything = 1
						PieceMoved = 1

						if PiecePlayfieldY[player] < PieceDropStartHeight[ Piece[player] ]:
							DeleteCurrentPieceFromPlayfieldMemory(player)
							if (PieceCollisionDown(player) != CollisionWithPiece):
								MovePieceDown(player, true)

							AddCurrentPieceToPlayfieldMemory(player)
						else:
							AddPieceToPlayfieldMemory(player, Next)
							PlayerStatus[player] = PieceFalling
					elif PlayerStatus[player] == PieceFalling:
						ProcessPieceFall(player)

						if (PlayerInput[player] == InputCore.InputCPU && AllowComputerPlayers > 0):
							ComputeComputerPlayerMove(player)
						elif (PlayerInput[player] == InputCore.InputKeyboard || PlayerInput[player] == InputCore.InputJoyOne || PlayerInput[player] == InputCore.InputJoyTwo || PlayerInput[player] == InputCore.InputJoyThree):
							GetHumanPlayersKeyboardAndGameControllersMoves(player)
						elif (PlayerInput[player] == InputCore.InputMouse):
							GetHumanPlayerMouseMoves(player)
						elif (PlayerInput[player] == InputCore.InputTouchOne):
							GetHumanPlayerTouchOneMoves(player)
						elif (PlayerInput[player] == InputCore.InputTouchTwo):
							GetHumanPlayerTouchTwoMoves(player)

				if (DoAnyPlayersHaveCompletedLine() == false):
					if PlayerStatus[0] == PieceFalling:
						if player != 0:
							DeleteCurrentPieceFromPlayfieldMemory(0)
					if PlayerStatus[1] == PieceFalling:
						if player != 1:
							DeleteCurrentPieceFromPlayfieldMemory(1)
					if PlayerStatus[2] == PieceFalling:
						if player != 2:
							DeleteCurrentPieceFromPlayfieldMemory(2)

#				AddIncompleteLineToBottom(player)

				CheckForLevelAdvance()

				CheckForGameOver()
			else:
				if (PlayerStatus[player] == FlashingCompletedLines):
					FlashCompletedLines(player)
				elif (PlayerStatus[player] == ClearingCompletedLines):
					ClearCompletedLines(player)

#	ComputeAllComputerPlayersMoves()

	pass

#----------------------------------------------------------------------------------------
func _ready():
	SecretCode.append(2)
	SecretCode.append(7)
	SecretCode.append(7)
	SecretCode.append(9)#7)
	
	LogicCore.SecretCodeCombined = 2779#7

	InitializePieceData()

	var _warnErase = Playfield.resize(35)
	for x in range(35):
		Playfield[x] = []
		Playfield[x].resize(26)
		for y in range(26):
			Playfield[x][y] = []

	_warnErase = PlayfieldMoveAI.resize(35)
	for x in range(35):
		PlayfieldMoveAI[x] = []
		PlayfieldMoveAI[x].resize(26)
		for y in range(26):
			PlayfieldMoveAI[x][y] = []

	_warnErase = PieceBagIndex.resize(3)

	_warnErase = PieceBag.resize(3)
	for player in range(3):
		PieceBag[player] = []
		PieceBag[player].resize(2)
		for bag in range(2):
			PieceBag[player][bag] = []
			PieceBag[player][bag].resize(9)

	_warnErase = PieceSelectedAlready.resize(3)
	for player in range(3):
		PieceSelectedAlready[player] = []
		_warnErase = PieceSelectedAlready[player].resize(9)

	_warnErase = Piece.resize(3)

	_warnErase = NextPiece.resize(3)

	_warnErase = PieceRotation.resize(3)
	_warnErase = PiecePlayfieldX.resize(3)
	_warnErase = PiecePlayfieldY.resize(3)

	_warnErase = PieceDropTimer.resize(3)
	_warnErase = TimeToDropPiece.resize(3)

	_warnErase = PlayerStatus.resize(3)

	_warnErase = PieceDropStartHeight.resize(8)
	PieceDropStartHeight[0] = 0
	PieceDropStartHeight[1] = 4
	PieceDropStartHeight[2] = 4
	PieceDropStartHeight[3] = 4
	PieceDropStartHeight[4] = 4
	PieceDropStartHeight[5] = 4
	PieceDropStartHeight[6] = 3
	PieceDropStartHeight[7] = 5

	_warnErase = PieceBagFirstUse.resize(3)

	_warnErase = PieceMovementDelay.resize(3)

	_warnErase = PieceRotatedOne.resize(3)
	_warnErase = PieceRotatedTwo.resize(3)

	_warnErase = PieceRotatedUp.resize(3)

	_warnErase = Score.resize(3)
	Score[0] = 0
	Score[1] = 0
	Score[2] = 0

	Level = 1

	_warnErase = DropBonus.resize(3)

	_warnErase = AndroidMovePieceDownDelay.resize(3)
	_warnErase = AndroidMovePieceDownPressed.resize(3)
	_warnErase = AndroidMovePieceLeftDelay.resize(3)
	_warnErase = AndroidMovePieceRightDelay.resize(3)

	_warnErase = PlayerInput.resize(3)

	_warnErase = MovePieceCollision.resize(3)
	for player in range(3):
		MovePieceCollision[player] = []
		_warnErase = MovePieceCollision[player].resize(35)
		for x in range(35):
			MovePieceCollision[player][x] = []
			_warnErase = MovePieceCollision[player][x].resize(26)
	
	_warnErase = MovePieceHeight.resize(3)
	for player in range(3):
		MovePieceHeight[player] = []
		_warnErase = MovePieceHeight[player].resize(35)
		for x in range(35):
			MovePieceHeight[player][x] = []
			_warnErase = MovePieceHeight[player][x].resize(26)

	_warnErase = MoveTrappedHoles.resize(3)
	for player in range(3):
		MoveTrappedHoles[player] = []
		MoveTrappedHoles[player].resize(35)
		for x in range(35):
			MoveTrappedHoles[player][x] = []
			MoveTrappedHoles[player][x].resize(26)

	_warnErase = MoveOneBlockCavernHoles.resize(3)
	for player in range(3):
		MoveOneBlockCavernHoles[player] = []
		MoveOneBlockCavernHoles[player].resize(35)
		for x in range(35):
			MoveOneBlockCavernHoles[player][x] = []
			MoveOneBlockCavernHoles[player][x].resize(26)

	_warnErase = MovePlayfieldBoxEdges.resize(3)
	for player in range(3):
		MovePlayfieldBoxEdges[player] = []
		_warnErase = MovePlayfieldBoxEdges[player].resize(35)
		for x in range(35):
			MovePlayfieldBoxEdges[player][x] = []
			_warnErase = MovePlayfieldBoxEdges[player][x].resize(26)

	_warnErase = MoveCompletedLines.resize(3)
	for player in range(3):
		MoveCompletedLines[player] = []
		_warnErase = MoveCompletedLines[player].resize(35)
		for x in range(35):
			MoveCompletedLines[player][x] = []
			_warnErase = MoveCompletedLines[player][x].resize(26)

	_warnErase = BestMoveX.resize(3)
	_warnErase = BestRotation.resize(3)
	_warnErase = MovedToBestMove.resize(3)

	_warnErase = MaxRotationArray.resize(8)
	MaxRotationArray[0] = 0
	MaxRotationArray[1] = 2
	MaxRotationArray[2] = 2
	MaxRotationArray[3] = 4
	MaxRotationArray[4] = 4
	MaxRotationArray[5] = 4
	MaxRotationArray[6] = 1
	MaxRotationArray[7] = 2

	_warnErase = CPUPlayerMovementSkip.resize(3)

	_warnErase = CPUPlayerForcedDirection.resize(3)
	CPUPlayerForcedDirection[0] = CPUForcedFree
	CPUPlayerForcedDirection[1] = CPUForcedFree
	CPUPlayerForcedDirection[2] = CPUForcedFree

	_warnErase = CPUPieceTestX.resize(3)
	_warnErase = CPURotationTest.resize(3)
	_warnErase = CPUComputedBestMove.resize(3)

	_warnErase = pTXStep.resize(3)
	_warnErase = bestValue.resize(3)

	_warnErase = PlayfieldBackup.resize(35)
	for x in range(35):
		PlayfieldBackup[x] = []
		_warnErase = PlayfieldBackup[x].resize(26)
		for y in range(26):
			PlayfieldBackup[x][y] = []

	GameWon = false

	MouseTouchRotateDir = 0

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass
