#include "imagesearch32.au3"
#Include <GUIConstants.au3>
#include "File.au3"
#include <WinAPIEx.au3>
#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <InetConstants.au3>
#include <Inet.au3>
#include <Encoding.au3>

Global $sfile = "autobot.ini"
Global $hfile = FileOpen($sfile)
Global $zalezi = 12
Global $tormoza = Read_ini(9), $soblaliWariki = 0
Global $Consol_a_ne_Client = 0
Global $razmer_okna_igri = 162
Local $Stroka = 0, $Stolbec = 0, $Zapros=""
;Global $Zvezda_area[4]
Global $chasi_gui
Global $minuti_gui
Global $sekundi_gui
Global $sfile2 = "log.txt"
;Global $hfile2 = FileOpen($sfile2)
Dim $iPause

#Region общие
func ZmemSmennuyuKartinku($Kartinka1, $Tolerance1, $Kartinka2, $Tolerance2)
	Local $tx =0, $ty = 0
	While (_imagesearch($Kartinka1, 1, $tx, $ty, $Tolerance1) = 1) OR (_imagesearch($Kartinka2, 1, $tx, $ty, $Tolerance2) = 1)
		if _imagesearch($Kartinka1, 1, $tx, $ty, $Tolerance1) = 1 then
			;writelog(" ZSK " & $Kartinka1)
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
			MouseClick("left", $tx, $ty)
			Sleep(500 * $tormoza)
		Elseif _imagesearch($Kartinka2, 1, $tx, $ty, $Tolerance2) = 1 then
			;writelog(" ZSK " & $Kartinka2)
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
			MouseClick("left", $tx, $ty)
			Sleep(500 * $tormoza)
		Endif
	Wend
	;writelog(@CRLF)
endfunc
func ZmemSmennuyuKartinkuIZdem($Kartinka1, $Tolerance1, $Kartinka2, $Tolerance2, $Rezult, $ToleranceRezult)
	Local $tx =0, $ty = 0
	While (_imagesearch($Kartinka1, 1, $tx, $ty, $Tolerance1) = 1) OR (_imagesearch($Kartinka2, 1, $tx, $ty, $Tolerance2) = 1)
		if _imagesearch($Kartinka1, 1, $tx, $ty, $Tolerance1) = 1 then
		;writelog(" ZSKIZ " & $Kartinka1 & " | ")
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
			MouseClick("left", $tx, $ty)
			Sleep(1000 * $tormoza)
			if _imagesearch($Rezult, 1, $tx, $ty, $ToleranceRezult) = 1 then
				;writelog("Rezult" & @CRLF)
				Return 1
			endif
		Elseif _imagesearch($Kartinka2, 1, $tx, $ty, $Tolerance2) = 1 then
			;writelog(" ZSKIZ " & $Kartinka2 & " | "
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
			MouseClick("left", $tx, $ty)
			Sleep(1000 * $tormoza)
			if _imagesearch($Rezult, 1, $tx, $ty, $ToleranceRezult) = 1 then
			;writelog("Rezult" & @CRLF)
				Return 1
			endif
		Endif
	Wend
	;writelog(@CRLF)
endfunc
Func tormoza()
   $tormoza = Read_ini(9)
EndFunc

Func nuzniekoordinatidlabafa()
	Local $ax = 0, $ay = 0, $cx = 0, $cy = 0, $good = 0
	While $good < 5
		If _imagesearch("media\zvezda.bmp", 1, $ax, $ay, 90) = 1 Then
			If _imagesearch("media\pismo.bmp", 1, $cx, $cy, 90) = 1 Then
				$levonizxnado = $cx + 50
				$levonizynado = $ay - 250
				$levoverhxnado = $cx + 50
				$levoverhynado = $cy - 70
				$pravonizxnado = @DesktopWidth - 200
				$pravonizynado = $ay - 340
				$pravoverhxnado = @DesktopWidth - 60
				$pravoverhynado = $cy - 70
				Return 1
			EndIf
		EndIf
		$good = $good + 1
	WEnd
	Return 0
EndFunc

Func chatoff()
	If haveimage("media\4atOff.bmp", 20) = 1 Then
		;TrayTip("", "Чат свернут", 0)
		Return 1
	EndIf
	If findclickoncenterandwaitresult("media\4atOn.bmp", "media\4atOff.bmp", 40, 20, 0, 2, 0, 20, 20) = 1 Then
		;TrayTip("", "Чат свернули", 0)
		Return 1
	Else
		;TrayTip("", "Чат не свернули", 0)
		Return 0
	EndIf
	Return 0
EndFunc

Func drugioff()
	Local $ay = 0, $ax = 0, $good = 0
	If haveimage("media\Drugi.bmp", 20) <> 1 Then
		;TrayTip("", "Панель друзей свернута", 0)
		Return 1
	EndIf
	While (haveimage("media\Drugi.bmp", 20) = 1) AND ($good < 3)
		If _imagesearch("media\zvezda.bmp", 1, $ax, $ay, 50) = 1 Then
			MouseMove($ax, $ay + 40, 10 * $tormoza)
			MouseClick("left", $ax + Random(1, 5, 1), $ay + 40 + Random(1, 4, 1), 1)
		EndIf
		$good = $good + 1
		Sleep(1000 * $tormoza)
	WEnd
	If haveimage("media\Drugi.bmp", 20) <> 1 Then
		;TrayTip("", "Панель друзей свернули", 0)
		Return 1
	EndIf
	If haveimage("media\Drugi.bmp", 20) = 1 Then
		;TrayTip("", "Панель друзей не свернули", 0)
		Return 0
	EndIf
EndFunc
Func go5()
	MouseMove(5, 5, 1 * $tormoza)
	Sleep(100 * $tormoza)
EndFunc
Func _pause()
	writelog("===============pause" & @CRLF)
	$ipause = NOT $ipause
	TrayTip("", "пауза...", 0)
	While $ipause
		Sleep(250 * $tormoza)
	WEnd
	TrayTip("", "убрали паузу...", 0)
EndFunc
Func terminate()
	TrayTip("", "Закрываемся...", 0)
	Sleep(1000 * $tormoza)
	Run('Универсальный_бот.exe')
	exit
EndFunc

Func openmashtab()
Sleep(100 * $tormoza)
WinActivate("The Settlers Онлайн")
writelog("openmashtab" & @CRLF)
	MouseMove(@DesktopWidth/2, @DesktopHeight/2, 10 * $tormoza)
	MouseDown("left")
	MouseMove(@DesktopWidth/2+100, @DesktopHeight/2, 10 * $tormoza)
	Sleep(500 * $tormoza)
	MouseUp("left")
	Sleep(500 * $tormoza)
	MouseUp("left")
	MouseWheel("down", 25)
	Sleep(1000 * $tormoza)
	MouseWheel("down", 45)
	Sleep(1000 * $tormoza)
Return 1
EndFunc

Func interrupt()
	$finterrupt = 1
	TrayTip("", "Прерываем все запущенные процессы", 0)
EndFunc

Func haveimage($img, $tolerance)
	Local $ty = 0, $tx = 0
	;writelog("haveimage " & StringMid($img, 6, StringLen($img)-4) & " " & $tolerance & @CRLF)
	Return _imagesearch($img, 1, $tx, $ty, $tolerance)
EndFunc

Func haveimageAREA($img, $tolerance, $smX1, $smY1, $smX2, $smY2)
	Local $ty = 0, $tx = 0
	;writelog("haveimage " & StringMid($img, 6, StringLen($img)-4) & " " & $tolerance & @CRLF)
	Return _imagesearcharea($img, 1, $smX1, $smY1, $smX2, $smY2, $tx, $ty, $tolerance)
EndFunc

Func removemouse($dx, $dy, $sleep)
	Local $pos = MouseGetPos()
	MouseMove($pos[0] + $dx, $pos[1] + $dy, 5 * $tormoza)
	Sleep($sleep * $tormoza)
EndFunc

Func waitwhileimgwillpresent($img, $tolerance, $timeoutsec)
	Local $htimer = TimerInit()
	While (haveimage($img, $tolerance) = 0) AND (TimerDiff($htimer) < $timeoutsec * 1000)
		Sleep(1000 * $tormoza)
	WEnd
	If (TimerDiff($htimer) >= $timeoutsec * 1000) Then
		Return 0
	Else
		Return 1
	EndIf
	Sleep(100 * $tormoza)
EndFunc

Func waitwhileimgwillremoved($img, $tolerance, $timeoutsec)
	Local $htimer = TimerInit()
	While (haveimage($img, $tolerance) = 1) AND (TimerDiff($htimer) < $timeoutsec * 1000)
		Sleep(1000 * $tormoza)
	WEnd
	If (TimerDiff($htimer) >= $timeoutsec * 1000) Then
		Return 0
	Else
		Return 1
	EndIf
	Sleep(100 * $tormoza)
EndFunc

Func findclickoncenterandwaitresult($img2click, $imgofresult, $tolerance_click, $tolerance_result, $randomcoords2click, $timeoutsec, $donotclickifdisplayed, $rvmdx, $rvmdy)
	Local $ty = 0, $tx = 0, $search = 0, $clicked = 0
	Local $htimer = TimerInit()
	writelog("FCAWR DCFD =" & $donotclickifdisplayed & " | " & $img2click & " | ")
	If $donotclickifdisplayed = 1 Then
		$search = haveimage($imgofresult, $tolerance_result)
	EndIf
	While ($search <> 1) AND (TimerDiff($htimer) < $timeoutsec * 3000)
		Sleep(100 * $tormoza)
		If ($clicked = 0) Then
			$search = _imagesearch($img2click, 1, $tx, $ty, $tolerance_click)
			If $search = 1 Then
			writelog("Нашли I2C | ")
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(300 * $tormoza)
				MouseClick("left", $tx + Random(0, $randomcoords2click, 1), $ty + Random(0, $randomcoords2click, 1), 1)
				Sleep(300 * $tormoza)
				removemouse($rvmdx, $rvmdy, 100)
				sleepwhile($imgofresult, $tolerance_result, $timeoutsec)
				;$clicked = 1
			EndIf
		EndIf
		Sleep(500 * $tormoza)
		$search = haveimage($imgofresult, $tolerance_result)
	WEnd
	If $search = 1 Then
		writelog("Успех " & $htimer & @CRLF)
		Return 1
	Else
		writelog("Неудачно " & $htimer & @CRLF)
		Return 0
	EndIf
EndFunc

Func findclickoncenterandwaitresultAREA($img2click, $imgofresult, $smX1, $smY1, $smX2, $smY2, $tolerance_click, $tolerance_result, $randomcoords2click, $timeoutsec, $donotclickifdisplayed, $rvmdx, $rvmdy)
	Local $ty = 0, $tx = 0, $search = 0, $clicked = 0, $searchAREA = 0, $ay = 0, $ax = 0
	Local $htimer = TimerInit()
	;writelog("FCAWRAREA DCFD=" & $donotclickifdisplayed & " | " & $img2click & " | ")
	If $donotclickifdisplayed = 1 Then
		$search = haveimage($imgofresult, $tolerance_result)
	EndIf
	;writelog("SA=" & $searchAREA & " | ")
	While ($search <> 1) AND (TimerDiff($htimer) < $timeoutsec * 1000)
		Sleep(100 * $tormoza)
		If ($clicked = 0) Then
			$search =_imagesearcharea($img2click, 1, $smX1, $smY1, $smX2, $smY2, $tx, $ty, $tolerance_click)
			If $search = 1 Then
			;writelog("Нашли I2C | ")
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(300 * $tormoza)
				MouseClick("left", $tx + Random(0, $randomcoords2click, 1), $ty + Random(0, $randomcoords2click, 1), 1)
				Sleep(300 * $tormoza)
				removemouse($rvmdx, $rvmdy, 100)
				;$clicked = 1
			EndIf
		EndIf
		Sleep(500 * $tormoza)
		$search = haveimage($imgofresult, $tolerance_result)
	WEnd
	If $search = 1 Then
		;writelog("Успех " & $htimer & @CRLF)
		Return 1
	Else
		;writelog("Неудачно " & $htimer & @CRLF)
		Return 0
	EndIf
EndFunc

Func findclickoncenterandwaitresult1($img2click, $imgofresult, $tolerance_click, $tolerance_result, $randomcoords2click, $timeoutsec, $donotclickifdisplayed, $rvmdx, $rvmdy)
	Local $ty = 0, $tx = 0, $search = 0, $clicked = 0, $pos = MouseGetPos()
	Local $htimer = TimerInit()
	writelog("FCAWR1=" & $donotclickifdisplayed & " | " & $img2click & " | ")
	If $donotclickifdisplayed = 1 Then
		$search = haveimage($imgofresult, $tolerance_result)
	EndIf
	While ($search <> 1) AND (TimerDiff($htimer) < $timeoutsec * 1000)
		Sleep(100 * $tormoza)
		If ($clicked = 0) Then
			$search = _imagesearch($img2click, 1, $tx, $ty, $tolerance_click)
			If $search = 1 Then
			writelog("Нашли I2C | ")
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(300 * $tormoza)
				MouseClick("left", $tx + Random(0, $randomcoords2click, 1), $ty + Random(0, $randomcoords2click, 1), 1)
				Sleep(300 * $tormoza)
				removemouse($rvmdx, $rvmdy, 100)
				$pos = MouseGetPos()
				MouseClick("left", $pos[0], $pos[1], 1)
				;$clicked = 1
			EndIf
		EndIf
		Sleep(500 * $tormoza)
		$search = haveimage($imgofresult, $tolerance_result)
	WEnd
	If $search = 1 Then
		writelog("Успех " & $htimer & @CRLF)
		Return 1
	Else
		writelog("Неудачно " & $htimer & @CRLF)
		Return 0
	EndIf
EndFunc

Func findclickoncenterandwaitnoneresult($img2click, $tolerance_click, $randomcoords2click, $timeoutsec, $rvmdx, $rvmdy)
Local $ty = 0, $tx = 0, $search = 0, $clicked = 0
Local $htimer = TimerInit()
writelog("FCAWNR=" & $img2click & " | ")
	While (_imagesearch($img2click, 1, $tx, $ty, $tolerance_click) = 1) and (TimerDiff($htimer) < $timeoutsec * 1000)
	Sleep(100 * $tormoza)
	$search = _imagesearch($img2click, 1, $tx, $ty, $tolerance_click)
		If $search = 1 Then
		writelog("Нашли I2C | ")
			MouseMove($tx, $ty, 10 * $tormoza)
			MouseClick("left", $tx + Random(0, $randomcoords2click, 1), $ty + Random(0, $randomcoords2click, 1), 1)
			Sleep(100 * $tormoza)
			removemouse($rvmdx, $rvmdy, 100)
			Sleep(300 * $tormoza)
			if _imagesearch($img2click, 1, $tx, $ty, $tolerance_click) = 1 then
				writelog("ПОВТОР!!! | ")
				MouseClick("left")
			endif
		EndIf
	Sleep(500 * $tormoza)
	WEnd
	$search = _imagesearch($img2click, 1, $tx, $ty, $tolerance_click)
	If $search = 0 Then
		writelog("Успех " & $htimer & @CRLF)
		Return 1
	Else
		writelog("Неудачно " & $htimer & @CRLF)
		Return 0
	EndIf
EndFunc
Func findclickoncenterandwaitwhenwillremoved($img2click, $imgofresult, $tolerance_click, $tolerance_result, $randomcoords2click, $timeoutsec, $donotclickifremoved, $rvmdx, $rvmdy)
	Local $ty = 0, $tx = 0, $search = 1, $clicked = 0
	Local $htimer = TimerInit()
	;writelog("FCAWR1=" & $donotclickifdisplayed & " | " & $img2click & " | " & @CRLF)
	If $donotclickifremoved = 1 Then
		$search = haveimage($imgofresult, $tolerance_result)
		If $search = 0 Then
			Return 1
		EndIf
	EndIf
	While ($search = 1) AND (TimerDiff($htimer) < $timeoutsec * 1000)
		Sleep(100 * $tormoza)
		If ($clicked = 0) Then
			$search = _imagesearch($img2click, 1, $tx, $ty, $tolerance_click)
			If $search = 1 Then
				MouseMove($tx, $ty, 10 * $tormoza)
				MouseClick("left", $tx + Random(0, $randomcoords2click, 1), $ty + Random(0, $randomcoords2click, 1), 1)
				Sleep(100 * $tormoza)
				removemouse($rvmdx, $rvmdy, 50)
				$clicked = 1
			EndIf
		EndIf
		$search = haveimage($imgofresult, $tolerance_result)
	WEnd
	If $search = 0 Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func collectwarikiatprikl()
	Local $ciklov = 0
	;TrayTip("", "Собираем шарики ... ", 0)
	WinActivate("The Settlers Онлайн")
	;Return 1
	While (haveimage("media\warik.bmp", 50) = 1) AND ($ciklov < 50)
		findclickoncenterandwaitresult("media\warik.bmp", "media\warik_label_collected.bmp", 50, 10, 2, 10, 0, 50, 50)
		Sleep(3000 * $tormoza)
		$ciklov = $ciklov + 1
	WEnd
EndFunc

Func openzvezda()
	Return openzvezdaP()
EndFunc
Func openzvezdaP()
	;writelog("openzvezda | ")
	WinActivate("The Settlers Онлайн")

	Local $ty = 0, $tx = 0, $search = 0
	Local $htimer = TimerInit()

	setstatistik()
	;Register()

	$search =  _imagesearch("media\zvezda_is_displayed.bmp", 1, $tx, $ty, 70)
	While ($search <> 1) AND (TimerDiff($htimer) < 60000)
		$search = _imagesearcharea("media\zvezda.bmp", 1, (@DesktopWidth/2 - 100), (@DesktopHeight/2), (@DesktopWidth/2 + 100), (@DesktopHeight), $tx, $ty, 80)

		If $search = 1 Then
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(1000 * $tormoza)
			MouseClick("left", $tx + Random(0, 5, 1), $ty + Random(0, 5, 1), 1)
			Sleep(1000 * $tormoza)
			removemouse(300, 0, 100)
			;$clicked = 1
		EndIf

		sleepwhile("media\zvezda_is_displayed.bmp", 80, 10)
		$search = _imagesearch("media\zvezda_is_displayed.bmp", 1, $tx, $ty, 70)
	WEnd

	If $search = 1 Then
		Global $Zvezda_area[4] = [$tx - 520, $ty, $tx, $ty + 340]
		Return 1
	Else
		;writelog("Неудачно " & $htimer & @CRLF)
		Return 0
	EndIf
EndFunc

Func SelectTabAtZvezda($tabname, $donotclickifdisplayed)
	Switch $tabname
		Case "all"
		Case "specialisti"
			If haveimage("media\zvezda_specialisti_tab_enabled.bmp", 50) = 1 Then
				Return findclickoncenterandwaitresult("media\zvezda_specialisti_tab_enabled.bmp", "media\zvezda_specialisti_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			Else
				Return findclickoncenterandwaitresult("media\zvezda_specialisti_tab_disabled.bmp", "media\zvezda_specialisti_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			EndIf
		Case "usiliteli"
			If haveimage("media\zvezda_usiliteli_tab_enabled.bmp", 50) = 1 Then
				Return findclickoncenterandwaitresult("media\zvezda_usiliteli_tab_enabled.bmp", "media\zvezda_usiliteli_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			Else
				Return findclickoncenterandwaitresult("media\zvezda_usiliteli_tab_disabled.bmp", "media\zvezda_usiliteli_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			EndIf
		Case "prikli"
			If haveimage("media\zvezda_prikli_tab_enabled.bmp", 50) = 1 Then
				Return findclickoncenterandwaitresult("media\zvezda_prikli_tab_enabled.bmp", "media\zvezda_prikli_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			Else
				Return findclickoncenterandwaitresult("media\zvezda_prikli_tab_disabled.bmp", "media\zvezda_prikli_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			EndIf
		Case "raznoe"
			If haveimage("media\zvezda_raznoe_tab_enabled.bmp", 50) = 1 Then
				Return findclickoncenterandwaitresult("media\zvezda_raznoe_tab_enabled.bmp", "media\zvezda_raznoe_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			Else
				Return findclickoncenterandwaitresult("media\zvezda_raznoe_tab_disabled.bmp", "media\zvezda_raznoe_tab_enabled.bmp", 50, 50, 4, 10, $donotclickifdisplayed, 0, 10)
			EndIf
		Case Else
			MsgBox(0, "SelectTabAtZvezda", "Неверный параметр $tabname")
			Return 0
	EndSwitch
	Return 0
EndFunc
Func zvezdamovepolzunokdown($move_quickly)
	Local $ty = 0, $tx = 0, $search = 0
	writelog("         ZMPD=" & $move_quickly & " | ")
	If _imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, 300, 300, @DesktopWidth-200, @DesktopHeight, $tx, $ty, 45) = 0 Then
		writelog("Ползунок в самом низу" & @CRLF)
		Return 0
	EndIf
	;$search = _imagesearch("media\zvezda_polzunok_button_vniz.bmp", 1, $tx, $ty, 10)
	If $move_quickly = 1 Then
		MouseMove($tx, $ty, 5 * $tormoza)
		Sleep(300 * $tormoza)
		MouseClick("left", $tx + Random(1, 2, 1) - 2, $ty - 10, 1)
		Sleep(500 * $tormoza)
	Else
		$search = _imagesearcharea("media\zvezda_polzunok_button_vniz.bmp", 1, 200, 200, @DesktopWidth-200, @DesktopHeight, $tx, $ty, 50)
		If $search = 1 Then
			MouseMove($tx, $ty, 10 * $tormoza)
			MouseClick("left", $tx + Random(1, 2, 1) - 2, $ty + Random(1, 2, 1) - 2, 1)
			Sleep(50 * $tormoza)
			MouseMove($tx + 10, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
		EndIf
	EndIf
	writelog("Ползунок сдвинули" & @CRLF)
	Return 1
EndFunc
Func SelectTabAtGeolog($tabname, $donotclickifdisplayed)
writelog("STAG=" & $tabname & " | " & $donotclickifdisplayed & " | ")
Local $ty = 0, $tx = 0, $search = 0
	Switch $tabname
		Case "Камень"
			$zalezi = 9
			ZmemSmennuyuKartinkuIZdem("media\kamen.bmp", 10, "media\kamen_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Медь"
			$zalezi = 6
			ZmemSmennuyuKartinkuIZdem("media\med.bmp", 10, "media\med_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Мрамор"
			$zalezi = 11
			ZmemSmennuyuKartinkuIZdem("media\mramor.bmp", 10, "media\mramor_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Железо"
			$zalezi = 12
			ZmemSmennuyuKartinkuIZdem("media\zelezo.bmp", 10, "media\zelezo_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Уголь"
			$zalezi = 6
			ZmemSmennuyuKartinkuIZdem("media\ugol.bmp", 10, "media\ugol_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Золото"
			$zalezi = 8
			ZmemSmennuyuKartinkuIZdem("media\gold.bmp", 10, "media\gold_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Гранит"
		$zalezi = 7
			ZmemSmennuyuKartinkuIZdem("media\gran.bmp", 10, "media\gran_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Титан"
		$zalezi = 4
			ZmemSmennuyuKartinkuIZdem("media\titan.bmp", 10, "media\titan_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		Case "Селитра"
		$zalezi = 4
			ZmemSmennuyuKartinkuIZdem("media\selitra.bmp", 10, "media\selitra_.bmp", 10, "media\search_button_OK_enabled.bmp", 20)
			ZmemSmennuyuKartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
	EndSwitch
EndFunc

Func openpo4ta()
writelog("Почта ")
	Local $ty = 0, $tx = 0, $tcount = 0, $search = 0
	While (_imagesearch("media\po4ta_is_displayed.bmp", 1, $tx, $ty, 30) <> 1) AND ($tcount < 50)
		Sleep(100 * $tormoza)
		$search = _imagesearch("media\po4ta.bmp", 1, $tx, $ty, 5)
		If $search = 1 Then
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(300 * $tormoza)
			MouseClick("left", $tx + Random(1, 5, 1), $ty + Random(1, 4, 1), 1)
			;Return 1
		EndIf
		sleepwhile("media\po4ta_is_displayed.bmp", 30, 15)
		$tcount = $tcount + 1
	WEnd
	If $tcount < 50 Then
		writelog("Успех " & $tcount & @CRLF)
		Return 1
	EndIf
	writelog("Неудачно " & $tcount & @CRLF)
	Return 0
EndFunc

func ProverkaKlienta()
   local $tx = 0, $ty = 0, $var = 0, $search = 0, $i = 0
   $search = _imagesearch("media\bik.bmp", 1, $tx, $ty, 80)
   $var = PixelGetColor($tx + 50, $ty + 175)
   if $search = 1 then
	   if $var = 16763904 then
		   $Consol_a_ne_Client = 0
		   Return 1
	   elseif $var = 16574876 then
		   $Consol_a_ne_Client = 0
		   Return 1
	   else
		   if registerALL("ALL") = 1 then
			   Return 1
		   endif
		   Return 0
	   endif
   endif
   $search = _imagesearch("media\seliterka.bmp", 1, $tx, $ty, 20)
   $var = PixelGetColor($tx, $ty + 229)

   if $search = 1 then
	   if $var = 16763904 then
		   $Consol_a_ne_Client = 1
		   Return 1
	   elseif $var = 16574876 then
		   $Consol_a_ne_Client = 1
		   Return 1
	   else
		   PodobtatRazmer(72)
		   if registerALL("ALL") = 1 then
			   Return 1
		   endif
		   Return 0
	   endif
   else
	   PodobtatRazmer(72)
	   if registerALL("ALL") = 1 then
		   Return 1
	   endif
	   Return 0
	endif

   PodobtatRazmer(72)
   if registerALL("ALL") = 1 then
	   Return 1
	endif

   Return 0
endfunc

func RoditelskayaKategoriya()
   local $PutKSkriptu = 0, $DelimSleshi = 0, $KolwoSleshey = 0, $PutKRoditelskoyKategorii = "", $i = 1
   $PutKSkriptu = @ScriptFullPath
   $DelimSleshi = StringSplit($PutKSkriptu, "\")
   $KolwoSleshey = UBound($DelimSleshi, 1)
   while $i < $KolwoSleshey - 2
	   $PutKRoditelskoyKategorii = $PutKRoditelskoyKategorii & $DelimSleshi[$i] & "/"
	   $i = $i + 1
   wend
   ;MsgBox(0, "Отлично", $PutKRoditelskoyKategorii)
   Return $PutKRoditelskoyKategorii
endfunc
#EndRegion

func opentitka($yes)
Local $i=0
WinActivate("The Settlers Онлайн")
	MouseMove(@DesktopWidth/2, @DesktopHeight/2, 10 * $tormoza)
	MouseDown("left")
	MouseMove(@DesktopWidth/2+100, @DesktopHeight/2, 10 * $tormoza)
	Sleep(500 * $tormoza)
	MouseUp("left")
	Sleep(500 * $tormoza)
	MouseUp("left")
	Send("{0}")
	Sleep(1000 * $tormoza)
if openzvezda() = 1 then
	if SelectTabAtZvezda("raznoe", 1) <> 0 then
		findclickoncenterandwaitresult("media\monetka.bmp", "media\Otmena.bmp", 30, 50, 5, 5, 0, 30, 30)
		MouseMove(@DesktopWidth/2, @DesktopHeight/2, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", @DesktopWidth/2, @DesktopHeight/2, 1)
		go5()
		Sleep(10000 * $tormoza)
		ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
		$i = 0
		while (findclickoncenterandwaitresult("media\podoz.bmp", "media\KN_Z.bmp", 30, 50, 5, 5, 0, 30, 30) = 0) AND ($i < 10)
			$i = $i + 1
			zvezdamovepolzunokdown(1)
		Wend
		If $i = 10 then
			Return 0
		Endif
		ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
		ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		Sleep(10000 * $tormoza)
		ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
		$i = 0
		while (findclickoncenterandwaitresult("media\podoz+.bmp", "media\KN_Z.bmp", 30, 50, 5, 5, 0, 30, 30) = 0) AND ($i < 10)
			$i = $i + 1
			zvezdamovepolzunokdown(1)
		Wend
		If $i = 10 then
			Return 0
		Endif
		ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
		ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		Sleep(10000 * $tormoza)
		ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
		while (findclickoncenterandwaitresult("media\podoz1.bmp", "media\KN_Z.bmp", 30, 50, 5, 5, 0, 30, 30) = 0) AND ($i < 10)
			$i = $i + 1
			zvezdamovepolzunokdown(1)
		Wend
		If $i = 10 then
			Return 0
		Endif
		ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
		ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		Sleep(10000 * $tormoza)
		ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
		while (findclickoncenterandwaitresult("media\podoz1+.bmp", "media\KN_Z.bmp", 30, 50, 5, 5, 0, 30, 30) = 0) AND ($i < 10)
			$i = $i + 1
			zvezdamovepolzunokdown(1)
		Wend
		If $i = 10 then
			Return 0
		Endif
		ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
		ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		Sleep(10000 * $tormoza)
		ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
		ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		if $yes = 1 then Return openpriklaxxx("tikki_in_zvezda.bmp", "tikki_open.bmp")
		if $yes = 0 then
			Return 1
		else
			Return 0
		endif
	endif
endif
endfunc
func CloseTitka()
   WinActivate("The Settlers Онлайн")
   Sleep(5000 * $tormoza)
   ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
   ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
   ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
   Sleep(10000 * $tormoza)
   ZmemSmennuyuKartinkuIZdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
   ZmemSmennuyuKartinku("media\KN_Z.bmp", 30, "media\KN_Z_.bmp", 30)
   ZmemSmennuyuKartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
   Sleep(5000 * $tormoza)
   Return 1
endfunc

func MyTimer()
   $chasi = GUICtrlRead($chasi_gui)
   $minuti = GUICtrlRead($minuti_gui)
   $sekundi = GUICtrlRead($sekundi_gui)
   $taimer = $sekundi + $minuti * 60 + $chasi * 3600
   Sleep(1000 * $taimer)
endfunc

func Read_ini($stroka)
	$itog = FileReadLine($hfile, $stroka)
	$sResult = StringInStr($itog, "=")
		$sText = StringMid($itog, $sResult + 1)
	Return $sText
endfunc

func sleepwhile($img, $tolerance, $time)
	local $i = 0
	while (haveimage($img, $tolerance) = 0) and ($i < ($time * 2))
		sleep (500 * $tormoza)
		$i = $i + 1
	wend
	if $i < ($time * 2) then
		Return 1
	else
		Return 0
	endif
endfunc
func sleepNOwhile($img, $tolerance, $time)
	local $i = 0
	while (haveimage($img, $tolerance) = 1) and ($i < ($time * 2))
		sleep (500 * $tormoza)
		$i = $i + 1
	wend
	if $i < ($time * 2) then
		Return 1
	else
		Return 0
	endif
endfunc

func writelog($sms)
   Return 1
   FileWrite($sfile2, $sms)
endfunc

func deleteX()
   while 1
	   ZmemSmennuyuKartinku("media\x.bmp", 30, "media\x_.bmp", 30)
   wend
endfunc

Func Register()
if $register = 1 then Return 1
;Убираем IF если нужно в платную версию
	If $register <> 1 Then
		$register = 1
		Return 1
	EndIf
if _INetGetSource("http://mysettlers.ru/registerbot.htm") <> "88005553535" then
	$register = 1
	Return 1
endif
Local $ax=0
Local $ay=0, $temp="", $i=0, $rezult
if Read_ini(7) <> "" then
	Local $User=_Encoding_URLToHex(Read_ini(7))
else
	Local $User=_Encoding_URLToHex(@UserProfileDir)
endif
WinActivate("The Settlers Онлайн")
if _imagesearcharea("media\pismo.bmp", 1, 50, 50, 300, 400, $ax, $ay, 30) = 0 then Return 0
$ax = $ax - 115
$ay = $ay + 3 + Random(0, 5, 1)
	While $i<90
		If PixelGetColor($ax + $i, $ay) = 16777215 then
			$temp = $temp&"1"
		Else
			$temp = $temp&"0"
		EndIf
	$i = $i + 1
	wend
	$rezult = _INetGetSource("http://mysettlers.ru/registerbot.php?key="&$temp&"&user="&$User)
	MsgBox(0, "!!!", $rezult)
	if $rezult == "OK" then
		$register = 1
		Return 1
	elseif $rezult == "NU" then
		setstatistik()
		setstatistik()
		setstatistik()
		setstatistik()
		Return 0
	elseif $rezult == "ERROR" then
		Return 0
	elseif $rezult == "TIME" then
		MsgBox(0, "!!!", "Срок действия бота истёк")
		Return 0
	else
		Return 0
	endif
EndFunc

func setstatistik()
;Убираем строку если хотим собирать статистику
Return 1
Local $ax=0
Local $ay=0, $temp=0
if Read_ini(7) <> "" then
	Local $User=_Encoding_URLToHex(Read_ini(7))
else
	Local $User=_Encoding_URLToHex(@UserProfileDir)
endif
WinActivate("The Settlers Онлайн")
if StringLen($Zapros) = 545 then
	_INetGetSource("http://mysettlers.ru/statistik.php?key="&$Zapros&"&user="&$User)
	$Zapros=""
	Return 1
endif
if StringLen($Zapros) > 545 then
	$Zapros=""
	Return 0
endif
if _imagesearcharea("media\pismo.bmp", 1, 50, 50, 300, 400, $ax, $ay, 30) = 0 then
	Return 0
endif
$ax = $ax - 115
$ay = $ay + 3
	While $Stolbec<90
		If PixelGetColor($ax + $Stolbec, $ay + $Stroka) = 16777215 then
			$temp = 1
		Else
			$temp = 0
		EndIf
		$Zapros=$Zapros&$temp
		$Stolbec = $Stolbec +1
		if $Stolbec = 45 then exitloop
		if $Stolbec = 90 then
			$Stolbec = 0
			$Stroka = $Stroka + 1
			If $Stroka = 6 then
				$Stroka = 0
				$Stolbec = 0
				_INetGetSource("http://mysettlers.ru/statistik.php?key="&$Zapros&"&user="&$User)
				$Zapros=""
				;MsgBox(0, "!!!", "Отправка данных")
				Return 1
			Else
				$Zapros=$Zapros&";"
			EndIf
			exitloop
		endif
	Wend
 endfunc

;Add Jemxx
Func getGeneralData($general)
	Local $generalData[3]

	If ($general = "Интедант" Or $general = "Интендант") Then
		$generalData[0] = "media\avtobus.bmp"
		$generalData[1] = 2000
		$generalData[2] = "media\NOAvtobus.bmp"
	ElseIf $general = "Клаус" Then
		$generalData[0] = "media\klaus.bmp"
		$generalData[1] = 2000
		$generalData[2] = "media\NOklaus.bmp"
	ElseIf $general = "Майор" Then
		$generalData[0] = "media\major.bmp"
		$generalData[1] = 285
		$generalData[2] = "media\NOMajor.bmp"
	ElseIf $general = "Нинзя" Then
		$generalData[0] = "media\ninza.bmp"
		$generalData[1] = 235
		$generalData[2] = "media\NOninza.bmp"
	ElseIf $general = "Ветеран" Then
		$generalData[0] = "media\veteran.bmp"
		$generalData[1] = 265
		$generalData[2] = "media\NOveteran.bmp"
	ElseIf $general = "Дракул" Then
		$generalData[0] = "media\drakula.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOdrakula.bmp"
	ElseIf $general = "Генеральша" Then
		$generalData[0] = "media\miss_klaus.bmp"
		$generalData[1] = 215
		$generalData[2] =  "media\NOmiss_klaus.bmp"
	ElseIf $general = "Защитник" Then
		$generalData[0] = "media\pfobnybr.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\nopfobnybr.bmp"
	ElseIf $general = "Золотой" Then
		$generalData[0] = "media\zolotoy.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOzolotoy.bmp"
	ElseIf $general = "Жнец" Then
		$generalData[0] = "media\znec.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOznec.bmp"
	ElseIf $general = "Простой" Then
		$generalData[0] = "media\General.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOgena.bmp"
	ElseIf $general = "Нусала" Then
		$generalData[0] = "media\nusa.bmp"
		$generalData[1] = 180
		$generalData[2] = "media\NOnusa.bmp"
	ElseIf $general = "Варгус" Then
		$generalData[0] = "media\vargus.bmp"
		$generalData[1] = 195
		$generalData[2] = "media\NOvargus.bmp"
	ElseIf $general = "Анслем" Then
		$generalData[0] = "media\anslem.bmp"
		$generalData[1] = 165
		$generalData[2] = "media\NOanslem.bmp"
	ElseIf $general = "Медик" Then
		$generalData[0] = "media\medik.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOmedik.bmp"
	ElseIf ($general = "Учёный" Or $general = "Ученый") Then
		$generalData[0] = "media\ucheniy.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOucheniy.bmp"
	ElseIf $general = "Борис" Then
		$generalData[0] = "media\boris.bmp"
		$generalData[1] = 195
		$generalData[2] = "media\NOboris.bmp"
	ElseIf $general = "Малец" Then
		$generalData[0] = "media\mladshij.bmp"
		$generalData[1] = 155
		$generalData[2] = "media\NOmladshij.bmp"
	ElseIf $general = "Близнец" Then
		$generalData[0] = "media\starshij.bmp"
		$generalData[1] = 295
		$generalData[2] = "media\NOstarshij.bmp"
	ElseIf $general = "Сильвана" Then
		$generalData[0] = "media\silvana.bmp"
		$generalData[1] = 195
		$generalData[2] = "media\NOsilvana.bmp"
	ElseIf $general = "Стойкая" Then
		$generalData[0] = "media\stoikii.bmp"
		$generalData[1] = 235
		$generalData[2] = "media\NOstoikii.bmp"
	ElseIf $general = "Скрытный" Then
		$generalData[0] = "media\skrytnyj.bmp"
		$generalData[1] = 215
		$generalData[2] = "media\NOskrytnyj.bmp"
	ElseIf $general = "ЗолотойИнтендант" Then
		$generalData[0] = "media\bigavtobus.bmp"
		$generalData[1] = 3000
		$generalData[2] = "media\NObigavtobus.bmp"
	Else
		MsgBox(0, "!!!", "Неправильный параметр типа Генерала")
		Return 0
	EndIf

	Return $generalData
EndFunc

Func getFullGeneralImg($max)
	Local $fullGenaImg = 0

	If FileExists("media\" & $max & ".bmp") Then
		$fullGenaImg = "media\" & $max & ".bmp"
	EndIf

	Return $fullGenaImg
EndFunc

Func alarmBeep()
	Beep(500, 500)
	Beep(1500, 500)
	Beep(2500, 500)
	Beep(500, 500)
	Beep(1500, 500)
	Beep(2500, 500)
	Beep(500, 500)
	Beep(1500, 500)
	Beep(2500, 500)
	Beep(500, 500)
	Beep(1500, 500)
	Beep(2500, 500)
EndFunc

Func getPassagesDir()
	Local $txtDir = @ScriptDir

	If read_ini(11) <> "" Then
		$txtDir = @ScriptDir & "\" & read_ini(11)
	EndIf

	Return $txtDir
EndFunc

Func getAllPassages($passagesDir)
	Local $str, $filelist

	$filelist = _FileListToArray($passagesDir, "*.txt", 1)

	If @error = 0 Then
		For $i = 1 To UBound($filelist) - 1
			$str &= $filelist[$i] & "|"
		Next
		Return $str
	ElseIf @error = 1 Then
		MsgBox(0, "Внимание!!!", "Папка с прохождениями не найдена!")
		Return 0
	ElseIf @error = 4 Then
		MsgBox(0, "Внимание!!!", "Файлы с прохождением не найдены!")
		Return 0
	EndIf
EndFunc