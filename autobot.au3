#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=media\icon.ico
#AutoIt3Wrapper_Outfile=Autobot.exe
#AutoIt3Wrapper_Outfile_x64=Autobot_x64.exe
#AutoIt3Wrapper_Res_Description=Автобот для The Settlers
#AutoIt3Wrapper_Res_Fileversion=0.0.24.1
#AutoIt3Wrapper_Res_ProductName=Автобот
#AutoIt3Wrapper_Res_ProductVersion=0.24
#AutoIt3Wrapper_Res_LegalCopyright=2021 © by github.com/jemxx/autobot
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If WinExists('[CLASS:AutoIt v3;TITLE:' & @ScriptName & ']') Then
    MsgBox(48, @ScriptName, 'Разрешено запускать только одну копию Автобота!' & @CRLF & @CRLF & 'ОК ==> ВЫХОД')
    Exit
EndIf
AutoItWinSetTitle(@ScriptName)

If ProcessExists("Универсальный_бот.exe") Then ProcessClose ("Универсальный_бот.exe")

Global $alarm, $passagesDir, $pass_count, $windowTitle, $sreport = 0
Global $userDIR = "media\users\"
Global $lang = ReadINI("main", "language", "ru")
Global $sectorGraph = ReadINI("main", "sector_graphics", "70")

Global $k_x, $k_y, $tochka_sektora_x=0, $tochka_sektora_y=0
Global $shtuk, $i = 1, $register = 0
Global $komand_na_massiv = 0
Global $strokadlaperehoda = 0
Global $current_stroka = 1
Global $centrovat = 1, $currentbuf = 0
Global $stroka

#include "globalfunc.au3"
#include "globalfuncWAR.au3"
#include <Inet.au3>
#include <GUIComboBox.au3>

HotKeySet("{F9}", "_pause")
HotKeySet("{F7}", "ProverkaSliva")
HotKeySet("{F11}", "terminater")

$passagesDir = getPassagesDir()
$stroka = getAllPassages($passagesDir)

;Рисуем окно бота
#Region ### START Koda GUI section ### Form=
	Global $level = GUICreate(getLangPhrase("val_001"), 225, 380, @DesktopWidth - 245, 20)
	GUISetBkColor(16777088)
	GUICtrlCreateLabel(getLangPhrase("val_002"), 5, 10)
	Global $file_gui = GUICtrlCreateCombo("", 5, 30, 215, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))
	_GUICtrlComboBox_SetMinVisible($file_gui, 23)
	GUICtrlSetData(-1, $stroka, ReadINI("main", "favorite_file", ""))
	GUICtrlCreateLabel(getLangPhrase("val_003"), 5, 60)
	Global $file_gui2 = GUICtrlCreateInput("1", 5, 80, 215, 20)

	Local $max_repeat = ReadINI("main", "total_cycles", "99")
	If $max_repeat < 1 Then $max_repeat = 99
	GUICtrlCreateLabel(getLangPhrase("val_004"), 5, 110)
	Global $pass_cnt = GUICtrlCreateInput($max_repeat, 5, 130, 215, 20)

	Global $obnova = GUICtrlCreateCheckbox(getLangPhrase("val_005"), 5, 160, 180, 25)
	GUICtrlSetState($obnova, $GUI_UNCHECKED)
	Global $osibki = GUICtrlCreateCheckbox(getLangPhrase("val_006"), 5, 180, 180, 25)
	GUICtrlSetState($osibki, $GUI_UNCHECKED)
	Global $alarmCheckBox = GUICtrlCreateCheckbox(getLangPhrase("val_007"), 5, 200, 180, 25)
	GUICtrlSetState($alarmCheckBox, $GUI_CHECKED)

	;Проверяем флаг разрыва соединения
	If ReadINI("main", "check_connection", "0") = "" Then
		If ProcessExists("serverOFF.exe") Then
		Else
			Run("media\serverOFF.exe")
		EndIf
	ElseIf ReadINI("main", "check_connection", "0") = 0 Then
		If ProcessExists("serverOFF.exe") Then ProcessClose("serverOFF.exe")
	Else
		If ProcessExists("serverOFF.exe") Then
		Else
			Run("media\serverOFF.exe")
		EndIf
	EndIf

	Global $no1_1 = GUICtrlCreateButton(getLangPhrase("val_008"), 5, 240, 215, 30)
	Global $pr8 = GUICtrlCreateButton(getLangPhrase("val_009"), 5, 280, 215, 20)
	Global $pr9 = GUICtrlCreateButton(getLangPhrase("val_010"), 5, 310, 215, 20)
	GUICtrlCreateLabel(getLangPhrase("val_011"), 5, 340)
	GUICtrlCreateLabel(getLangPhrase("val_012"), 5, 360)
	$haccelinterupt = GUICtrlCreateDummy()
	Dim $accelkeys[1][2] = [["z", $haccelinterupt]]
	GUISetAccelerators($accelkeys)
	GUISetState(@SW_SHOW)
	While 1
		$nmsg = GUIGetMsg()
		Switch $nmsg
			Case $gui_event_close
				Exit
			Case $file_gui
				GUICtrlSetData($file_gui2, "1")
				GUICtrlSetData($pass_cnt, $max_repeat)
			Case $no1_1
				tormoza()
				TrayTip("", getLangPhrase("val_012"), 0)

				Global $abot = $passagesDir & "\" & GUICtrlRead($file_gui)
				If FileExists($abot) Then
					$i = GUICtrlRead($file_gui2)
					$pass_count = GUICtrlRead($pass_cnt)

					setstatistik()
					$register = 0

					$windowTitle = ReadINI("main", "window_title", "The Settlers Online")
					If $windowTitle == "" Then $windowTitle = "The Settlers Online"

					If GUICtrlRead($obnova) == $GUI_CHECKED Then
						obnova()
					EndIf
					If GUICtrlRead($alarmCheckBox) == $GUI_CHECKED Then
						$alarm = 1
					Else
						$alarm = 0
					EndIf
					If ReadINI("telegram", "telegram_bot", "0") <> 0 Then
						$sreport = 1						
					EndIf
					If ProcessExists("proverkasliva.exe") Then
						ProcessClose("proverkasliva.exe")
					EndIf

					register()
					gogogogo()
				Else
					MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_015"))
					Exit
				EndIf
			Case $pr8
				ShellExecute("https://discord.gg/mb7vj4238V")
			Case $pr9
				ShellExecute("Команды_Автобота.html")
		EndSwitch
	WEnd
#EndRegion ### END Koda GUI section ###

Func obnova()
	Local $file = FileGetSize("update")
	Local $text, $fulltext
	Local $i = 0
	Local $nsize = InetGetSize("http://mysettlers.ru/uploads/update")
	Local $file2 = FileGetSize("media\update")
	If $file <> $nsize Then
		$i = 1
		Local $hdownload = InetGet("http://mysettlers.ru/uploads/update", @ScriptDir & "\media\update", 1, 1)
		Do
			Sleep(250)
		Until InetGetInfo($hdownload, 2)
		While $i <= _filecountlines("media\update")
			$text = FileReadLine("media\update", $i)
			$fulltext = $fulltext & $text & @CR
			$i = $i + 1
			If $i = 10 Then ExitLoop
		WEnd
		If MsgBox(4, getLangPhrase("val_014"), getLangPhrase("val_015") & @CR & @CR & $fulltext & @CR & @CR & @CR & @CR & getLangPhrase("val_017")) = 6 Then
			ShellExecute("http://mysettlers.ru/instrumenty/boty/item/121-sozdajom-bota-dlya-sebya")
			Sleep(3000)
			Exit
		EndIf
	EndIf
EndFunc

Func printerror($text)
   If GUICtrlRead($osibki) == $GUI_UNCHECKED Then Return 1
   TrayTip("", $text, 2, 1)
EndFunc

Func terminater()
	TrayTip("", getLangPhrase("val_018") & $current_stroka, 0)
	Sleep(1000)
	Exit
EndFunc

Func gogogogo()
	Local $ttt = _filecountlines($abot)
	If $ttt = 1 Then $i = 0
	While $i <= _filecountlines($abot)
	;Зареган ли автобот?
		If $ttt = 1 Then $i = 1
		register()
		If FileReadLine($abot, $i) = "ПОВТОРИТЬ" Then
			$i = 1
			$pass_count = $pass_count - 1
			GUICtrlSetData($pass_cnt, $pass_count)				
		EndIf
		If GUICtrlRead($pass_cnt) = 0 Then ; кончились прохождения
			If $alarm = 1 Then alarmBeep()
			If $sreport = 1 Then Telegram_bot(getLangPhrase("val_019"))	
			MsgBox(0, "", getLangPhrase("val_019"))
			ExitLoop
		EndIf
		If $i > 20 Then
			If $register = 0 Then ExitLoop
		EndIf
		While StringLeft(FileReadLine($abot, $i), 1) = "*"
			$i = $i + 1
		WEnd
		;Исполняем флаги
		While StringLeft(FileReadLine($abot, $i), 1) = "/"
			startflag(FileReadLine($abot, $i))
			$i = $i + 1
			While StringLeft(FileReadLine($abot, $i), 1) = "*"
				$i = $i + 1
			WEnd
		WEnd
		;считываем строку
		$stroka = FileReadLine($abot, $i)
		; запоминаем номер текущей строки
		$current_stroka = $i
		If $stroka = "" Then ExitLoop
		Global $komanda = StringSplit($stroka, "=")
		$delaem = $komanda[1]
		printerror(getLangPhrase("val_020") & $i & getLangPhrase("val_021") & @CR & @CR & getLangPhrase("val_022") & $delaem & @CR & getLangPhrase("val_023") & $komanda[2])
		If komanda($delaem) = 1 Then
			printerror(getLangPhrase("val_024") & $i & getLangPhrase("val_021") & @CR & @CR & getLangPhrase("val_022") & $delaem & @CR & getLangPhrase("val_023") & $komanda[2] & @CR & @CR & getLangPhrase("val_025"))
		Else
			If $alarm = 1 Then alarmBeep()
			If $sreport = 1 Then Telegram_bot("СТОП!" & getLangPhrase("val_026") & $i & getLangPhrase("val_027") & $stroka)	
			printerror(getLangPhrase("val_024") & $i & getLangPhrase("val_021") & @CR & @CR & getLangPhrase("val_022") & $delaem & @CR & getLangPhrase("val_023") & $komanda[2] & @CR & @CR & getLangPhrase("val_028"))
			MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_026") & $i & @CR & getLangPhrase("val_027") & @CR & @CR & $stroka & @CR & @CR & getLangPhrase("val_029"))
			GUICtrlSetData($file_gui2, $i)
			ExitLoop
		EndIf
		$i = $i + 1
		If $strokadlaperehoda <> 0 Then
			$i = $strokadlaperehoda
			$strokadlaperehoda = 0
		EndIf
	WEnd
EndFunc

Func startflag($stroka)
	If StringInStr($stroka, "=") Then
		$parametr = StringSplit($stroka, "=")
		$stroka = $parametr[1]
	EndIf

	Switch $stroka
		Case "/СтартПроверкиСвязи"
			If ProcessExists("serverOFF.exe") Then
				Return 1
			Else
				Run("media\serverOFF.exe")
				Return 1
			EndIf
		Case "/СтопПроверкиСвязи"
			If ProcessExists("serverOFF.exe") Then
				ProcessClose("serverOFF.exe")
				Return 1
			Else
				Return 1
			EndIf
		Case "/Скорость"
			$tormoza = $parametr[2]
		Case "/Тревога"
			$alarm = $parametr[2]
		Case "/Графика"
			$sectorGraph = $parametr[2]
	EndSwitch
EndFunc

Func komanda($delaem)
;массив команд автобота для Юзера
	Switch $delaem
		Case "ОткрытьПриключение"
			$parametr = StringSplit($komanda[2], ",")
			If openpriklaxxx($parametr[1], $parametr[2]) = 1 Then
				Return 1
			Else
				Return 0
			EndIf

		Case "ПерейтиВприкл"
			If gotopriclanosleep($userDIR & $komanda[2]) = 1 Then
				podgotovka()
				Return 1
			EndIf

		Case "ПерейтиДомой"
			Return gotohome($userDIR & $komanda[2])

		Case "ОтправитьВприключение"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[2])

			If otpravkagenvprikl($parametr[1], $generalData[0], $parametr[3], $parametr[4]) = 1 Then
				Return 1
			EndIf

		Case "ОтправитьДомой"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])

			Return otpravitgenu($generalData[0], $parametr[2])

		Case "Набрать"
			$parametr = StringSplit($komanda[2], ",")

			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]

			If openzvezdap() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					If generali($gena, $parametr[2]) = 1 Then
						If $parametr[3] = "Э" Then
							$ii = 0
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, $parametr[11]) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							Return 1
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 1 Then
								If $parametr[13] = 1 Then
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								EndIf
								If $parametr[13] = 2 Then
									zmemsmennuyukartinku("media\gohome.bmp", 30, "media\gohome_.bmp", 30)
									sleepwhile("media\nubook.bmp", 30, 10)
									zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook_.bmp", 30)
								EndIf
								Return 1
							Else
								$ii = 0
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, $parametr[13]) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
									$ii = $ii + 1 
      								If $ii > 5 Then Return 0
								WEnd
								Return 1
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							$ii = 0
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, $parametr[13]) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							Return 1
						Else
							Return 0
						EndIf
					Else
						Return 0	
					EndIf
				EndIf
			EndIf

		Case "НабратьИатаковать"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]

			If openzvezdap() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					If generali($gena, $parametr[2]) = 1 Then
						If $parametr[3] = "Э" Then
							$ii = 0
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							$gluksnaboromarmii = 0
							Return atakalageraotkritimgenoynoini($parametr[11], $parametr[12], $userDIR & $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17])
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 1 Then
								Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							Else
								$ii = 0
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
									$ii = $ii + 1 
      								If $ii > 5 Then Return 0
								WEnd
								$gluksnaboromarmii = 0
								Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							$ii = 0
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							$gluksnaboromarmii = 0
							Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
						Else
							Return 0
						EndIf
					Else
						Return 0
					EndIf
				EndIf
			EndIf

		Case "НабратьИперенести"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]

			If openzvezdap() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					If generali($gena, $parametr[2]) = 1 Then
						If $parametr[3] = "Э" Then
							$ii = 0
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							$gluksnaboromarmii = 0
							Return perenosotkritimgenoynoini($parametr[11], $parametr[12], $userDIR & $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17])
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 1 Then
								Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							Else
								$ii = 0
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
									$ii = $ii + 1 
      								If $ii > 5 Then Return 0
								WEnd
								$gluksnaboromarmii = 0
								Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							$ii = 0
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
								$ii = $ii + 1 
      							If $ii > 5 Then Return 0
							WEnd
							$gluksnaboromarmii = 0
							Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
						Else
							Return 0
						EndIf
					Else
						Return 0
					EndIf
				EndIf
			EndIf

		Case "Атаковать"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			$generalData = getGeneralData($parametr[1])

			While 1
				If openzvezdap() = 1 Then
					If selecttabatzvezda("specialisti", 1) = 1 Then
						If generali($generalData[0], $parametr[2]) = 1 Then
							Return atakalageraotkritimgenoynoini($parametr[3], $parametr[4], $userDIR & $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9])
						Else
							Return 0
						EndIf
					EndIf
				EndIf
			WEnd

		Case "АтакаПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			Return atakgenapxpnoini($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9])

		Case "ЖдемПобеду"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			Return sleepwhile2($generalData[3], $parametr[2], $parametr[3])

		Case "ЖдемГенерала"
			Local $type_wait_general = ReadINI("main", "type_wait_generals", "1")

			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			If $type_wait_general == 2 Then
				Return ozidanierasstanovki2_L($generalData[0], $generalData[2], $parametr[2])
			Else
				Return ozidanierasstanovki2_M($generalData[0], $parametr[2])
			EndIf

		Case "ЖдемВсехГенералов"
			Local $type_wait_generals = ReadINI("main", "type_wait_generals", "1")

			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			If $type_wait_generals == 2 Then
				Return ozidanierasstanovki_L($generalData[0], $generalData[2], $parametr[2])
			Else
				Return ozidanierasstanovki_M($generalData[0], $generalData[2], $parametr[2])
			EndIf	

		Case "ПеренестиГенерала"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			$generalData = getGeneralData($parametr[1])

			Return perestanovka_geni_iz_zvezdinoini($generalData[0], $parametr[2], 2, 2, $userDIR & $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9])
		Case "ПеренестиПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			Return movegenapxpnoini($parametr[6], $parametr[7], $userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[8], $parametr[9], $userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5])
		Case "ЗавершитьПрикл"
			Return endpricla($komanda[2])
		Case "Ждем"
			Sleep($komanda[2] * 1000)
			Return 1
		Case "ЖдемРандом"
			$parametr = StringSplit($komanda[2], ",")
			Sleep(Random($parametr[1], $parametr[2], 1) * 1000)
			Return 1
		Case "НаМесте"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			Return stoitligena($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], 0)	
		Case "НаборГеныПодАтаку"
			$centrovat = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			Local $perebor = 1
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]

			If $parametr[2] = "Э" Then
				While viborgenipodataku_elitanoini($userDIR & $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $full) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			If $parametr[2] = "П" Then
				While viborgenipodatakunoini($userDIR & $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], $full) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			If $parametr[2] = "1" Then
				While viborgenipodataku_1nnoini($userDIR & $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], 1, 0, 0, 0, 0, 0, 0, 0, 0, 4) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			Return 1
		Case "СбросЗадания"
			If $komanda[2] = 0 Then
				zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
				zmemsmennuyukartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				Return 1
			Else
				zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
				zmemsmennuyukartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				Sleep(10000)
				zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				Return 1
			EndIf
		Case "ЖмемКартинку"
			$parametr = StringSplit($komanda[2], ",")
			zmemsmennuyukartinku($userDIR & $parametr[1], $parametr[2], $userDIR & $parametr[3], $parametr[4])
			Return 1
		Case "ЖмемКартинкуИждем"
			$parametr = StringSplit($komanda[2], ",")
			Return zmemsmennuyukartinkuizdem($userDIR & $parametr[1], $parametr[2], $userDIR & $parametr[3], $parametr[4], $userDIR & $parametr[5], $parametr[6])
		Case "Сообщение"
			$parametr = StringSplit($komanda[2], ",")
			
			If UBound($parametr) = 3 Then
				If $parametr[2] = 2 Then
					TrayTip(getLangPhrase("val_030"), $parametr[1], 5, 1)
				Else
					MsgBox(0, getLangPhrase("val_030"), $parametr[1])
				EndIf
			Else
				MsgBox(0, getLangPhrase("val_030"), $parametr[1])
			EndIf
		
			Return 1

		Case "Стрельнуть"
			Local $buff
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)

			if $komand_na_massiv == 2 Then
				$buff = getBuffData($parametr[1], "horseshoes")

				If open_usilok($buff[1], $buff[0], 0) = 1 Then
					zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook.bmp", 30)
					Return 1
				Else
					Return 0
				EndIf
			Else
				$centrovat = 1
				Local $perebor = 1
				While $perebor < $komand_na_massiv
					If $parametr[$perebor] = "НеЦентровать" Then
						$centrovat = 0
						ExitLoop
					EndIf
					$perebor = $perebor + 1
				WEnd

				$currentbuf = 0
				$perebor = 1
				While $perebor < $komand_na_massiv
					If $parametr[$perebor] = "ТекущийБаф" Then
						$currentbuf = 1
						ExitLoop
					EndIf
					$perebor = $perebor + 1
				WEnd

				$buff = getBuffData($parametr[1], "buffs")
				Return plunusilok_koordinati($buff[1], $buff[0], $parametr[2], $parametr[3], $userDIR & $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $currentbuf)
			EndIf

		Case "СборОстатковАрмии"
			Local $perebor = 1, $flag_otpravka = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "Отправить" Then
					$flag_otpravka = 2
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			; $parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]
			While 1
				If openzvezdap() = 1 Then
					If selecttabatzvezda("specialisti", 0) = 1 Then
						If generali($gena, $parametr[2]) = 1 Then
							If $parametr[3] = "Э" Then
								While sborostatkovarmii(1, $flag_otpravka) <> 1
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								Return 1
							EndIf
							If $parametr[3] = "П" Then
								While sborostatkovarmii(0, $flag_otpravka) <> 1
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								Return 1
							EndIf
						Else
							Return 0
						EndIf
					EndIf
				EndIf
			WEnd
			
		Case "ЖдемСлив"
			If $komanda[2] = "1" Then
				If ProcessExists("proverkasliva.exe") Then
					ProcessClose("proverkasliva.exe")
					Sleep(3000)
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				Else
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				EndIf
			ElseIf $komanda[2] = "2" Then
				If ProcessExists("proverkasliva.exe") Then
					ProcessClose("proverkasliva.exe")
					Sleep(3000)
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				Else
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				EndIf
			ElseIf $komanda[2] = "3" Then
				If ProcessExists("proverkasliva.exe") Then
					ProcessClose("proverkasliva.exe")
					Sleep(3000)
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				Else
					Run("media\proverkasliva.exe " & $komanda[2])
					Return 1
				EndIf
			EndIf
			$parametr = StringSplit($komanda[2], ",")
			Return proverkasliva2($parametr[1], $parametr[2])

		Case "ОткрытьМонетку"
			Return opentitka($komanda[2])

		Case "ЗакрытьМонетку"
			Return closetitka()

		Case "Автосвадьба"
			Return opensvadba()

		Case "Автопанда"
			Return openpanda()

		Case "Звук"
			If $komanda[2] = "1" Then
			   alarmBeep()
			   _pause()
			   Return 1
			ElseIf $komanda[2] = "0" Then
			   alarmBeep()
			   Return 1
			Else
				Return 0
			EndIf
		Case "ЖдемКартинку"
			$parametr = StringSplit($komanda[2], ",")
			If $parametr[1] = "1" Then
				Return sleepwhile($userDIR & $parametr[2], $parametr[3], $parametr[4])
			ElseIf $parametr[1] = "0" Then
				Return sleepnowhile($userDIR & $parametr[2], $parametr[3], $parametr[4])
			Else
				Return 0
			EndIf
		Case "Выполнить"
			$parametr = StringSplit($komanda[2], ",")
			Run($parametr[1])
			Sleep(5000)
			If $parametr[2] = 1 Then
				While ProcessExists($parametr[1])
					Sleep(10000)
				WEnd
			EndIf
			Return 1
		Case "ЗвездаВниз"
			zvezdamovepolzunokdown($komanda[2])
			Return 1
		Case "Геологи"
			$parametr = StringSplit($komanda[2], ",")

			If UBound($parametr) = 4 Then
				$kakih = 0
			Else
				$kakih = getSpecialistData($parametr[4], "geologists")
				If ($kakih = "") Then
					MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_031"))
					Return 0
				EndIf
			EndIf

			Local $status = rungeolog($parametr[2], $parametr[3], $kakih)

			If $parametr[1] = 0 Then
				Return $status
			ElseIf $parametr[1] = 1 Then
				Return 1
			Else
				MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_032"))
				Return 0
			EndIf
		Case "СобратьПочту"
			If $komanda[2] = 1 Then
				Return runpo4ta("media\to_zvezda.bmp")
			Else
				Return runpo4ta("media\to_sklad.bmp")
			EndIf
		Case "Разведчики"
			$parametr = StringSplit($komanda[2], ",")

			Local $count_kakih = UBound($parametr) - 6
			Local $Arr_kakih[$count_kakih]

			For $j = 0 To $count_kakih - 1 Step + 1
				$Arr_kakih[$j] = $parametr[6 + $j]
			Next

  			Local $status = runrazved($parametr[2], $parametr[3], $parametr[4], $parametr[5], $count_kakih, $Arr_kakih)

			If $parametr[1] = 0 Then
				Return $status
			ElseIf $parametr[1] = 1 Then
				Return 1
			Else
				MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_032"))
				Return 0
			EndIf

		Case "ПОВТОРИТЬ"
			$pass_count = $pass_count - 1
			GUICtrlSetData($pass_cnt, $pass_count)			
			$strokadlaperehoda = $komanda[2]
			Return 1

		Case "СборКоллекций"
			openmashtab()
			collectwarikiatprikl(0)
			Return 1
		Case "ЖмемПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd

			Return clickOnCoordinates($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7])
		Case "НажатьКлавишу"
			Local $tmp_symbol
			$tmp_symbol = $komanda[2]
			Opt("WinTitleMatchMode",2)
			WinActivate(WinWait($windowTitle))
			If (StringInStr("0123456789", $tmp_symbol) <> 0) Then
				Sleep(500 * $tormoza)
				Send($tmp_symbol)
				Return 1
			Else
				If ($tmp_symbol = "+") Then
					Sleep(500 * $tormoza)
					Send("{NUMPADADD}", 0)
					Return 1
				Else
					If ($tmp_symbol = "-") Then
						Sleep(500 * $tormoza)
						Send("{NUMPADSUB}", 0)
						Return 1
					Else
						MsgBox(0, getLangPhrase("val_014"), getLangPhrase("val_033"))
						Return 0
					EndIf
				EndIf
			EndIf
		Case "НаборПоКоординатам"
			$centrovat = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			Local $perebor = 1
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]
			If $parametr[2] = "Э" Then
				While viborgenipodataku_elitanoini($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $full) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			If $parametr[2] = "П" Then
				While viborgenipodatakunoini($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $full) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			If $parametr[2] = "1" Then
				While viborgenipodataku_1nnoini($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1, 0, 0, 0, 0, 0, 0, 0, 0, $full) <> 1
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
				WEnd
			EndIf
			Return 1
		Case "НаборИатакаПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]
			If $parametr[2] = "Э" Then
				If stoitligena($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], 1) = 1 Then
					$ii = 0
					While apply_elitnoy_army($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $full, 0) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						stoitligena($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], 1)
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
					$gluksnaboromarmii = 0
					Return atakalageraotkritimgenoynoini($parametr[17], $parametr[18], $userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14])
				Else
					Return 0
				EndIf
			EndIf
			If $parametr[2] = "1" Then
				If stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1) = 1 Then
					If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 0 Then
						$ii = 0
						While applyarmy(1, 0, 0, 0, 0, 0, 0, 0, 0, $full, 0) <> 1
							zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
							stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1)
							$ii = $ii + 1 
      						If $ii > 5 Then Return 0
						WEnd
					EndIf	
					Return atakalageraotkritimgenoynoini($parametr[19], $parametr[20], $userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16])
				Else
					Return 0
				EndIf
			EndIf
			If $parametr[2] = "П" Then
				If stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1) = 1 Then
					$ii = 0
					While applyarmy($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $full, 0) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1)
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
				EndIf
					$gluksnaboromarmii = 0
					Return atakalageraotkritimgenoynoini($parametr[19], $parametr[20], $userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16])
				Else
					Return 0
			EndIf
		Case "НаборИпереносПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]
			If $parametr[2] = "Э" Then
				If stoitligena($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], 1) = 1 Then
					$ii  = 0
					While apply_elitnoy_army($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $full, 0) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						stoitligena($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], 1)
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
					$gluksnaboromarmii = 0
					Return perenosotkritimgenoynoini($parametr[17], $parametr[18], $userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14])
				Else
					Return 0
				EndIf
			EndIf
			If $parametr[2] = "1" Then
				If stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1) = 1 Then
					If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 0 Then
						$ii  = 0
						While applyarmy(1, 0, 0, 0, 0, 0, 0, 0, 0, $full, 0) <> 1
							zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
							stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1)
							$ii = $ii + 1 
      						If $ii > 5 Then Return 0
						WEnd
					EndIf	
					Return perenosotkritimgenoynoini($parametr[19], $parametr[20], $userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16])
				Else
					Return 0
				EndIf
			EndIf
			If $parametr[2] = "П" Then
				If stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1) = 1 Then
					$ii  = 0
					While applyarmy($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $full, 0) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						stoitligena($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18], 1)
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
				EndIf
					$gluksnaboromarmii = 0
					Return perenosotkritimgenoynoini($parametr[19], $parametr[20], $userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16])
				Else
					Return 0
			EndIf
		Case "ВыбратьПоКоординатамИотступить"
			$centrovat = 1
			Local $perebor = 1, $i = 0
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			
			If clickOnCoordinates($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7]) = 1 Then
				Sleep(600 * $tormoza)
				While (haveimage("media\" & $lang & "\zadacha_geni.bmp", 20) = 0) AND ($i < 3)
					sleepwhile("media\othod.bmp", 30, 2)
					zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
					clickOnCoordinates($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7])
					$i = $i + 1
				WEnd
				If $i = 3 Then
					Return 0
				EndIf
				zmemsmennuyukartinku("media\othod.bmp", 30, "media\othod_.bmp", 30)
			Else
				Return 0	
			EndIf
			Return 1
		
		Case "НаборИотправкаПоКоординатам"
			$centrovat = 1
			Local $perebor = 1
			$parametr = StringSplit($komanda[2], ",")
			$komand_na_massiv = UBound($parametr)
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "НеЦентровать" Then
					$centrovat = 0
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]
			Select
				Case $parametr[2] = "Э" AND openGenaOnpxp($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16]) = 1
					$ii  = 0
					While apply_elitnoy_army($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $full, 2) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						openGenaOnpxp($userDIR & $parametr[10], $parametr[11], $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16])
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
					$gluksnaboromarmii = 0
					Return 1
				Case $parametr[2] = "1" AND openGenaOnpxp($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18]) = 1	
					If haveimage("media\" & $lang & "\army_values\1.bmp", 20) = 1 Then
						zmemsmennuyukartinku("media\gohome.bmp", 30, "media\gohome_.bmp", 30)
						zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook_.bmp", 30)
						Return 1
					Else	
						$ii  = 0
						While applyarmy($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $full, 2) <> 1
							zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
							openGenaOnpxp($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18])
							$ii = $ii + 1 
      						If $ii > 5 Then Return 0
						WEnd
						$gluksnaboromarmii = 0
						Return 1
					EndIf
				Case $parametr[2] = "П"	AND openGenaOnpxp($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18]) = 1
					$ii  = 0
					While applyarmy($parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $full, 2) <> 1
						zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
						openGenaOnpxp($userDIR & $parametr[12], $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17], $parametr[18])
						$ii = $ii + 1 
      					If $ii > 5 Then Return 0
					WEnd
					$gluksnaboromarmii = 0
					Return 1
				Case Else	
					Return 0
			EndSelect

		Case "Клиент"
			If ($komanda[2] <> "Браузер") Then $windowTitle = $komanda[2]
			Return 1
		  
		Case "ОтправитьПриглашение"
			$parametr = StringSplit($komanda[2], ",")
			If  UBound($parametr) = 4 Then
				; передаем три параметра: картинка_прикла, картинка_гостя, первая буква ника_гостя
				local $letter = StringLower(StringMid($parametr[3], 1, 1)) ; выбираем 1ю букву ника и переводим в нижний регистр (игра не различает регистры)
				Return otpravkapriglasa_L($userDIR & $parametr[1], $userDIR & $parametr[2], $letter)
			Else
				; передаем два параметра: картинка_прикла, картинка_гостя
				Return otpravkapriglasa_L($userDIR & $parametr[1], $userDIR & $parametr[2], "_")
			EndIf
		
		Case "ПринятьПриглашение"
			Return prinatpriglas($userDIR & $komanda[2])

	EndSwitch
EndFunc

Func find_parametr($text, $result)
	Local $perebor = 0
	While $perebor < $komand_na_massiv
	WEnd
EndFunc