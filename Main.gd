# Godot Engine v4 Beta 4+

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
#              "Grand National GNX" v2 Godot Engine 4.x 2D Video Game Framework
# ------------------------------------------------------------------------------------------------
#                                 "Fight To Win, Win For Love!"
#  ___________     __         .__  _________ __                         ____ ___________  _   /\TM
#  \__    ___/____/  |________|__|/   _____//  |_  ___________ ___.__. /_   /_   \   _  \/ \ / /
#    |    |_/ __ \   __\_  __ \  |\_____  \\   __\/  _ \_  __ <   |  |  |   ||   /  /_\  \_// /_
#    |    |\  ___/|  |  |  | \/  |/        \|  | (  <_> )  | \/\___  |  |   ||   \  \_/   \/ // \
#    |____| \___  >__|  |__|  |__/_______  /|__|  \____/|__|   / ____|  |___||___|\_____  / / \_/
#               \/                       \/                    \/         15% T U R B O   \/\/
#                                  Version 3.0.0.16 Pre-Beta1of3
#
#          HTML5 Enabled Desktop/Laptop Internet Browsers & Android Smartphones/Tablets
#
#                             (C)opyright 2023 - Team "BetaMax Heroes"
# ------------------------------------------------------------------------------------------------

#- [DONE?] Perfect single player game [DONE?] -
#- [DONE!] Level progression [DONE!] -
#- [DONE!] Cut scenes [DONE!] -
#- Perfect multi player game -
#- Perfect computer A.I. player[s] -
#- [DONE!] New high score name input [DONE!] -
#- [DONE!] Full music soundtrack [DONE!] -
#- [DONE!] Ending [DONE!] -
#- Thorough testing of final beta version -

# Pre-Beta2of3:
# - Fixed screen jitter when a new line is placed at bottom of playfield when playing
# - Optimized playing game screen by about 15% - needs further optimizations
# - Created 10 second average Frames Per Second calculated display
# - Fixed drop shadow(s) when adding an incomplete line to the bottom of playfield
# - Working on controllers: they don't work on HTML5 yet?
# - 
# - [NOT DONE!]
# - 

# Pre-Beta1of3:
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
	Engine.max_fps = 30

	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		VisualsCore.KeepAspectRatio = 0
	else:
		VisualsCore.KeepAspectRatio = 1

	DataCore.LoadOptionsAndHighScores()

	VisualsCore.SetScreenStretchMode()

	randomize()

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	ScreensCore.ProcessScreenToDisplay()

	pass

# A 110% By Team "BetaMax Heroes"!
