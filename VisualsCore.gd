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

# "VisualsCore.gd"
#extends Node
extends Node2D

var DEBUG = true
var FramesPerSecondText

var ScreenWidth = 1024
var ScreenHeight = 640

class SpriteClass:
	var ci_rid = []
	var SpriteImage = []
	var SpriteImageWidth = []
	var SpriteImageHeight = []
	var SpriteActive = []
	var SpriteScreenX = []
	var SpriteScreenY = []
	var SpriteScaleX = []
	var SpriteScaleY = []
	var SpriteRotation = []
	var SpriteColorRed = []
	var SpriteColorGreen = []
	var SpriteColorBlue = []
	var SpriteColorAlpha = []
var Sprites = SpriteClass.new()

var FontTTF = []

var TextCurrentIndex;

class TextClass:
	var TextImage = []
	var TextIndex = []
	var TextScreenX = []
	var TextScreenY = []
	var TextHorizontalJustification = []
	var TextSize = []
	var TextScaleX = []
	var TextScaleY = []
	var TextRotation = []
	var TextColorRed  = []
	var TextColorGreen = []
	var TextColorBlue = []
	var TextColorAlpha = []
	var TextOutlineRed = []
	var TextOutlineGreen = []
	var TextOutlineBlue = []
var Texts = TextClass.new()

class AboutText:
	var AboutTextsText = []
	var AboutTextsBlue = []
var AboutTexts = AboutText.new()

var AboutTextsStartIndex
var AboutTextsEndIndex

var PieceSpriteCurrentIndex = []
var PlayfieldSpriteCurrentIndex = []

var KeyboardControlsAlphaTimer;

var KeepAspectRatio

#----------------------------------------------------------------------------------------
func _ready():
	for _index in range(0, 20000):
		Sprites.ci_rid.append(-1)
		Sprites.ci_rid[_index] = RenderingServer.canvas_item_create()
		RenderingServer.canvas_item_set_parent(Sprites.ci_rid[_index], get_canvas_item())
		Sprites.SpriteImage.append(-1)
		Sprites.SpriteImageWidth.append(0)
		Sprites.SpriteImageHeight.append(0)
		Sprites.SpriteActive.append(false)
		Sprites.SpriteScreenX.append(-99999)
		Sprites.SpriteScreenY.append(-99999)
		Sprites.SpriteScaleX.append(1.0)
		Sprites.SpriteScaleY.append(1.0)
		Sprites.SpriteRotation.append(0)
		Sprites.SpriteColorRed.append(1.0)
		Sprites.SpriteColorGreen.append(1.0)
		Sprites.SpriteColorBlue.append(1.0)
		Sprites.SpriteColorAlpha.append(1.0)
	
	Sprites.SpriteImage[0] = load("res://media/images/backgrounds/FadingBlackBG.png")
	Sprites.SpriteActive[0] = true

	Sprites.SpriteImage[5] = load("res://media/images/logos/GodotLogo.png")
	Sprites.SpriteActive[5] = true

	Sprites.SpriteImage[10] = load("res://media/images/backgrounds/BG_Title.png")
	Sprites.SpriteActive[10] = true

	Sprites.SpriteImage[13] = load("res://media/images/gui/MoreFreeGames.png")
	Sprites.SpriteActive[13] = true

	Sprites.SpriteImage[14] = load("res://media/images/gui/SourceCode.png")
	Sprites.SpriteActive[14] = true

	Sprites.SpriteImage[20] = load("res://media/images/logos/Logo.png")
	Sprites.SpriteActive[20] = true

	Sprites.SpriteImage[21] = load("res://media/images/logos/Logo2.png")
	Sprites.SpriteActive[21] = true

	Sprites.SpriteImage[23] = load("res://media/images/backgrounds/TS1.png")
	Sprites.SpriteActive[23] = true

	Sprites.SpriteImage[25] = load("res://media/images/logos/GooglePlayLogo.png")
	Sprites.SpriteActive[25] = true

	for index in range(30, 40):
		Sprites.SpriteImage[index] = load("res://media/images/gui/ScreenLine.png")
		Sprites.SpriteActive[index] = true

	for index in range(40, 50):
		Sprites.SpriteImage[index] = load("res://media/images/gui/Button.png")
		Sprites.SpriteActive[index] = true

	Sprites.SpriteImage[50] = load("res://media/images/gui/ButtonSelectorLeft.png")
	Sprites.SpriteActive[50] = true
	Sprites.SpriteImage[51] = load("res://media/images/gui/ButtonSelectorRight.png")
	Sprites.SpriteActive[51] = true

	Sprites.SpriteImage[60] = load("res://media/images/gui/SelectorLine.png")
	Sprites.SpriteActive[60] = true

	for index in range(80, 100, 2):
		Sprites.SpriteImage[index] = load("res://media/images/gui/ButtonSelectorLeft.png")
		Sprites.SpriteActive[index] = true
		Sprites.SpriteImage[index+1] = load("res://media/images/gui/ButtonSelectorRight.png")
		Sprites.SpriteActive[index+1] = true

	Sprites.SpriteImage[110] = load("res://media/images/gui/SpeakerOFF.png")
	Sprites.SpriteActive[110] = true
	Sprites.SpriteImage[111] = load("res://media/images/gui/SpeakerON.png")
	Sprites.SpriteActive[111] = true
	Sprites.SpriteImage[115] = load("res://media/images/logos/GooglePlayLogo.png")
	Sprites.SpriteActive[115] = true
	Sprites.SpriteImage[116] = load("res://media/images/logos/ReviewGooglePlayLogo.png")
	Sprites.SpriteActive[116] = true

	Sprites.SpriteImage[117] = load("res://media/images/gui/Exit2.png")
	Sprites.SpriteActive[117] = true

	Sprites.SpriteImage[119] = load("res://media/images/gui/JoinIn.png")
	Sprites.SpriteActive[119] = true

	Sprites.SpriteImage[120] = load("res://media/images/gui/IconLeft.png")
	Sprites.SpriteActive[120] = true
	Sprites.SpriteImage[121] = load("res://media/images/gui/IconRight.png")
	Sprites.SpriteActive[121] = true
	Sprites.SpriteImage[122] = load("res://media/images/gui/IconDown.png")
	Sprites.SpriteActive[122] = true
	Sprites.SpriteImage[123] = load("res://media/images/gui/IconRotate.png")
	Sprites.SpriteActive[123] = true

	Sprites.SpriteImage[125] = load("res://media/images/gui/IconLeft.png")
	Sprites.SpriteActive[125] = true
	Sprites.SpriteImage[126] = load("res://media/images/gui/IconRight.png")
	Sprites.SpriteActive[126] = true
	Sprites.SpriteImage[127] = load("res://media/images/gui/IconDown.png")
	Sprites.SpriteActive[127] = true
	Sprites.SpriteImage[128] = load("res://media/images/gui/IconRotate.png")
	Sprites.SpriteActive[128] = true

	Sprites.SpriteImage[130] = load("res://media/images/playing/Board3Player.png")
	Sprites.SpriteActive[130] = true

	Sprites.SpriteImage[141] = load("res://media/images/story/BG_Story-1.png")
	Sprites.SpriteActive[141] = true
	Sprites.SpriteImage[142] = load("res://media/images/story/BG_Story-2.png")
	Sprites.SpriteActive[142] = true
	Sprites.SpriteImage[143] = load("res://media/images/story/BG_Story-3.png")
	Sprites.SpriteActive[143] = true
	Sprites.SpriteImage[144] = load("res://media/images/story/BG_Story-4.png")
	Sprites.SpriteActive[144] = true
	Sprites.SpriteImage[145] = load("res://media/images/story/BG_Story-5.png")
	Sprites.SpriteActive[145] = true
	Sprites.SpriteImage[146] = load("res://media/images/story/BG_Story-6.png")
	Sprites.SpriteActive[146] = true
	Sprites.SpriteImage[147] = load("res://media/images/story/BG_Story-7.png")
	Sprites.SpriteActive[147] = true
	Sprites.SpriteImage[148] = load("res://media/images/story/BG_Story-8.png")
	Sprites.SpriteActive[148] = true
	Sprites.SpriteImage[149] = load("res://media/images/story/BG_Story-9.png")
	Sprites.SpriteActive[149] = true

	Sprites.SpriteImage[150] = load("res://media/images/story/CutScene-1.png")
	Sprites.SpriteActive[150] = true
	Sprites.SpriteImage[151] = load("res://media/images/story/CutScene-2.png")
	Sprites.SpriteActive[151] = true
	Sprites.SpriteImage[152] = load("res://media/images/story/CutScene-3.png")
	Sprites.SpriteActive[152] = true
	Sprites.SpriteImage[153] = load("res://media/images/story/CutScene-4.png")
	Sprites.SpriteActive[153] = true
	Sprites.SpriteImage[154] = load("res://media/images/story/CutScene-5.png")
	Sprites.SpriteActive[154] = true
	Sprites.SpriteImage[155] = load("res://media/images/story/CutScene-6.png")
	Sprites.SpriteActive[155] = true
	Sprites.SpriteImage[156] = load("res://media/images/story/CutScene-7.png")
	Sprites.SpriteActive[156] = true
	
	Sprites.SpriteImage[157] = load("res://media/images/story/CutScene-8.png")
	Sprites.SpriteActive[157] = true

	Sprites.SpriteImage[158] = load("res://media/images/story/CutScene-9.png")
	Sprites.SpriteActive[158] = true
	
	Sprites.SpriteImage[159] = load("res://media/images/story/CutScene-10.png")
	Sprites.SpriteActive[159] = true
	
	Sprites.SpriteImage[160] = load("res://media/images/story/CutScene-11.png")
	Sprites.SpriteActive[160] = true
	Sprites.SpriteImage[161] = load("res://media/images/story/CutScene-12.png")
	Sprites.SpriteActive[161] = true
	Sprites.SpriteImage[162] = load("res://media/images/story/CutScene-13.png")
	Sprites.SpriteActive[162] = true
	Sprites.SpriteImage[163] = load("res://media/images/story/CutScene-14.png")
	Sprites.SpriteActive[163] = true
	Sprites.SpriteImage[164] = load("res://media/images/story/CutScene-15.png")
	Sprites.SpriteActive[164] = true

	Sprites.SpriteImage[170] = load("res://media/images/story/Sunset.png")
	Sprites.SpriteActive[170] = true
	Sprites.SpriteImage[171] = load("res://media/images/story/Beach.png")
	Sprites.SpriteActive[171] = true
	Sprites.SpriteImage[172] = load("res://media/images/story/Him.png")
	Sprites.SpriteActive[172] = true
	Sprites.SpriteImage[173] = load("res://media/images/story/Her.png")
	Sprites.SpriteActive[173] = true

	for index in range(0, 100):
		Sprites.SpriteImage[200+index] = load("res://media/images/gui/NameInputButton2.png")
		Sprites.SpriteActive[200+index] = true

	var maxIndex = 624
	for index in range(10000, 10000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxRed1.png")
		Sprites.SpriteActive[index] = true

	for index in range(11000, 11000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxOrange1.png")
		Sprites.SpriteActive[index] = true

	for index in range(12000, 12000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxAqua1.png")
		Sprites.SpriteActive[index] = true

	for index in range(13000, 13000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxYellow1.png")
		Sprites.SpriteActive[index] = true

	for index in range(14000, 14000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxGreen1.png")
		Sprites.SpriteActive[index] = true

	for index in range(15000, 15000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxBlue1.png")
		Sprites.SpriteActive[index] = true

	for index in range(16000, 16000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxPurple1.png")
		Sprites.SpriteActive[index] = true

	for index in range(17000, 17000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxWhite1.png")
		Sprites.SpriteActive[index] = true

	PlayfieldSpriteCurrentIndex.resize(9)
	for index in range (0, 8):
		PlayfieldSpriteCurrentIndex[index] = 0

	maxIndex = (4*3*2)
	for index in range(19000, 19000+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxRed1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19100, 19100+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxOrange1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19200, 19200+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxAqua1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19300, 19300+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxYellow1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19400, 19400+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxGreen1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19500, 19500+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxBlue1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19600, 19600+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxPurple1.png")
		Sprites.SpriteActive[index] = true

	for index in range(19700, 19700+maxIndex):
		Sprites.SpriteImage[index] = load("res://media/images/playing/BoxWhite1.png")
		Sprites.SpriteActive[index] = true

	PieceSpriteCurrentIndex.resize(9)
	for index in range (0, 9):
		PieceSpriteCurrentIndex[index] = 0

	Sprites.SpriteImage[19980] = load("res://media/images/playing/KeyboardControls.png")
	Sprites.SpriteActive[19980] = true

	Sprites.SpriteImage[19999] = load("res://media/images/backgrounds/FadingBlackBG.png")
	Sprites.SpriteActive[19999] = true

	for index in range(0, 20000):
		if Sprites.SpriteActive[index] == true:
			var sprite_size = Sprites.SpriteImage[index].get_size()
			Sprites.SpriteImageWidth[index] = sprite_size.x
			Sprites.SpriteImageHeight[index] = sprite_size.y
			RenderingServer.canvas_item_add_texture_rect(Sprites.ci_rid[index], Rect2(Vector2.ZERO, sprite_size), Sprites.SpriteImage[index])
			var xform = Transform2D().translated(Vector2(-99999 - sprite_size.x / 2.0, -99999 - sprite_size.y / 2.0))
			RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], xform)

			if (index > 39 && index < 129):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 500)

			if (index > 139 && index < 150):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 50)

			if (index > 18999 && index < 19980):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 100)



#	var font = load("res://media/fonts/Font_01.ttf")
#	$"Label".set("custom_fonts/font", font)
#	$"Label".set("custom_fonts/font_size", 25)

	FontTTF.append(-1)#DynamicFont.new())
	FontTTF[0] = load("res://media/fonts/Font_01.ttf")

	FontTTF.append(-1)#DynamicFont.new())
	FontTTF[1] = load("res://media/fonts/Font_01.ttf")

	FontTTF.append(-1)#DynamicFont.new())
	FontTTF[2] = load("res://media/fonts/Font_01.ttf")

	FontTTF.append(-1)#DynamicFont.new())
	FontTTF[3] = load("res://media/fonts/Font_01.ttf")

	FontTTF.append(-1)#DynamicFont.new())
	FontTTF[4] = load("res://media/fonts/Font_01.ttf")

#	FontTTF[0].size = 250
#	FontTTF.append(DynamicFont.new())
#	FontTTF[1].font_data = load("res://media/fonts/Font_01.ttf")
#	FontTTF[1].size = 60
#	FontTTF.append(DynamicFont.new())
#	FontTTF[2].font_data = load("res://media/fonts/Font_01.ttf")
#	FontTTF[2].size = 34
#	FontTTF.append(DynamicFont.new())
#	FontTTF[3].font_data = load("res://media/fonts/Font_02.ttf")
#	FontTTF[3].size = 16
#	FontTTF.append(DynamicFont.new())
#	FontTTF[4].font_data = load("res://media/fonts/Font_01.ttf")
#	FontTTF[4].size = 24

	TextCurrentIndex = 0

	AboutTextsStartIndex = 0
	AboutTextsEndIndex = 0

#	RenderingServer
#	var xform = Transform2D().scaled(Vector2(2.845, 1.0))
	RenderingServer.canvas_item_set_transform(Sprites.ci_rid[60], Transform2D().scaled(Vector2(2.845, 1.0)))#xform)
# Invalid argument for "canvas_item_set_transform()" function: argument 2 should be Transform2D but is null.

	RenderingServer.canvas_item_set_modulate(Sprites.ci_rid[60], Color(1.0, 1.0, 1.0, 0.4))

	var sprite_size = Sprites.SpriteImage[60].get_size()
	RenderingServer.canvas_item_set_transform(Sprites.ci_rid[60], Transform2D().translated(Vector2(-99999 - sprite_size.x / 2.0, -99999 - sprite_size.y / 2.0)))

# Function "CanvasModulate()" not found in base self.

#	Sprites.SpriteImage[60].modulate = Color(1.0, 1.0, 1.0, 0.4)

	RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[60], 1000)
	
	DrawSprite(0, VisualsCore.ScreenWidth/2, VisualsCore.ScreenHeight/2, 1.0, 1.0, 0, 1.0, 1.0, 1.0, 1.0)
#	Sprites.SpriteImage[0].set_z_index(1000)

#	FramesPerSecondText = RichTextLabel.new()
#	add_child(FramesPerSecondText)
#	FramesPerSecondText.rect_clip_content = false
#	FramesPerSecondText.add_font_override("normal_font", FontTTF[3])
#	FramesPerSecondText.modulate = Color(1, 1, 1, 1)
#	FontTTF[0].outline_size = 3
#	FontTTF[0].outline_color = Color(0, 0, 0, 1)
#	FramesPerSecondText.text = ("FPS="+str(Engine.get_frames_per_second()))
#	var textWidth = FramesPerSecondText.get_font("normal_font").get_string_size(FramesPerSecondText.text).x
#	var textHeight = FramesPerSecondText.get_font("normal_font").get_string_size(FramesPerSecondText.text).y
#	FramesPerSecondText.rect_global_position.x = (5)
#	FramesPerSecondText.rect_global_position.y = (ScreenHeight-21)
#	FramesPerSecondText.set_size(Vector2(ScreenWidth, ScreenHeight), false)
#	FramesPerSecondText.rect_pivot_offset = Vector2((textWidth / 2), (textHeight / 2))
#	FramesPerSecondText.rect_scale = Vector2(1.0, 1.0)
#	FramesPerSecondText.rect_rotation = 0.0

	pass

#----------------------------------------------------------------------------------------
func MoveAllActiveSpritesOffScreen():
	for index in range(1, 20000):
		if Sprites.SpriteActive[index] == true:
#			Sprites.SpriteImage[index].global_position = Vector2(-9999, -9999)
			var sprite_size = Sprites.SpriteImage[index].get_size()
			RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], Transform2D().translated(Vector2(-99999 - sprite_size.x / 2.0, -99999 - sprite_size.y / 2.0)))

	pass

#----------------------------------------------------------------------------------------
func DrawSprite(index, x, y, scaleX, scaleY, rotation, red, green, blue, alpha):
	var sprite_size = Sprites.SpriteImage[index].get_size()
	sprite_size.x = sprite_size.x * scaleX
	sprite_size.y = sprite_size.y * scaleY
	var rot = rotation * (180/PI)
	RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], Transform2D(rot, Vector2(scaleX, scaleY), 0.0, Vector2(x - (sprite_size.x / 2.0), y - (sprite_size.y / 2.0))))
	RenderingServer.canvas_item_set_modulate(Sprites.ci_rid[index], Color(red, green, blue, alpha))

	Sprites.SpriteActive[index] = true
	Sprites.SpriteScreenX[index] = x
	Sprites.SpriteScreenY[index] = y
	Sprites.SpriteScaleX[index] = scaleX
	Sprites.SpriteScaleY[index] = scaleY
	Sprites.SpriteRotation[index] = rotation
	Sprites.SpriteColorRed[index] = red
	Sprites.SpriteColorGreen[index] = green
	Sprites.SpriteColorBlue[index] = blue
	Sprites.SpriteColorAlpha[index] = alpha

	pass

#----------------------------------------------------------------------------------------
func DeleteAllTexts():
#	return
	
	var size = Texts.TextImage.size()
	size-=1

	for index in range(size, 9, -1):
		remove_child(Texts.TextImage[index])
#		Texts.TextImage.remove(index)

	TextCurrentIndex = 10

	pass

#----------------------------------------------------------------------------------------
func DrawnTextChangeScaleRotation(index, scaleX, scaleY, rotation):
	Texts.TextImage[index].scale = Vector2(scaleX, scaleY)
	Texts.TextImage[index].rotation = rotation

	pass

#----------------------------------------------------------------------------------------
func DrawText(index, text, x, y, horizontalJustification, fontSize, scaleX, scaleY, rotation, red, green, blue, alpha, outlineRed, outlineGreen, outlineBlue):
	if ( index > (TextCurrentIndex-1) ):
		Texts.TextImage.append(RichTextLabel.new())
		add_child(Texts.TextImage[index])

	var fontToUseIndex = 0
	if fontSize == 25:
		fontToUseIndex = 0
	elif fontSize == 60:
		fontToUseIndex = 1
	elif fontSize == 35:
		fontToUseIndex = 2
	elif fontSize == 12:
		fontToUseIndex = 3
	elif fontSize == 22:
		fontToUseIndex = 4

	Texts.TextImage[index].clip_contents = false

	Texts.TextImage[index].add_theme_font_override("normal_font", FontTTF[fontToUseIndex])
	
	Texts.TextImage[index].add_theme_font_size_override("normal_font_size", fontSize)

	Texts.TextImage[index].add_theme_color_override("default_color", Color(red, green, blue, alpha))
	
	Texts.TextImage[index].add_theme_constant_override("outline_size", 3.0)
	
	Texts.TextImage[index].add_theme_color_override("font_outline_color", Color(outlineRed, outlineGreen, outlineBlue, alpha))

	Texts.TextImage[index].text = text

# Something wrong below
	var textWidth = Texts.TextImage[index].get_theme_font("normal_font").get_string_size(Texts.TextImage[index].text).x
	var textHeight = Texts.TextImage[index].get_theme_font("normal_font").get_string_size(Texts.TextImage[index].text).y
# Something wrong above

	Texts.TextImage[index].global_position.x = x
	Texts.TextImage[index].global_position.y = (y - (textHeight / 2))

	Texts.TextImage[index].set_size(Vector2(ScreenWidth, ScreenHeight), false)

	Texts.TextImage[index].pivot_offset = Vector2((textWidth / 2), (textHeight / 2))

	Texts.TextImage[index].scale = Vector2(scaleX, scaleY)

	Texts.TextImage[index].rotation = rotation

	if horizontalJustification == 0:
		Texts.TextImage[index].global_position.x = x
	elif horizontalJustification == 1: # Center text horizonatally on screen (NOT working properly?)
		Texts.TextImage[index].global_position.x = ((VisualsCore.ScreenWidth/2) - (textWidth/2))
	elif horizontalJustification == 2:
		Texts.TextImage[index].global_position.x = (VisualsCore.ScreenWidth - x - (textWidth))
	elif horizontalJustification == 4:
		Texts.TextImage[index].global_position.x = (x - (textWidth / 2))

	Texts.TextIndex.append(index)
	Texts.TextScreenX.append(x)
	Texts.TextScreenY.append(y)
	Texts.TextHorizontalJustification.append(horizontalJustification)
	Texts.TextSize.append(fontSize)
	Texts.TextScaleX.append(scaleX)
	Texts.TextScaleY.append(scaleY)
	Texts.TextRotation.append(rotation)
	Texts.TextColorRed.append(red)
	Texts.TextColorGreen.append(green)
	Texts.TextColorBlue.append(blue)
	Texts.TextColorAlpha.append(alpha)
	Texts.TextOutlineRed.append(outlineRed)
	Texts.TextOutlineGreen.append(outlineGreen)
	Texts.TextOutlineBlue.append(outlineBlue)

	TextCurrentIndex+=1

	return(TextCurrentIndex-1)

	pass

#----------------------------------------------------------------------------------------
func AddAboutScreenText(text, blue):
	AboutTexts.AboutTextsText.append(text)
	AboutTexts.AboutTextsBlue.append(blue)

	AboutTextsEndIndex+=1

	pass

#----------------------------------------------------------------------------------------
func LoadAboutScreenTexts():
	AboutTextsStartIndex = 10
	AboutTextsEndIndex = AboutTextsStartIndex

	AddAboutScreenText("TM", 0.0)

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		AddAboutScreenText("''TetriStory 110%™''", 0.0)
	elif (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		AddAboutScreenText("''T-Story 110%™''", 0.0)

	AddAboutScreenText("Copyright 2022 By:", 1.0)
	AddAboutScreenText("Team ''Fallen Angel Software''", 1.0)

	AddAboutScreenText("Original Concept By:", 0.0)
	AddAboutScreenText("Alexey Pajitnov", 1.0)

	AddAboutScreenText("Video Game Made Possible By Our Mentors:", 0.0)
	AddAboutScreenText("Garry Kitchen", 1.0)
	AddAboutScreenText("Andre' LaMothe", 1.0)

	AddAboutScreenText("Made With 100% FREE:", 0.0)
	AddAboutScreenText("''Godot Game Engine''", 1.0)
	AddAboutScreenText("[www.GodotEngine.org]", 1.0)

	AddAboutScreenText("''Godot Game Engine'' Recommended By:", 0.0)
	AddAboutScreenText("''Yuri S.''", 1.0)

	AddAboutScreenText("Game Built On:", 0.0)
	AddAboutScreenText("Genuine ''Manjaro KDE 64Bit'' Linux", 1.0)
	AddAboutScreenText("[www.Manjaro.org]", 1.0)
	AddAboutScreenText("Real Programmers Use Linux!", 1.0)

	AddAboutScreenText("Project Produced By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Project Directed By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Godot 2-D Game Engine Framework:", 0.0)
	AddAboutScreenText("The ''Grand National GNX'' Engine By:", 1.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Original Cooperative Story Mode Created By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Lead Game Designer:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Lead Game Programmer:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Lead Game Tester:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("100% Arcade Perfect To Home Conversion By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)
	AddAboutScreenText("[Original Gameboy Version]", 1.0)

	AddAboutScreenText("''Gift Of Sight'' Artificial Intelligence Programmer:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)
	AddAboutScreenText("[32,000+ Average Lines Per Game!]", 1.0)

	AddAboutScreenText("Support Game Programmers:", 0.0)
	AddAboutScreenText("''Daotheman''", 1.0)
	AddAboutScreenText("''theweirdn8''", 1.0)
	AddAboutScreenText("''mattmatteh''", 1.0)

	AddAboutScreenText("Lead Graphic Artist:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Support Graphic Artist:", 0.0)
	AddAboutScreenText("''Oshi Bobo''", 1.0)

	AddAboutScreenText("Story Artist:", 0.0)
	AddAboutScreenText("''J.''", 1.0)

	AddAboutScreenText("Music Sountrack By:", 0.0)
	AddAboutScreenText("''Free Stock Music''", 1.0)
	AddAboutScreenText("[www.Free-Stock-Music.com]", 1.0)
	AddAboutScreenText("''Jamendo Music''", 1.0)
	AddAboutScreenText("[www.Jamendo.com]", 1.0)
	AddAboutScreenText("''YouTube Music''", 1.0)
	AddAboutScreenText("[www.YouTube.com]", 1.0)

	AddAboutScreenText("Title Music:", 0.0)
	AddAboutScreenText("Farewell by MaxKoMusic | https://maxkomusic.com/", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Creative Commons Attribution-ShareAlike 3.0 Unported", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by-sa/3.0/deed.en_US", 1.0)

	AddAboutScreenText("Playing Level # 1 Music:", 0.0)
	AddAboutScreenText("Spirit by Alexander Nakarada | https://www.serpentsoundstudios.com", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Attribution 4.0 International [CC BY 4.0]", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by/4.0/", 1.0)

	AddAboutScreenText("Playing Level # 2 Music:", 0.0)
	AddAboutScreenText("You're Welcome[Instrumental] by RYYZN", 1.0)
	AddAboutScreenText("Music promoted by https://www.youtube.com", 1.0)

	AddAboutScreenText("Playing Level # 3 Music:", 0.0)
	AddAboutScreenText("Voyage by LEMMiNO", 1.0)
	AddAboutScreenText("Music promoted by https://www.youtube.com", 1.0)

	AddAboutScreenText("Playing Level # 4 Music:", 0.0)
	AddAboutScreenText("Deja Vu by RYYZN", 1.0)
	AddAboutScreenText("Music promoted by https://www.youtube.com", 1.0)

	AddAboutScreenText("Playing Level # 5 Music:", 0.0)
	AddAboutScreenText("Dragon Slayer by Makai Symphony | https://soundcloud.com/makai-symphony", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Creative Commons Attribution-ShareAlike 3.0 Unported", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by-sa/3.0/deed.en_US", 1.0)

	AddAboutScreenText("Playing Level # 6 Music:", 0.0)
	AddAboutScreenText("Eyes_and_See by PEOPLE OF THE PARALLEL", 1.0)
	AddAboutScreenText("Music promoted by https://www.jamendo.com", 1.0)

	AddAboutScreenText("Playing Level # 7 Music:", 0.0)
	AddAboutScreenText("My Heart Blows Up [Explosions] by ANTON LEUBA", 1.0)
	AddAboutScreenText("Music promoted by https://www.jamendo.com", 1.0)

	AddAboutScreenText("Playing Level # 8 Music:", 0.0)
	AddAboutScreenText("Absolution by Scott Buckley | https://soundcloud.com/scottbuckley", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Attribution 4.0 International [CC BY 4.0]", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by/4.0/", 1.0)

	AddAboutScreenText("Playing Level # 9 Music:", 0.0)
	AddAboutScreenText("Warrior by yoitrax | https://soundcloud.com/yoitrax", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Creative Commons Attribution 3.0 Unported License", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by/3.0/deed.en_US", 1.0)

	AddAboutScreenText("Won Music:", 0.0)
	AddAboutScreenText("UPBEAT 2 by Aries Beats | https://soundcloud.com/aries4rce", 1.0)
	AddAboutScreenText("Music promoted by https://www.free-stock-music.com", 1.0)
	AddAboutScreenText("Creative Commons Attribution-ShareAlike 3.0 Unported", 1.0)
	AddAboutScreenText("https://creativecommons.org/licenses/by-sa/3.0/deed.en_US", 1.0)

	AddAboutScreenText("Music Soundtrack Compiled & Edited By:", 0.0)
	AddAboutScreenText("''D.J. Fading Twilight''", 1.0)

	AddAboutScreenText("Sound Effects Compiled & Edited By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("''Neo's Kiss'' Graphical User Interface By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("PNG Graphics Edited In:", 0.0)
	AddAboutScreenText("''PixelNEO''", 1.0)
	AddAboutScreenText("[https://VisualNEO.com/product/pixelneo]", 1.0)
	AddAboutScreenText("- Free Linux Alternative: ''Krita'' -", 1.0)

	AddAboutScreenText("PNG Graphics Optimized Using:", 0.0)
	AddAboutScreenText("''TinyPNG''", 1.0)
	AddAboutScreenText("[www.TinyPNG.com]", 1.0)

	AddAboutScreenText("OGG Audio Edited In:", 0.0)
	AddAboutScreenText("''GoldWave''", 1.0)
	AddAboutScreenText("[www.GoldWave.com]", 1.0)
	AddAboutScreenText("- Free Linux Alternative: ''Audacity'' -", 1.0)

	AddAboutScreenText("OGG Audio Optimized Using:", 0.0)
	AddAboutScreenText("''OGGResizer''", 1.0)
	AddAboutScreenText("[www.SkyShape.com]", 1.0)

	AddAboutScreenText("''TetriStory 110%'' Logo Created In:", 0.0)
	AddAboutScreenText("Genuine Microsoft Office 365 Publisher", 1.0)
	AddAboutScreenText("[www.Office.com]", 1.0)

	AddAboutScreenText("Game Created On A:", 0.0)
	AddAboutScreenText("Hyper-Custom ''JeZxLee'' Pro-Built Desktop", 1.0)
	AddAboutScreenText("Desktop Code Name: ''Optimus Prime''", 1.0)
	AddAboutScreenText("Genuine ''Manjaro KDE 64Bit'' Linux", 1.0)
	AddAboutScreenText("Corsair® 750watt Modular Power Supply", 1.0)
	AddAboutScreenText("GIGABYTE® GA-970A-DS3P 2.0 AM3+ Motherboard", 1.0)
	AddAboutScreenText("AMD® FX 3.5GHz[4GHz Turbo] 8-Core CPU", 1.0)
	AddAboutScreenText("Corsair® 32GB DDR3 RAM Memory", 1.0)
	AddAboutScreenText("nVidia® GeForce GTX 970TT 4GB GDDR5 GPU", 1.0)
	AddAboutScreenText("ADATA® 1TB SSD Hard Drive[OS/Apps]", 1.0)
	AddAboutScreenText("Western Digital® 1TB HDD Hard Drive[Data]", 1.0)
#	AddAboutScreenText("Game Created On A:", 0.0)
#	AddAboutScreenText("Hyper-Custom ''JeZxLee'' Pro-Built Desktop", 1.0)
#	AddAboutScreenText("Desktop Code Name: ''JetFire''", 1.0)
#	AddAboutScreenText("Genuine ''openSUSE Tumbleweed K.D.E. 64Bit'' Linux", 1.0)
#	AddAboutScreenText("Thermaltake 500watt Power Supply", 1.0)
#	AddAboutScreenText("Gigabye B85M-HD3 Mid-Range Motherboard", 1.0)
#	AddAboutScreenText("Intel Core i5 3.0GHz(3.2GHz Turbo) 4-Core CPU", 1.0)
#	AddAboutScreenText("Corsair 16GB DDR3 RAM Memory", 1.0)
#	AddAboutScreenText("nVidia GeForce GTX 1050 Ti 4GB GDDR5 GPU", 1.0)
#	AddAboutScreenText("ADATA 1TB SSD Hard Drive(OS/Apps)", 1.0)
#	AddAboutScreenText("Western Digital 1TB HDD Hard Drive(Personal Data)", 1.0)

	AddAboutScreenText("HTML5 Version Tested On:", 0.0)
	AddAboutScreenText("Genuine Windows® 10 Pro 64Bit", 1.0)
	AddAboutScreenText("Edge", 1.0)
	AddAboutScreenText("Firefox", 1.0)
	AddAboutScreenText("Chrome", 1.0)
	AddAboutScreenText("Opera", 1.0)

	AddAboutScreenText("HTML5 Version Tested On macOS Safari By:", 0.0)
	AddAboutScreenText("''EvanR''", 1.0)

	AddAboutScreenText("Android Version Tested On:", 0.0)
	AddAboutScreenText("Samsung® Galaxy A51 Smartphone", 1.0)
	AddAboutScreenText("Vankyo® S20 Tablet", 1.0)

	AddAboutScreenText("Big Thank You To People Who Helped:", 0.0)
	AddAboutScreenText("''Yuri S.''", 1.0)
	AddAboutScreenText("''TwistedTwigleg''", 1.0)
	AddAboutScreenText("''Megalomaniak''", 1.0)
	AddAboutScreenText("''SIsilicon28''", 1.0)
	AddAboutScreenText("''vimino''", 1.0)
	AddAboutScreenText("[ : ''PurpleConditioner'' : ]", 1.0)
	AddAboutScreenText("''Kequc''", 1.0)
	AddAboutScreenText("''qeed''", 1.0)
	AddAboutScreenText("''Calinou''", 1.0)
	AddAboutScreenText("''Sosasees''", 1.0)
	AddAboutScreenText("''ArRay_''", 1.0)
	AddAboutScreenText("''blast007''", 1.0)
	AddAboutScreenText("''fogobogo''", 1.0)
	AddAboutScreenText("''CYBEREALITY''", 1.0)
	AddAboutScreenText("''Perodactyl''", 1.0)
	AddAboutScreenText("''floatcomplex''", 1.0)
	AddAboutScreenText("''DaveTheCoder''", 1.0)
	AddAboutScreenText("''Dominus''", 1.0)
	AddAboutScreenText("''lawnjelly''", 1.0)
	AddAboutScreenText("''EvanR''", 1.0)
	AddAboutScreenText("''Zelta''", 1.0)
	AddAboutScreenText("''slidercrank''", 1.0)
	AddAboutScreenText("''epicspaces''", 1.0)
	AddAboutScreenText("''powersnap55''", 1.0)
	AddAboutScreenText("''cybereality''", 1.0)
	AddAboutScreenText("''Unforgiven''", 1.0)
	AddAboutScreenText("''Neil Kenneth David''", 1.0)
	AddAboutScreenText("''gioele''", 1.0)
	AddAboutScreenText("''TatBou''", 1.0)
	AddAboutScreenText("''fire7side''", 1.0)
	AddAboutScreenText("''YaroslavFox''", 1.0)
	AddAboutScreenText("''Erich_L''", 1.0)
	AddAboutScreenText("''Zoinkers''", 1.0)

	AddAboutScreenText(" ", 1.0)
	AddAboutScreenText("''You!''", 1.0)

	AddAboutScreenText("''A 110% By Team Fallen Angel Software!''", 0.0)
	AddAboutScreenText(" ", 1.0)#[www.FallenAngelSoftware.com]", 1.0)

	DrawText(AboutTextsStartIndex, AboutTexts.AboutTextsText[AboutTextsStartIndex-10], ((ScreenWidth/2)+100), ScreenHeight+25, 0, 25, 1.0, 1.0, 0, 1.0, 1.0, AboutTexts.AboutTextsBlue[AboutTextsStartIndex-10], 0.0, 0.0, 0.0, 0.0)

	var screenY = ScreenHeight+25
	for index in range(AboutTextsStartIndex+1, AboutTextsEndIndex):
		if (AboutTexts.AboutTextsBlue[index-10] == 1.0 && AboutTexts.AboutTextsBlue[index-1-10] == 0.0):
			screenY+=40
		elif (AboutTexts.AboutTextsBlue[index-10] == 1.0 && AboutTexts.AboutTextsBlue[index-1-10] == 1.0):
			screenY+=40
		else:
			screenY+=140

		DrawText(index, AboutTexts.AboutTextsText[index-10], 0, screenY, 1, 22, 1.0, 1.0, 0, 1.0, 1.0, AboutTexts.AboutTextsBlue[index-10], 1.0, 0.0, 0.0, 0.0)

#	Texts.TextImage[AboutTextsEndIndex-2].rect_global_position.y+=(ScreenHeight/2)
#	Texts.TextImage[AboutTextsEndIndex-1].rect_global_position.y+=(ScreenHeight/2)

	pass
