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

var Version = "Version 3.0.0.5 - Alpha3 Of Pre-Beta1of3"

const ChildMode				= 0
const TeenMode				= 1
const AdultMode				= 2
var GameMode = AdultMode

var AllowComputerPlayers = 0

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

#----------------------------------------------------------------------------------------
func InitializePieceData():
	PieceData.resize(8)
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
			for y in range(9, 24):#20, 24):
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

	if LogicCore.SecretCodeCombined == 8888:
		Piece[1] = 7
		for index in range(0, 8):
			PieceBag[1][0][index] = 7

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

#	pass

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

#	pass

#----------------------------------------------------------------------------------------
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

#	pass

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

#	pass

#----------------------------------------------------------------------------------------
func RotatePieceCounterClockwise(player):
	if PieceRotation[player] > 1:
		PieceRotation[player]-=1
	else:
		PieceRotation[player] = 4

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		return(true)
	else:
		if PieceRotation[player] < 4:
			PieceRotation[player]+=1
		else:
			PieceRotation[player] = 1

#		if (PlayerData[Player].RotateDirection == 0)  PlayerData[Player].RotateDirection = 1;
#        else  PlayerData[Player].RotateDirection = 0;

	return(false)

#	pass

#----------------------------------------------------------------------------------------
func RotatePieceClockwise(player):
	if PieceRotation[player] < 4:
		PieceRotation[player]+=1
	else:
		PieceRotation[player] = 1

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		return(true)
	else:
		if PieceRotation[player] > 1:
			PieceRotation[player]-=1
		else:
			PieceRotation[player] = 4

#		if (PlayerData[Player].RotateDirection == 0)  PlayerData[Player].RotateDirection = 1;
#        else  PlayerData[Player].RotateDirection = 0;

	return(false)

#	pass

#----------------------------------------------------------------------------------------
func AddPieceToPlayfieldMemory(player, TempOrCurrentOrNextOrDropShadowOrFallen):
	var TEMP_Piece = Piece[player]
	var TEMP_PieceRotation = PieceRotation[player]
	var TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
	var TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

	var value = (Piece[player] + 10)

	if (TempOrCurrentOrNextOrDropShadowOrFallen == Fallen):
		value = (Piece[player] + 30)
	elif TempOrCurrentOrNextOrDropShadowOrFallen == Next:
		DrawEverything = true
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
func DeletePieceFromPlayfieldMemory(player, CurrentOrNextOrDropShadow):
	if (PlayerStatus[player] == FlashingCompletedLines || PlayerStatus[player] == ClearingCompletedLines):
		return

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
			DrawEverything = true
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

			DrawEverything = true

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
		DrawEverything = true
		SetupNewPiece(player)
		PlayerStatus[player] = NewPieceDropping

	pass

#----------------------------------------------------------------------------------------
func CheckForCompletedLines(player):
	var numberOfCompletedLines = 0

	DrawEverything = true

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
			TotalLines+=1
#            TotalOneLines++;
		elif (numberOfCompletedLines == 2):
			Score[player] += (100 * (Level+1))
			TotalLines+=2
#            TotalTwoLines++;
		elif (numberOfCompletedLines == 3):
			Score[player] += (300 * (Level+1))
			TotalLines+=3
#            TotalThreeLines++;
		elif (numberOfCompletedLines == 4):
			Score[player] += (1200 * (Level+1))
			TotalLines+=4
#            TotalFourLines++;
#			audio->PlayDigitalSoundFX(7, 0);
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
	
	DeletePieceFromPlayfieldMemory(player, Current)

	PiecePlayfieldY[player]+=1

	if PieceCollision(player) == CollisionWithPlayfield:
		CPUComputedBestMove[player] = false
		
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
			PlayerStatus[player] = GameOver
		else:
			CheckForCompletedLines(player)

	pass

#----------------------------------------------------------------------------------------
func MovePieceLeft(player):
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] > -6:
			PieceMovementDelay[player]-=1
		
		if (PieceMovementDelay[player] == -1 || PieceMovementDelay[player] < -5):
			PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]+=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceLeftDelay[player] == 1 || AndroidMovePieceLeftDelay[player] == 10 || AndroidMovePieceLeftDelay[player] == 16 || AndroidMovePieceLeftDelay[player] == 19 || AndroidMovePieceLeftDelay[player] > 20):
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
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] < 6:
			PieceMovementDelay[player]+=1
		
		if (PieceMovementDelay[player] == 1 || PieceMovementDelay[player] > 5):
			PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]-=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceRightDelay[player] == 1 || AndroidMovePieceRightDelay[player] == 10 || AndroidMovePieceRightDelay[player] == 16 || AndroidMovePieceRightDelay[player] == 19 || AndroidMovePieceRightDelay[player] > 20):
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
	if GameMode == ChildMode:
		Engine.target_fps = 30
	elif GameMode == TeenMode:
		Engine.target_fps = 60
	elif GameMode == AdultMode:
		Engine.target_fps = 45

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

	DrawEverything = true

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
	pass

#----------------------------------------------------------------------------------------
func SetupForNewLevel():
	if (Level == 1 or SecretCodeCombined == 6161):
		return
	
	if GameMode == ChildMode:
		Engine.target_fps = 30
	elif GameMode == TeenMode:
		Engine.target_fps = 60
	elif GameMode == AdultMode:
		Engine.target_fps = 45

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

	DrawEverything = true

	for index in range(0, 4):
		InterfaceCore.Icons.IconAnimationTimer[index] = -1

	PlayersCanJoinIn = false

	TotalLines = 0
	LevelCleared = false

	AddRandomBlocksToBottomTimer = 0

	pass

#----------------------------------------------------------------------------------------
func ComputeComputerPlayerMove(player):
	if (CPUComputedBestMove[player] == false):
		MovedToBestMove[player] = false

		var TEMP_PieceRotation
		var TEMP_PiecePlayfieldX
		var TEMP_PiecePlayfieldY

		if (CPUPlayerForcedDirection[player] == CPUForcedLeft):
			pTXStep[player] = -1
		elif (CPUPlayerForcedDirection[player] == CPUForcedRight):
			pTXStep[player] = 1
		else:
			pTXStep[player] = 1

		if (CPURotationTest[player] < MaxRotationArray[Piece[player]]):
			CPURotationTest[player]+=1
		else:
			CPURotationTest[player] = 1

			if (pTXStep[player] == -1):
				if (CPUPieceTestX[player] > 0):
					CPUPieceTestX[player]-=1
				else:
					if (CPURotationTest[player] == 1):
						CPUComputedBestMove[player] = true
			elif (pTXStep[player] == 1):
				if (CPUPieceTestX[player] < 31):
					CPUPieceTestX[player]+=1
				else:
					if (CPURotationTest[player] == 1):
						CPUComputedBestMove[player] = true

		TEMP_PieceRotation = PieceRotation[player]
		TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
		TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

		PiecePlayfieldX[player] = CPUPieceTestX[player]
		PieceRotation[player] = CPURotationTest[player]

		MovePieceCollision[player][CPUPieceTestX[player]][CPURotationTest[player]] = false
		MovePieceHeight[player][CPUPieceTestX[player]][CPURotationTest[player]] = 0
		if (PieceCollision(player) ==  CollisionNotTrue):
			for posY in range(PiecePlayfieldY[player], 23):
				PiecePlayfieldY[player] = posY
				if (PieceCollision(player) != CollisionNotTrue):
					if ( PieceCollision(player) == CollisionWithPlayfield ):
						PiecePlayfieldY[player] = (posY-1)
						MovePieceHeight[player][CPUPieceTestX[player]][CPURotationTest[player]] = PiecePlayfieldY[player]
						break
					elif ( PieceCollision(player) == CollisionWithPiece ):
						MovePieceCollision[player][CPUPieceTestX[player]][CPURotationTest[player]] = true

			AddPieceToPlayfieldMemory(player, Fallen)

			MoveTrappedHoles[player][CPUPieceTestX[player]][CPURotationTest[player]] = 0
			for posX in range(2, 32):
				var numberOfEmpties = 0
				for posY in range(22, 4, -1):
					if (Playfield[posX][posY] == 0):
						numberOfEmpties+=1
					elif (Playfield[posX][posY] > 30 && Playfield[posX][posY] < 40):
						MoveTrappedHoles[player][CPUPieceTestX[player]][CPURotationTest[player]]+=numberOfEmpties
						numberOfEmpties = 0

			MoveCompletedLines[player][CPUPieceTestX[player]][CPURotationTest[player]] = 0
			MovePlayfieldBoxEdges[player][CPUPieceTestX[player]][CPURotationTest[player]] = 0
			for posY in range(5, 23):
				var boxTotal = 0
				for posX in range(0, 32):
					if ( (Playfield[posX][posY] > 30 && Playfield[posX][posY] < 40) || Playfield[posX][posY] == 255 ):
						if (Playfield[posX][posY] != 255):
							boxTotal+=1

						if (Playfield[posX][(posY-1)] == 0):
							MovePlayfieldBoxEdges[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

						if (Playfield[posX][(posY+1)] == 0):
							MovePlayfieldBoxEdges[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

						if (Playfield[(posX-1)][posY] == 0):
							MovePlayfieldBoxEdges[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

						if (Playfield[(posX+1)][posY] == 0):
							MovePlayfieldBoxEdges[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

				if (boxTotal == 30):
					MoveCompletedLines[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

			MoveOneBlockCavernHoles[player][CPUPieceTestX[player]][CPURotationTest[player]] = 0
			for posY in range(5, 23):
				for posX in range(2, 32):
					if (Playfield[posX][posY] == 0 && Playfield[(posX-1)][posY] != 0 && Playfield[(posX+1)][posY] != 0):
						MoveOneBlockCavernHoles[player][CPUPieceTestX[player]][CPURotationTest[player]]+=1

			DeletePieceFromPlayfieldMemory(player, Current)
		else:
			MovePieceCollision[player][CPUPieceTestX[player]][CPURotationTest[player]] = true

		PieceRotation[player] = TEMP_PieceRotation
		PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
		PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

		var posX = CPUPieceTestX[player]
		var rot = CPURotationTest[player]
		if (MovePieceCollision[player][posX][rot] == false):
			MovePieceHeight[player][posX][rot]+=MoveCompletedLines[player][posX][rot]

			var testValue
#           --[JeZxLee's "Gift Of Sight" Tetri A.I. Algorithm ~400,000+]------------------------------------
			testValue = ( (3*MoveTrappedHoles[player][posX][rot])
			+(1*MoveOneBlockCavernHoles[player][posX][rot])
			+(1*MovePlayfieldBoxEdges[player][posX][rot])
			-(1*MovePieceHeight[player][posX][rot]) )
#           ------------------------------------[JeZxLee's "Gift Of Sight" Tetri A.I. Algorithm ~400,000+]--

			if (testValue <= bestValue[player]):
				bestValue[player] = testValue
				BestMoveX[player] = posX
				BestRotation[player] = rot
	elif (MovedToBestMove[player] == false && BestMoveX[player] != -1 && BestRotation[player] != -1):
		if (PieceRotation[player] < BestRotation[player]):
			RotatePieceClockwise(player)
		elif (PieceRotation[player] > BestRotation[player]):
			RotatePieceCounterClockwise(player)

		if (BestMoveX[player] < PiecePlayfieldX[player]):
			if ( PieceCollisionLeft(player) != CollisionWithPiece && PieceCollisionLeft(player) != CollisionWithPlayfield):
				MovePieceLeft(player)
			else:
				CPUPlayerForcedDirection[player] = CPUForcedRight
				CPUPieceTestX[player] = PiecePlayfieldX[player]
				CPURotationTest[player] = 1
				bestValue[player] = 999999
				BestMoveX[player] = -1
				BestRotation[player] = -1
				MovedToBestMove[player] = false
				CPUComputedBestMove[player] = false
		elif (BestMoveX[player] > PiecePlayfieldX[player]):
			if ( PieceCollisionRight(player) != CollisionWithPiece && PieceCollisionRight(player) != CollisionWithPlayfield):
				MovePieceRight(player)
			else:
				CPUPlayerForcedDirection[player] = CPUForcedLeft
				CPUPieceTestX[player] = PiecePlayfieldX[player]
				CPURotationTest[player] = 1
				bestValue[player] = 999999
				BestMoveX[player] = -1
				BestRotation[player] = -1
				MovedToBestMove[player] = false
				CPUComputedBestMove[player] = false
		elif (PieceRotation[player] == BestRotation[player]):
			var TEMP_PieceRotation = PieceRotation[player]
			var TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
			var TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

			for posY in range(PiecePlayfieldY[player], 23):
				PiecePlayfieldY[player] = posY
				if (PieceCollision(player) == CollisionWithPiece):
					CPUPieceTestX[player] = PiecePlayfieldX[player]
					CPURotationTest[player] = 1
					bestValue[player] = 999999
					BestMoveX[player] = -1
					BestRotation[player] = -1
					MovedToBestMove[player] = false
					CPUComputedBestMove[player] = false

			PieceRotation[player] = TEMP_PieceRotation
			PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
			PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

			if ( (BestMoveX[player] != -1 && BestRotation[player] != -1) &&  PieceCollisionDown(player) != CollisionWithPiece ):
				MovePieceDown(player, true);
				MovedToBestMove[player] = true
	elif (BestMoveX[player] != -1 && BestRotation[player] != -1):
		if ( PieceCollisionDown(player) != CollisionWithPiece ):
			MovePieceDown(player, false)
	else:
		print("Confused???")

	pass

#----------------------------------------------------------------------------------------
func AddRandomBlocksToBottom():
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

	for y in range(7, 24):
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

	DrawEverything = true

	pass

#----------------------------------------------------------------------------------------
func RunTetriGameEngine():
	if PAUSEgame == false:
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

		for player in range(0, 3):
			Player = player

			if (player == 0):
				var piecesAreFalling = true
				if (PlayerStatus[0] != PieceFalling && PlayerStatus[0] != GameOver):
					piecesAreFalling = false
				if (PlayerStatus[1] != PieceFalling && PlayerStatus[1] != GameOver):
					piecesAreFalling = false
				if (PlayerStatus[2] != PieceFalling && PlayerStatus[2] != GameOver):
					piecesAreFalling = false

				if (piecesAreFalling == true):
					AddRandomBlocksToBottomTimer+=1

					var timeForCrisis = 375
					if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
						timeForCrisis+=175

					if (AddRandomBlocksToBottomTimer > timeForCrisis):
						AddRandomBlocksToBottom()
						AddRandomBlocksToBottomTimer = 0

			var playerHasCompletedLine = false
			if (PlayerStatus[0] == FlashingCompletedLines || PlayerStatus[0] == ClearingCompletedLines):
				playerHasCompletedLine = true
			if (PlayerStatus[1] == FlashingCompletedLines || PlayerStatus[1] == ClearingCompletedLines):
				playerHasCompletedLine = true
			if (PlayerStatus[2] == FlashingCompletedLines || PlayerStatus[2] == ClearingCompletedLines):
				playerHasCompletedLine = true

			if (playerHasCompletedLine == false):
				if PlayerStatus[0] == PieceFalling:
					if player != 0:
						AddPieceToPlayfieldMemory(0, Temp)
				if PlayerStatus[1] == PieceFalling:
					if player != 1:
						AddPieceToPlayfieldMemory(1, Temp)
				if PlayerStatus[2] == PieceFalling:
					if player != 2:
						AddPieceToPlayfieldMemory(2, Temp)

				if PlayerStatus[player] != GameOver && playerHasCompletedLine == false:
					if SecretCodeCombined != 8888 && SecretCodeCombined != 8889 && SecretCodeCombined != 3777:
						PieceDropTimer[player]+=1
					
					if PlayerStatus[player] == NewPieceDropping:
						if PiecePlayfieldY[player] < PieceDropStartHeight[ Piece[player] ]:
							if (PieceCollisionDown(player) != CollisionWithPiece):
								MovePieceDown(player, true)
						else:
							AddPieceToPlayfieldMemory(player, Next)
							PlayerStatus[player] = PieceFalling
					elif PlayerStatus[player] == PieceFalling:
						if (PlayerInput[player] == InputCore.InputCPU && AllowComputerPlayers > 0):
							ComputeComputerPlayerMove(player)
						elif (PlayerInput[player] == InputCore.InputKeyboard || PlayerInput[player] == InputCore.InputJoyOne || PlayerInput[player] == InputCore.InputJoyTwo || PlayerInput[player] == InputCore.InputJoyThree):
							if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
								if PieceDropTimer[player] > TimeToDropPiece[player]:
									if PieceCollisionDown(player) != CollisionWithPiece:
										if (InputCore.JoystickDirection[PlayerInput[player]] != InputCore.JoyDown):
											AudioCore.PlayEffect(3)
										
										MovePieceDown(player, false)
										PieceDropTimer[player] = 0

								if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyLeft):
									MovePieceLeft(player)
								elif (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyRight):
									MovePieceRight(player)
								else:
									PieceMovementDelay[player] = 0

								if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyUp):
									if PieceRotatedUp[player] == false:
										RotatePieceClockwise(player)
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
										RotatePieceClockwise(player)
										PieceRotatedOne[player] = true
								else:
									PieceRotatedOne[player] = false

								if InputCore.JoyButtonTwo[PlayerInput[player]] == InputCore.Pressed:
									if PieceRotatedTwo[player] == false:
										RotatePieceCounterClockwise(player)
										PieceRotatedTwo[player] = true
								else:
									PieceRotatedTwo[player] = false
						elif (PlayerInput[player] == InputCore.InputTouchOne):
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
									RotatePieceClockwise(player)
									PieceRotatedOne[player] = true
							else:
								PieceRotatedOne[player] = false
						elif (PlayerInput[player] == InputCore.InputMouse):
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
										RotatePieceClockwise(player)
										PieceRotatedOne[player] = true
								else:
									PieceRotatedOne[player] = false
						elif (PlayerInput[player] == InputCore.InputTouchTwo):
							if PieceDropTimer[player] > TimeToDropPiece[player]:
								if PieceCollisionDown(player) != CollisionWithPiece:
									if DropBonus[player] == 0:
										AudioCore.PlayEffect(3)

									MovePieceDown(player, false)
									PieceDropTimer[player] = 0

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
									RotatePieceClockwise(player)
									PieceRotatedOne[player] = true
							else:
								PieceRotatedOne[player] = false

				playerHasCompletedLine = false
				if (PlayerStatus[0] == FlashingCompletedLines || PlayerStatus[0] == ClearingCompletedLines):
					playerHasCompletedLine = true
				if (PlayerStatus[1] == FlashingCompletedLines || PlayerStatus[1] == ClearingCompletedLines):
					playerHasCompletedLine = true
				if (PlayerStatus[2] == FlashingCompletedLines || PlayerStatus[2] == ClearingCompletedLines):
					playerHasCompletedLine = true

				if (playerHasCompletedLine == false):
					if PlayerStatus[0] == PieceFalling:
						if player != 0:
							DeletePieceFromPlayfieldMemory(0, Current)
					if PlayerStatus[1] == PieceFalling:
						if player != 1:
							DeletePieceFromPlayfieldMemory(1, Current)
					if PlayerStatus[2] == PieceFalling:
						if player != 2:
							DeletePieceFromPlayfieldMemory(2, Current)

				if (TotalLines > 10):
					InputCore.DelayAllUserInput = 25
					ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
					ScreensCore.ScreenToDisplayNext = ScreensCore.CutSceneScreen
					Level+=1
					ScreensCore.CutSceneScene = 1
					Engine.target_fps = 30
					LevelCleared = true
					
					if (LogicCore.Level == 2):
						AudioCore.PlayMusic(2)
					elif (LogicCore.Level == 3):
						AudioCore.PlayMusic(3)
					elif (LogicCore.Level == 4):
						AudioCore.PlayMusic(4)
					elif (LogicCore.Level == 5):
						AudioCore.PlayMusic(5)
					elif (LogicCore.Level == 6):
						AudioCore.PlayMusic(6)
					elif (LogicCore.Level == 7):
						AudioCore.PlayMusic(7)
					elif (LogicCore.Level == 8):
						AudioCore.PlayMusic(8)
					elif (LogicCore.Level == 9):
						AudioCore.PlayMusic(9)

					if (Level == 10):
						InputCore.DelayAllUserInput = 100
						StillPlaying = false
						GameWon = true
						Engine.target_fps = 30
#						AudioCore.PlayMusic(10)
						ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
						ScreensCore.ScreenToDisplayNext = ScreensCore.WonGameScreen

						SecretCode[0] = 5
						SecretCode[1] = 4
						SecretCode[2] = 3
						SecretCode[3] = 1
						SecretCodeCombined = (SecretCode[0]*1000)+(SecretCode[1]*100)+(SecretCode[2]*10)+(SecretCode[3]*1)

				if (PlayerStatus[0] == GameOver && PlayerStatus[1] == GameOver && PlayerStatus[2] == GameOver):
					Engine.target_fps = 60
					AudioCore.PlayMusic(0)

					StillPlaying = false

					ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
			else:
				if (PlayerStatus[player] == FlashingCompletedLines):
					FlashCompletedLines(player)
				elif (PlayerStatus[player] == ClearingCompletedLines):
					ClearCompletedLines(player)

	pass

#----------------------------------------------------------------------------------------
func _ready():
	SecretCode.append(2)
	SecretCode.append(7)
	SecretCode.append(7)
	SecretCode.append(7)
	
	LogicCore.SecretCodeCombined = 2777

	InitializePieceData()

	Playfield.resize(35)
	for x in range(35):
		Playfield[x] = []
		Playfield[x].resize(26)
		for y in range(26):
			Playfield[x][y] = []

	PlayfieldMoveAI.resize(35)
	for x in range(35):
		PlayfieldMoveAI[x] = []
		PlayfieldMoveAI[x].resize(26)
		for y in range(26):
			PlayfieldMoveAI[x][y] = []

	PieceBagIndex.resize(3)

	PieceBag.resize(3)
	for player in range(3):
		PieceBag[player] = []
		PieceBag[player].resize(2)
		for bag in range(2):
			PieceBag[player][bag] = []
			PieceBag[player][bag].resize(9)

	PieceSelectedAlready.resize(3)
	for player in range(3):
		PieceSelectedAlready[player] = []
		PieceSelectedAlready[player].resize(9)

	Piece.resize(3)
	NextPiece.resize(3)

	PieceRotation.resize(3)
	PiecePlayfieldX.resize(3)
	PiecePlayfieldY.resize(3)

	PieceDropTimer.resize(3)
	TimeToDropPiece.resize(3)

	PlayerStatus.resize(3)

	PieceDropStartHeight.resize(8)
	PieceDropStartHeight[0] = 0
	PieceDropStartHeight[1] = 4
	PieceDropStartHeight[2] = 4
	PieceDropStartHeight[3] = 4
	PieceDropStartHeight[4] = 4
	PieceDropStartHeight[5] = 4
	PieceDropStartHeight[6] = 3
	PieceDropStartHeight[7] = 5

	PieceBagFirstUse.resize(3)

	PieceMovementDelay.resize(3)

	PieceRotatedOne.resize(3)
	PieceRotatedTwo.resize(3)

	PieceRotatedUp.resize(3)

	Score.resize(3)
	Score[0] = 0
	Score[1] = 0
	Score[2] = 0

	Level = 1

	DropBonus.resize(3)

	AndroidMovePieceDownDelay.resize(3)
	AndroidMovePieceDownPressed.resize(3)
	AndroidMovePieceLeftDelay.resize(3)
	AndroidMovePieceRightDelay.resize(3)

	PlayerInput.resize(3)

	MovePieceCollision.resize(3)
	for player in range(3):
		MovePieceCollision[player] = []
		MovePieceCollision[player].resize(35)
		for x in range(35):
			MovePieceCollision[player][x] = []
			MovePieceCollision[player][x].resize(26)

	MovePieceHeight.resize(3)
	for player in range(3):
		MovePieceHeight[player] = []
		MovePieceHeight[player].resize(35)
		for x in range(35):
			MovePieceHeight[player][x] = []
			MovePieceHeight[player][x].resize(26)

	MoveTrappedHoles.resize(3)
	for player in range(3):
		MoveTrappedHoles[player] = []
		MoveTrappedHoles[player].resize(35)
		for x in range(35):
			MoveTrappedHoles[player][x] = []
			MoveTrappedHoles[player][x].resize(26)

	MoveOneBlockCavernHoles.resize(3)
	for player in range(3):
		MoveOneBlockCavernHoles[player] = []
		MoveOneBlockCavernHoles[player].resize(35)
		for x in range(35):
			MoveOneBlockCavernHoles[player][x] = []
			MoveOneBlockCavernHoles[player][x].resize(26)

	MovePlayfieldBoxEdges.resize(3)
	for player in range(3):
		MovePlayfieldBoxEdges[player] = []
		MovePlayfieldBoxEdges[player].resize(35)
		for x in range(35):
			MovePlayfieldBoxEdges[player][x] = []
			MovePlayfieldBoxEdges[player][x].resize(26)

	MoveCompletedLines.resize(3)
	for player in range(3):
		MoveCompletedLines[player] = []
		MoveCompletedLines[player].resize(35)
		for x in range(35):
			MoveCompletedLines[player][x] = []
			MoveCompletedLines[player][x].resize(26)

	BestMoveX.resize(3)
	BestRotation.resize(3)
	MovedToBestMove.resize(3)

	MaxRotationArray.resize(8)
	MaxRotationArray[0] = 0
	MaxRotationArray[1] = 2
	MaxRotationArray[2] = 2
	MaxRotationArray[3] = 4
	MaxRotationArray[4] = 4
	MaxRotationArray[5] = 4
	MaxRotationArray[6] = 1
	MaxRotationArray[7] = 2

	CPUPlayerMovementSkip.resize(3)

	CPUPlayerForcedDirection.resize(3)
	CPUPlayerForcedDirection[0] = CPUForcedFree
	CPUPlayerForcedDirection[1] = CPUForcedFree
	CPUPlayerForcedDirection[2] = CPUForcedFree

	CPUPieceTestX.resize(3)
	CPURotationTest.resize(3)
	CPUComputedBestMove.resize(3)

	pTXStep.resize(3)
	bestValue.resize(3)

	PlayfieldBackup.resize(35)
	for x in range(35):
		PlayfieldBackup[x] = []
		PlayfieldBackup[x].resize(26)
		for y in range(26):
			PlayfieldBackup[x][y] = []

	GameWon = false

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass
