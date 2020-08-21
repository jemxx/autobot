#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=media\icon.ico
#AutoIt3Wrapper_Outfile=Autobot.exe
#AutoIt3Wrapper_Outfile_x64=Autobot_x64.exe
#AutoIt3Wrapper_Res_Description=Автобот для The Settlers
#AutoIt3Wrapper_Res_Fileversion=0.0.18.14
#AutoIt3Wrapper_Res_ProductName=Автобот
#AutoIt3Wrapper_Res_ProductVersion=0.18
#AutoIt3Wrapper_Res_LegalCopyright=2020 © by mysettlers.ru & Jemxx
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If WinExists('[CLASS:AutoIt v3;TITLE:' & @ScriptName & ']') Then
    MsgBox(48, @ScriptName, 'Разрешено запускать только одну копию Автобота!' & @CRLF & @CRLF & 'ОК ==> ВЫХОД')
    Exit
EndIf
AutoItWinSetTitle(@ScriptName)

If ProcessExists("Универсальный_бот.exe") Then ProcessClose ("Универсальный_бот.exe")

Global $alarm = 0, $passagesDir
Global $userDIR = "media\users\"

Global $k_x, $k_y, $tochka_sektora_x=0, $tochka_sektora_y=0
Global $shtuk, $i = 1, $register = 0
Global $komand_na_massiv = 0
Global $strokadlaperehoda = 0
Global $centrovat = 1, $currentbuf = 0
Global $stroka
Global $pass_unlim_yes = 0, $pass_count

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
	Global $level = GUICreate("Автобот", 225, 400, @DesktopWidth - 245, 20)
	GUISetBkColor(16777088)
	GUICtrlCreateLabel("Проходим по файлу", 5, 10)
	Global $file_gui = GUICtrlCreateCombo("", 5, 30, 215, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))
	_GUICtrlComboBox_SetMinVisible($file_gui, 23)
	GUICtrlSetData(-1, $stroka, read_ini(3))
	GUICtrlCreateLabel("Начинаем со строки", 5, 60)
	Global $file_gui2 = GUICtrlCreateInput("1", 5, 80, 215, 20)
	GUICtrlCreateLabel("Количество повторов", 5, 110)
	Global $pass_cnt = GUICtrlCreateInput("1", 5, 130, 215, 20)

	Global $pass_unlim = GUICtrlCreateCheckbox("Повторять бесконечно", 5, 160, 180, 25)
	GUICtrlSetState($pass_unlim, $GUI_CHECKED)
	Global $obnova = GUICtrlCreateCheckbox("Проверять обновления", 5, 180, 180, 25)
	GUICtrlSetState($obnova, $GUI_UNCHECKED)
	Global $osibki = GUICtrlCreateCheckbox("Выводить предупреждения", 5, 200, 180, 25)
	GUICtrlSetState($osibki, $GUI_UNCHECKED)
	Global $alarmCheckBox = GUICtrlCreateCheckbox("Включить Тревогу", 5, 220, 180, 25)
	GUICtrlSetState($alarmCheckBox, $GUI_CHECKED)

	;Проверяем состояние чата
	If read_ini(8) = "" Then
		If ProcessExists("Чат.exe") Then
		Else
			Run("Чат.exe")
		EndIf
	ElseIf read_ini(8) = 0 Then
	Else
		If ProcessExists("Чат.exe") Then
		Else
			Run("Чат.exe")
		EndIf
	EndIf
	;Проверяем флаг разрыва соединения
	If read_ini(10) = "" Then
		If ProcessExists("serverOFF.exe") Then
		Else
			Run("media\serverOFF.exe")
		EndIf
	ElseIf read_ini(10) = 0 Then
		If ProcessExists("serverOFF.exe") Then ProcessClose("serverOFF.exe")
	Else
		If ProcessExists("serverOFF.exe") Then
		Else
			Run("media\serverOFF.exe")
		EndIf
	EndIf

	Global $no1_1 = GUICtrlCreateButton("ЗАПУСК", 5, 260, 215, 30)
	Global $pr8 = GUICtrlCreateButton("Поддержать проект", 5, 300, 215, 20)
	Global $pr9 = GUICtrlCreateButton("Справка", 5, 330, 215, 20)
	GUICtrlCreateLabel("F7 - пауза до слива", 5, 360)
	GUICtrlCreateLabel("F9 - пауза, F11 - прервать", 5, 380)
	$haccelinterupt = GUICtrlCreateDummy()
	Dim $accelkeys[1][2] = [["z", $haccelinterupt]]
	GUISetAccelerators($accelkeys)
	GUIRegisterMsg($wm_command, "_WM_COMMAND")
	GUISetState(@SW_SHOW)
	If read_ini(7) = "" Then
		MsgBox(0, "Непорядок", "Вы не заполнили поле Ник_в_чате в файле настроек autobot.ini")
		Exit
	EndIf
	While 1
		$nmsg = GUIGetMsg()
		Switch $nmsg
			Case $gui_event_close
				Exit
			Case $no1_1
				tormoza()
				TrayTip("", "Мы запустились...", 0)

				Global $abot = $passagesDir & "\" & GUICtrlRead($file_gui)
				If FileExists($abot) Then
					$i = GUICtrlRead($file_gui2)
					$pass_count = GUICtrlRead($pass_cnt)

					setstatistik()
					$register = 0

					If GUICtrlRead($obnova) == $GUI_CHECKED Then
						obnova()
					EndIf
					If GUICtrlRead($alarmCheckBox) == $GUI_CHECKED Then
						$alarm = 1
					EndIf
					If GUICtrlRead($pass_unlim) == $GUI_CHECKED Then
						$pass_unlim_yes = 1
					EndIf
					If ProcessExists("proverkasliva.exe") Then
						ProcessClose("proverkasliva.exe")
					EndIf

					register()
					gogogogo()
				Else
					MsgBox(0, "Внимание!!!", "Выбранный файл с прохождением не найден!")
					Exit
				EndIf
			Case $pr8
				ShellExecute("media\help.html")
			Case $pr9
				ShellExecute("Команды_Автобота.html")
		EndSwitch
	WEnd
#EndRegion ### END Koda GUI section ###

Func obnova()
;Проверяем обновления
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
		If MsgBox(4, "Внимание!!!", "Доступна новая версия программы." & @CR & @CR & $fulltext & @CR & @CR & @CR & @CR & "Скачать сейчас?") = 6 Then
			ShellExecute("http://mysettlers.ru/instrumenty/boty/item/121-sozdajom-bota-dlya-sebya")
			Sleep(3000)
			Exit
		EndIf
	EndIf
EndFunc

Func printerror($text)
;Вывод ошибки
   If GUICtrlRead($osibki) == $GUI_UNCHECKED Then Return 1
   MsgBox(0, "!!!", $text)
EndFunc

Func terminater()
;Закрыть Автобота
	TrayTip("", "Закрываемся...", 0)
	Sleep(1000)
	Exit
EndFunc

Func gogogogo()
;Основной цикл построчного чтения команд
	Local $ttt = _filecountlines($abot)
	If $ttt = 1 Then $i = 0
	While $i <= _filecountlines($abot)
	;Зареган ли автобот?
		If $ttt = 1 Then $i = 1
		register()
		If FileReadLine($abot, $i) = "ПОВТОРИТЬ" Then
			If $pass_unlim_yes = 0 Then
				$pass_count = $pass_count - 1
				GUICtrlSetData($pass_cnt, $pass_count)
			EndIf
			$i = 1
			;setstatistik()
		EndIf
		If ($pass_unlim_yes = 0) AND (GUICtrlRead($pass_cnt) = 0) Then ; кончились прохождения
				MsgBox(0, "", "Прошли нужное количество")
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
		If $stroka = "" Then ExitLoop
		Global $komanda = StringSplit($stroka, "=")
		$delaem = $komanda[1]
		printerror("Начинаем выполнять команду из " & $i & " строки." & @CR & @CR & "Делаем: " & $delaem & @CR & "С параметром: " & $komanda[2])
		If komanda($delaem) = 1 Then
			printerror("Команда из " & $i & " строки." & @CR & @CR & "Делаем: " & $delaem & @CR & "С параметром: " & $komanda[2] & @CR & @CR & "ВЫПОЛНЕНА УСПЕШНО")
		Else
			If $alarm = 1 Then alarmBeep()
			printerror("Команда из " & $i & " строки." & @CR & @CR & "Делаем: " & $delaem & @CR & "С параметром: " & $komanda[2] & @CR & @CR & "НЕ ВЫПОЛНЕНА. ОСТАНАВЛИВАЕМСЯ")
			MsgBox(0, "ВНИМАНИЕ!!!", "Из строки " & $i & @CR & "Мы не смогли сделать" & @CR & @CR & $stroka & @CR & @CR & "поэтому и остановились(((")
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
;функция исполнения флагов
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
;~ 		Case "/Количество"
;~ 			If $pass_count_flag = 0 Then
;~ 				$pass_all = $parametr[2]
;~ 				$pass_count = $pass_all
;~ 				$pass_count_flag = 1
;~ 			Else
;~ 				TrayTip("", "Флаг Количество указан повторно - значение проигнорировано", 0)
;~ 			EndIf
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
				If selecttabatzvezda("specialisti", 0) = 1 Then
					If generali($gena, $parametr[2]) = 1 Then
						If $parametr[3] = "Э" Then
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, $parametr[11]) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							Return 1
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\1.bmp", 20) = 1 Then
								Return 1
							Else
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, $parametr[13]) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								Return 1
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, $parametr[13]) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							Return 1
						Else
							Return 0
						EndIf
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
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							$gluksnaboromarmii = 0
							Return atakalageraotkritimgenoynoini($parametr[11], $parametr[12], $userDIR & $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17])
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\1.bmp", 20) = 1 Then
								Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							Else
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								$gluksnaboromarmii = 0
								Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							$gluksnaboromarmii = 0
							Return atakalageraotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
						Else
							Return 0
						EndIf
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
							While apply_elitnoy_army($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							$gluksnaboromarmii = 0
							Return perenosotkritimgenoynoini($parametr[11], $parametr[12], $userDIR & $parametr[13], $parametr[14], $parametr[15], $parametr[16], $parametr[17])
						EndIf
						If $parametr[3] = "1" Then
							If haveimage("media\1.bmp", 20) = 1 Then
								Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							Else
								While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
									zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								$gluksnaboromarmii = 0
								Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
							EndIf
						EndIf
						If $parametr[3] = "П" Then
							While applyarmy($parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $parametr[9], $parametr[10], $parametr[11], $parametr[12], $full, 0) <> 1
								zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
								openzvezdap()
								selecttabatzvezda("specialisti", 1)
								generali($gena, $parametr[2])
							WEnd
							$gluksnaboromarmii = 0
							Return perenosotkritimgenoynoini($parametr[13], $parametr[14], $userDIR & $parametr[15], $parametr[16], $parametr[17], $parametr[18], $parametr[19])
						Else
							Return 0
						EndIf
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
			Return sleepwhile2($generalData[0], $parametr[2], $parametr[3])

		Case "ЖдемГенерала"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			Return ozidanierasstanovki2($generalData[0], $parametr[2])

		Case "ЖдемВсехГенералов"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			Return ozidanierasstanovki($generalData[0], $generalData[2], $parametr[2])

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
			Return stoitligena($userDIR & $parametr[1], $parametr[2], $parametr[3], $parametr[4], $parametr[5], $parametr[6], $parametr[7])
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
			MsgBox(0, "Сообщение", $komanda[2])
			Return 1

		Case "Стрельнуть"
			If $komanda[2] = "Бронзоподкова" Then
				If open_usilok("usiliteli", "media\br_podkova.bmp", 0) = 1 Then
					zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook.bmp", 30)
					Return 1
				EndIf
			ElseIf $komanda[2] = "Платиноподкова" Then
				If open_usilok("usiliteli", "media\pl_podkova.bmp", 0) = 1 Then
					zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook.bmp", 30)
					Return 1
				EndIf
			ElseIf $komanda[2] = "Обсидиановая" Then
				If open_usilok("usiliteli", "media\obsid_podkova.bmp", 0) = 1 Then
					zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook.bmp", 30)
					Return 1
				EndIf
			EndIf
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
			$currentbuf = 0
			$perebor = 1
			While $perebor < $komand_na_massiv
				If $parametr[$perebor] = "ТекущийБаф" Then
					$currentbuf = 1
					ExitLoop
				EndIf
				$perebor = $perebor + 1
			WEnd
			If $parametr[1] = "Стрела" Then
			   $img_usilka = "media\strela.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "ГорящаяСтрела" Then
			   $img_usilka = "media\gor_strela.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "ШокоСтрела" Then
			   $img_usilka = "media\shoko_strela.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Баллиста" Then
			   $img_usilka = "media\balista.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "БольшаяКатапульта" Then
			   $img_usilka = "media\bolshaja_katapulta.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "МаленькаяКатапульта" Then
			   $img_usilka = "media\malenkaja_katapulta.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Убийца" Then
			   $img_usilka = "media\boshka.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Стейк" Then
			   $img_usilka = "media\steik.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Наноирма" Then
			   $img_usilka = "media\nanoirma.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Ирма" Then
			   $img_usilka = "media\irma.bmp"
			   $tb_name = "usiliteli"
			ElseIf $parametr[1] = "Нубы" Then
			   $img_usilka = "media\nubi_in_zvezda.bmp"
			   $tb_name = "raznoe"
			EndIf
			Return plunusilok_koordinati($tb_name, $img_usilka, $parametr[2], $parametr[3], $userDIR & $parametr[4], $parametr[5], $parametr[6], $parametr[7], $parametr[8], $currentbuf)
		Case "СборОстатковАрмии"
			$parametr = StringSplit($komanda[2], ",")
			$generalData = getGeneralData($parametr[1])
			$gena = $generalData[0]
			$full = $generalData[1]

			While 1
				If openzvezdap() = 1 Then
					If selecttabatzvezda("specialisti", 0) = 1 Then
						If generali($gena, $parametr[2]) = 1 Then
							If $parametr[3] = "Э" Then
								While sborostatkovarmii(1) <> 1
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								Return 1
							EndIf
							If $parametr[3] = "П" Then
								While sborostatkovarmii(0) <> 1
									openzvezdap()
									selecttabatzvezda("specialisti", 1)
									generali($gena, $parametr[2])
								WEnd
								Return 1
							EndIf
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
					MsgBox(0, "Внимание!", "Неправильный параметр типа Геолога")
					Return 0
				EndIf
			EndIf

			Local $status = rungeolog($parametr[2], $parametr[3], $kakih)

			If $parametr[1] = 0 Then
				Return $status
			ElseIf $parametr[1] = 1 Then
				Return 1
			Else
				MsgBox(0, "!!!", "Неправильный параметр флага")
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

			If UBound($parametr) = 6 Then
				$kakih = 0
			Else
				$kakih = getSpecialistData($parametr[6], "scouts")
				If ($kakih = "") Then
					MsgBox(0, "Внимание!", "Неправильный параметр типа Разведчика")
					Return 0
				EndIf
			EndIf

			Local $status = runrazved($parametr[2], $parametr[3], $parametr[4], $parametr[5], $kakih)

			If $parametr[1] = 0 Then
				Return $status
			ElseIf $parametr[1] = 1 Then
				Return 1
			Else
				MsgBox(0, "!!!", "Неправильный параметр флага")
				Return 0
			EndIf

		Case "ПОВТОРИТЬ"
			If $pass_unlim_yes = 0 Then
				$pass_count = $pass_count - 1
				GUICtrlSetData($pass_cnt, $pass_count)
			EndIf
			$strokadlaperehoda = $komanda[2]
			Return 1

		Case "СборКоллекций"
			collectwarikiatprikl()
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
		Case "Нажать"
			If $komanda[2] = "0" Then
			   MouseMove(@DesktopWidth / 2, @DesktopHeight / 2, 10 * $tormoza)
			   MouseDown("left")
			   MouseMove(@DesktopWidth / 2 + 100, @DesktopHeight / 2, 10 * $tormoza)
			   Sleep(500 * $tormoza)
			   MouseUp("left")
			   Sleep(500 * $tormoza)
			   MouseUp("left")
			EndIf
			Send($komanda[2])
			Return 1
	EndSwitch
EndFunc

Func find_parametr($text, $result)
	Local $perebor = 0
	While $perebor < $komand_na_massiv
	WEnd
EndFunc