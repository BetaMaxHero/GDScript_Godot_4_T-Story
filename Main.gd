# Beta 2 Until Beta 4:
# "target_fps" to "max_fps"

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
#               \/                       \/                    \/                       \/\/
#                                    Version 3.0.0.7 AlphaF6
#
#          HTML5 Enabled Desktop/Laptop Internet Browsers & Android Smartphones/Tablets
#
#                             (C)opyright 2023 - Team "BetaMax Heroes"
# ------------------------------------------------------------------------------------------------

#- [DONE!] Perfect single player game [DONE!] -
#- [DONE!] Level progression [DONE!] -
#- [DONE!] Cut scenes [DONE!] -
#- Perfect multi player game -
#- Perfect computer A.I. player[s] -
#- New high score name input -
#- [DONE!] Full music soundtrack [DONE!] -
#- [DONE!] Ending [DONE!] -
#- Thorough testing of final beta version -


extends Node2D

#----------------------------------------------------------------------------------------
func _ready():
	Engine.target_fps = 30

	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		VisualsCore.KeepAspectRatio = 0
	else:
		VisualsCore.KeepAspectRatio = 1

	DataCore.LoadOptionsAndHighScores()

#	# Invalid get index 'CONTENT_SCALE_MODE_VIEWPORT' (on base: 'SceneTree').
#	get_tree().set_content_scale_mode(SceneTree.CONTENT_SCALE_MODE_VIEWPORT)
#	if (VisualsCore.KeepAspectRatio == 0):
#		get_tree().set_content_scale_aspect(SceneTree.CONTENT_SCALE_ASPECT_KEEP_WIDTH)
#	elif (VisualsCore.KeepAspectRatio == 1):
#		# Invalid get index 'CONTENT_SCALE_ASPECT_IGNORE' (on base: 'SceneTree').		
#		get_tree().set_content_scale_aspect(SceneTree.CONTENT_SCALE_ASPECT_IGNORE)

	randomize()

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	ScreensCore.ProcessScreenToDisplay()

	pass

# A 110% By Team "BetaMax Heroes"!
