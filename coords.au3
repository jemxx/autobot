#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=coords.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

HotKeySet("{F8}", "coordinati_privazki")
HotKeySet("{F5}", "ProverkaKoordinat")

Global Const $gui_event_close = -3

#Region ### START Koda GUI section ### Form=
	Global $level = GUICreate("Координаты", 225, 305, @DesktopWidth - 245, 20)
	GUISetBkColor(16777088)
	GUICtrlCreateLabel("Файл Привязки", 5, 10)
	Global $file_gui = GUICtrlCreateInput(".bmp", 5, 30, 215, 20)
	GUICtrlCreateLabel("Поместите точку привязки и лагерь", 5, 60)
	GUICtrlCreateLabel("в видимую область монитора.", 5, 75)
	GUICtrlCreateLabel("Наведите мышку на лагерь", 5, 100)
	GUICtrlCreateLabel("и нажмите F8", 5, 115)
	Global $mish = GUICtrlCreateButton("Навести мышь для проверки F5", 5, 160, 215, 20)
	GUICtrlCreateLabel("X:", 5, 193)
	Global $x_gui = GUICtrlCreateInput("0", 15, 190, 50, 20)
	GUICtrlCreateLabel("Y:", 5, 223)
	Global $y_gui = GUICtrlCreateInput("0", 15, 220, 50, 20)
	$haccelinterupt = GUICtrlCreateDummy()
	Dim $accelkeys[1][2] = [["z", $haccelinterupt]]
	GUISetAccelerators($accelkeys)
;	GUIRegisterMsg($wm_command, "_WM_COMMAND")
	GUISetState(@SW_SHOW)
	While 1
		$nmsg = GUIGetMsg()
		Switch $nmsg
			Case $gui_event_close
				Exit
			Case $mish
				proverkakoordinat()
		EndSwitch
	WEnd
#EndRegion ### END Koda GUI section ###

Func _imagesearch($findimage, $resultposition, ByRef $x, ByRef $y, $tolerance)
	Return _imagesearcharea($findimage, $resultposition, 0, 0, @DesktopWidth, @DesktopHeight, $x, $y, $tolerance)
EndFunc

Func _imagesearcharea($findimage, $resultposition, $x1, $y1, $right, $bottom, ByRef $x, ByRef $y, $tolerance)
	If $tolerance > 0 Then $findimage = "*" & $tolerance & " " & $findimage
	$result = DllCall("Globalfunc.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findimage)
	If $result[0] = "0" Then Return 0
	$array = StringSplit($result[0], "|")
	$x = Int(Number($array[2]))
	$y = Int(Number($array[3]))
	If $resultposition = 1 Then
		$x = $x + Int(Number($array[4]) / 2)
		$y = $y + Int(Number($array[5]) / 2)
	EndIf
	Return 1
EndFunc


Func coordinati_privazki()
	Local $pos = MouseGetPos(), $tx, $ty, $ax = 0, $ay = 0, $bx = 0, $by = 0, $grafika = 0
	If _imagesearch("media\pismo.bmp", 1, $bx, $by, 50) = 0 Then
		MsgBox(0, "ОШИБКА!!!", "Мы нашли остров")
		Return 0
	EndIf
	While $grafika < 150
		$grafika = $grafika + 5
		If _imagesearch("media\users\" & GUICtrlRead($file_gui), 1, $tx, $ty, $grafika) = 1 Then
			MouseMove($tx, $ty, 5)
			Sleep(500)
			ExitLoop
		EndIf
	WEnd
	If $grafika > 145 Then
		MsgBox(0, "ОШИБКА!!!", "Мы НЕ нашли точку привязки")
		Return 0
	EndIf
	$ax = $pos[0] - $tx
	$ay = $pos[1] - $ty
	MouseMove($tx, $ty, 10)
	MouseMove($pos[0], $pos[1], 10)
	MouseMove($tx, $ty, 15)
	MouseMove($pos[0], $pos[1], 10)
	GUICtrlSetData($x_gui, $ax)
	GUICtrlSetData($y_gui, $ay)
	MsgBox(0, "Внимание!!!", "Мы нашли точку привязки с параметром графики " & $grafika & " по координатам Х=" & $tx - $bx & " Y=" & $ty - $by & @CR & @CR & "Мы определили координаты лагеря как X=" & $ax & " Y=" & $ay & @CR & @CR & "Для наглядности поводили мышкой между ними.")
	Return 1
EndFunc

Func proverkakoordinat()
	Local $pos = MouseGetPos(), $tx, $ty, $bx = 0, $by = 0, $grafika = 0
	If _imagesearch("media\pismo.bmp", 1, $bx, $by, 50) = 0 Then
		MsgBox(0, "ОШИБКА!!!", "Мы нашли остров")
		Return 0
	EndIf
	While $grafika < 150
		$grafika = $grafika + 5
		If _imagesearch("media\users\" & GUICtrlRead($file_gui), 1, $tx, $ty, $grafika) = 1 Then
			MouseMove($tx, $ty, 5)
			Sleep(500)
			ExitLoop
		EndIf
	WEnd
	If $grafika > 145 Then
		MsgBox(0, "ОШИБКА!!!", "Мы НЕ нашли точку привязки")
		Return 0
	EndIf
	MouseMove($tx, $ty, 10)
	MouseMove($tx + GUICtrlRead($x_gui), $ty + GUICtrlRead($y_gui), 10)
	TrayTip("", "Мышка перемещена...", 0)
	Return 1
EndFunc
