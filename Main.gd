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
#
# ------------------------------------------------------------------------------------------------
#                              Cross-Platform / M.I.T. Open-Source
#             "Grand National GNX" v2 Godot Engine 4.0 Beta 8 2D Video Game Framework
# ------------------------------------------------------------------------------------------------
#                                 "Fight To Win, Win For Love!"
#  ___________     __         .__  _________ __                         ____ ___________  _   /\TM
#  \__    ___/____/  |________|__|/   _____//  |_  ___________ ___.__. /_   /_   \   _  \/ \ / /
#    |    |_/ __ \   __\_  __ \  |\_____  \\   __\/  _ \_  __ <   |  |  |   ||   /  /_\  \_// /_
#    |    |\  ___/|  |  |  | \/  |/        \|  | (  <_> )  | \/\___  |  |   ||   \  \_/   \/ // \
#    |____| \___  >__|  |__|  |__/_______  /|__|  \____/|__|   / ____|  |___||___|\_____  / / \_/
#               \/                       \/                    \/        100% T U R B O \/\/
#                                                      TM
#                                      "TetriStory 110%"
#                                 @>-/---------- ---------\-<@
#                                   Version 3.0.0.23 Beta 1
#                                   ____       __           ___
#                                  / __ )___  / /_____ _   <  /
#                                 / __  / _ \/ __/ __ `/   / / 
#                                / /_/ /  __/ /_/ /_/ /   / /  
#                               /_____/\___/\__/\__,_/   /_/                            
#
#          HTML5 Enabled Desktop/Laptop Internet Browsers & Android Smartphones/Tablets
#
#                            (C)opyright 2023 - Team "BetaMax Heroes"
# ------------------------------------------------------------------------------------------------

#- [DONE!] Perfect single player game [DONE!] -
#- [DONE!] Level progression [DONE!] -
#- [DONE!] Cut scenes [DONE!] -
#- [DONE?] Perfect multi player game [DONE?] -
#- Perfect computer A.I. player[s] -
#- [DONE!] New high score name input [DONE!] -
#- [DONE!] Full music soundtrack [DONE!] -
#- [DONE!] Ending [DONE!] -
#- Thorough testing of final beta version -

# Beta 1:
# - Fixed screen jitter when a new line is placed at bottom of playfield when playing
# - Optimized playing game screen by about 15% - needs further optimizations
# - Created 10 second average Frames Per Second calculated display
# - Fixed drop shadow(s) when adding an incomplete line to the bottom of playfield
# - Fixed game controllers - d-pad does not work on HTML5 yet(use left analog stick)
# - Fixed false game overs when playinghttps://github.com/BetaMaxHero/C_PlusPlus_SDL2_T-Crisis_4
# - Fixed infrequent incorrect placement of text
# - Fixed missing Act 9 cutscene images
# - Fixed crash in new high score name input screen
# - Game turbocharger 100% operational
# - Perfected computer player(s) A.I. ? NEEDS WORK!
# - 
# - NOT DONE

# Pre-Beta1
# - Fixed configure controller(s) text position in [Options] screen
# - Fixed warnings/errors when running the game in the IDE
# - Fixed centering of scaled GUI arrow set arrows
# - Fixed scaling of icon characters on new high score name input screen
# - Fixed controller(s) not highlighting [Exit] button on new high score name input screen
# - Fixed [<] (backspace) button disappearing on new high score name input screen
# - Fixed playfield sprite overlap of box sprites in playing game screen
# - Fixed lost game data by saving game options/high scores when displaying title screen
# - Mapped pause key from [P] to [Spacebar] when in playing game screen
# - Mapped secondary rotate key from [Alt] to [Shift] when in playing game screen
# - Added "Game Paused" text/background when in playing game screen

extends Node2D

#----------------------------------------------------------------------------------------
func _ready():
	Engine.physics_ticks_per_second = 30

	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		VisualsCore.KeepAspectRatio = 0
	else:
		VisualsCore.KeepAspectRatio = 1

	DataCore.LoadOptionsAndHighScores()

	VisualsCore.SetScreenStretchMode()

	randomize()

	pass

#----------------------------------------------------------------------------------------
func  _physics_process(_delta):

	ScreensCore.ProcessScreenToDisplay()

	pass

# A 110% By Team "BetaMax Heroes"!
