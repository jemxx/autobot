Dim $proverkasliva
Global $sectorGraph =  ReadINI("main", "sector_graphics", "70")

Func podgotovka()
	chatoff()
	drugioff()
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
	zmemsmennuyukartinku("media\Close.bmp", 30, "media\Close_.bmp", 30)
	openmashtab()
	collectwarikiatprikl()
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\Close.bmp", 30)
	zmemsmennuyukartinku("media\Close.bmp", 30, "media\Close_.bmp", 30)
	If openzvezdap() = 1 Then
		If selecttabatzvezda("specialisti", 0) = 1 Then
			zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
			openmashtab()
			Return 1
		EndIf
	EndIf
EndFunc

Func find_sektor($img, $k_x, $k_y, $else_x, $else_y)
	WinActivate($windowTitle)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0, $ax = 0, $ay = 0, $search2 = 0, $ttx = 0, $tty = 0
	$search2 = _imagesearch("media\pismo.bmp", 1, $ax, $ay, 50)
	$k_x = $ax + $k_x
	$k_y = $ay + $k_y
	If _imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1 Then
		writelog("Карта изначально привязана X:" & $tochka_sektora_x & " Y:" & $tochka_sektora_y)
		Return 1
	EndIf
	While (_imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) <> 1) AND ($i < 10)
		go5()
		$search = _imagesearch($img, 1, $tx, $ty, $sectorGraph)
		If $search = 1 Then
			If $ttx = $tx Then
				If $tty = $ty Then
					If $else_y < 0 Then
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
					EndIf
					If $else_y > 0 Then
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
					EndIf
					If $else_x < 0 Then
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
					EndIf
					If $else_x > 0 Then
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
					EndIf
				EndIf
			EndIf
			If $tty = $ty Then
				If $ttx = $tx Then
					If $else_y < 0 Then
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
						Send("{DOWN}")
					EndIf
					If $else_y > 0 Then
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
						Send("{UP}")
					EndIf
					If $else_x < 0 Then
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
						Send("{RIGHT}")
					EndIf
					If $else_x > 0 Then
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
						Send("{LEFT}")
					EndIf
				EndIf
			EndIf
			$ttx = $tx
			$tty = $ty
			MouseMove($tx, $ty, 10 * $tormoza)
			MouseDown("left")
			MouseMove($k_x, $k_y, 30 * $tormoza)
			Sleep(500 * $tormoza)
			MouseUp("left")
			MouseUp("left")
			removemouse(1000, -10, 500)
			$search = _imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph)
			writelog("Переместили карту X:" & $tochka_sektora_x & " Y:" & $tochka_sektora_y)
			If _imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1 Then
				Return 1
			EndIf
			If _imagesearcharea($img, 1, $k_x - 50, $k_y - 50, $k_x + 50, $k_y + 50, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph + 30) = 1 Then
				Return 1
			EndIf
		Else
			If $else_y < 0 Then
				Send("{DOWN}")
				Send("{DOWN}")
			EndIf
			If $else_y > 0 Then
				Send("{UP}")
				Send("{UP}")
			EndIf
			If $else_x < 0 Then
				Send("{RIGHT}")
				Send("{RIGHT}")
			EndIf
			If $else_x > 0 Then
				Send("{LEFT}")
				Send("{LEFT}")
			EndIf
			MouseMove(@DesktopWidth / 2, @DesktopHeight / 2, 10 * $tormoza)
			MouseDown("left")
			MouseMove(@DesktopWidth / 2 + $else_x, @DesktopHeight / 2 + $else_y, 10 * $tormoza)
			Sleep(500 * $tormoza)
			MouseUp("left")
			Sleep(500 * $tormoza)
			MouseUp("left")
			removemouse(1000, -10, 500)
			writelog("Двигаем карту на X:" & $else_x & " Y:" & $else_y)
		EndIf
		$i = $i + 1
	WEnd
	If $i < 9 Then Return 1
	writelog("Ошибка функции Find_Sektor " & $img & ", " & $k_x & ", " & $k_y & ", " & $else_x & ", " & $else_y)
	Return 0
EndFunc

#comments-start
Func perestanovka_geni_iz_zvezdi($general, $nomergenerala, $voisko, $tip_voiska, $img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		writelog($gluksnaboromarmii)
		If openzvezdap() = 1 Then
			While _imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				Sleep(1000 * $tormoza)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			WEnd
			If $voisko = 0 Then
				If $tip_voiska = 0 Then
					smena_armii(0)
					applyarmy(0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0)
				ElseIf $tip_voiska = 1 Then
					smena_armii(1)
					apply_elitnoy_army(0, 0, 0, 0, 0, 0, 0, 4, 0)
				EndIf
			ElseIf $voisko = 1 Then
				If $tip_voiska = 0 Then
					smena_armii(0)
					applyarmy(1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0)
				ElseIf $tip_voiska = 1 Then
					smena_armii(1)
					apply_elitnoy_army(0, 0, 0, 0, 0, 1, 0, 4, 0)
				EndIf
			ElseIf $voisko = 2 Then
				$gluksnaboromarmii = 1
			EndIf
		EndIf
	WEnd
	$gluksnaboromarmii = 0
	zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 1 Then
		$kudax = $tochka_sektora_x + read_ini($kudax)
		$kuday = $tochka_sektora_y + read_ini($kuday)
		While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
			MouseMove($kudax, $kuday, 10 * $tormoza)
			Sleep(200 * $tormoza)
			MouseClick("left", $kudax, $kuday, 1)
			go5()
			Sleep(200 * $tormoza)
			$i = $i + 1
		WEnd
		If $i = 10 Then
			Return 0
		Else
			Return 1
		EndIf
	EndIf
	Return 0
EndFunc

Func movegenapxp($otkudax, $otkuday, $img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday, $img2, $k_x2, $k_y2, $else_x2, $else_y2)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 1 Then
		$otkudax = $tochka_sektora_x + read_ini($otkudax)
		$otkuday = $tochka_sektora_y + read_ini($otkuday)
		While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0) AND ($i < 10)
			MouseMove($otkudax, $otkuday, 10 * $tormoza)
			Sleep(500 * $tormoza)
			MouseClick("left", $otkudax, $otkuday, 1)
			go5()
			sleepwhile("media\zadacha_geni.bmp", 30, 10)
			$i = $i + 1
		WEnd
		If $i = 10 Then
			Return 0
		EndIf
		zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
		$i = 0
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 1 Then
			$kudax = $tochka_sektora_x + read_ini($kudax)
			$kuday = $tochka_sektora_y + read_ini($kuday)
			sleepwhile("media\Otmena.bmp", 30, 10)
			While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
				MouseMove($kudax, $kuday, 10 * $tormoza)
				Sleep(500 * $tormoza)
				MouseClick("left", $kudax, $kuday, 1)
				go5()
				Sleep(500 * $tormoza)
				$i = $i + 1
			WEnd
			If $i = 10 Then
				Return 0
			Else
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func atakgenapxp($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	$otkudax = $tochka_sektora_x + read_ini($otkudax)
	$otkuday = $tochka_sektora_y + read_ini($otkuday)
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 6)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		sleepwhile("media\zadacha_geni.bmp", 30, 5)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	EndIf
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	$kudax = $tochka_sektora_x + read_ini($kudax)
	$kuday = $tochka_sektora_y + read_ini($kuday)
	sleepwhile("media\Otmena.bmp", 30, 10)
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		Sleep(500 * $tormoza)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	Else
		Return 1
	EndIf
	Return 0
EndFunc

Func atakalageraotkritimgenoy($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	$kudax = $tochka_sektora_x + read_ini($kudax)
	$kuday = $tochka_sektora_y + read_ini($kuday)
	sleepwhile("media\Otmena.bmp", 30, 10)
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		go5()
		Sleep(500 * $tormoza)
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func atakagenoyizzvezdi_elita($general, $nomergenerala, $mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena, $kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		If openzvezdap() = 1 Then
			While _imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			WEnd
			If apply_elitnoy_army($mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena, 0) = 1 Then
				$gluksnaboromarmii = 0
				Return atakalageraotkritimgenoy($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
			Else
				Return 0
			EndIf
		EndIf
	WEnd
	$gluksnaboromarmii = 0
EndFunc

Func atakagenoyizzvezdi($general, $nomergenerala, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, $kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		If openzvezdap() = 1 Then
			While _imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			WEnd
			If applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 0) = 1 Then
				$gluksnaboromarmii = 0
				Return atakalageraotkritimgenoy($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
			Else
				Return 0
			EndIf
		EndIf
	WEnd
	$gluksnaboromarmii = 0
EndFunc

Func atakagenoyizzvezdi_1n($general, $nomergenerala, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, $kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		If openzvezdap() = 1 Then
			While _imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			WEnd
			If haveimage("media\army_values\1.bmp", 20) = 1 Then
				$gluksnaboromarmii = 0
				Return atakalageraotkritimgenoy($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
			ElseIf applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 0) = 1 Then
				$gluksnaboromarmii = 0
				Return atakalageraotkritimgenoy($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
			Else
				Return 0
			EndIf
		EndIf
	WEnd
	$gluksnaboromarmii = 0
EndFunc

Func viborgenipodataku_elita($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	go5()
	$otkudax = $tochka_sektora_x + read_ini($otkudax)
	$otkuday = $tochka_sektora_y + read_ini($otkuday)
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return apply_elitnoy_army($mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena, 1)
	EndIf
	Return 0
EndFunc

Func viborgenipodataku($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	go5()
	$otkudax = $tochka_sektora_x + read_ini($otkudax)
	$otkuday = $tochka_sektora_y + read_ini($otkuday)
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 1)
	EndIf
	Return 0
EndFunc

Func viborgenipodataku_1n($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	go5()
	$otkudax = $tochka_sektora_x + read_ini($otkudax)
	$otkuday = $tochka_sektora_y + read_ini($otkuday)
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	ElseIf haveimage("media\army_values\1.bmp", 20) = 1 Then
		zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
		Return 1
	Else
		Return applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 1)
	EndIf
	Return 0
EndFunc

Func estligena($img)
	If openzvezdap() = 1 Then
		If haveimage($img, 30) = 1 Then
			Return 1
		Else
			Return 0
		EndIf
	EndIf
	Return 0
EndFunc

Func proverka_1n($img, $yes)
	If $yes = 1 Then
		If haveimage($img, 20) = 1 Then
			Return 1
		Else
			Return 0
		EndIf
	EndIf
	Return 0
EndFunc
#comments-end

Func atakalageraotkritimgenoynoini($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	sleepwhile("media\Otmena.bmp", 30, 10)
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(700 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		Sleep(300 * $tormoza)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func perenosotkritimgenoynoini($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	sleepwhile("media\Otmena.bmp", 30, 10)
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(700 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		Sleep(300 * $tormoza)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func atakgenapxpnoini($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
			Else
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 6)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		sleepwhile("media\zadacha_geni.bmp", 30, 5)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	EndIf
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	sleepwhile("media\Otmena.bmp", 30, 10)
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(700 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		Sleep(300 * $tormoza)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	Else
		Return 1
	EndIf
	Return 0
EndFunc

Func perestanovka_geni_iz_zvezdinoini($general, $nomergenerala, $voisko, $tip_voiska, $img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		writelog($gluksnaboromarmii)
		If openzvezdap() = 1 Then
			If selecttabatzvezda("specialisti", 1) = 0 Then Return 0
			While _imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				Sleep(1000 * $tormoza)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			WEnd
			If $voisko = 0 Then
				If $tip_voiska = 0 Then
					smena_armii(0)
					applyarmy(0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0)
				ElseIf $tip_voiska = 1 Then
					smena_armii(1)
					apply_elitnoy_army(0, 0, 0, 0, 0, 0, 0, 4, 0)
				EndIf
			ElseIf $voisko = 1 Then
				If $tip_voiska = 0 Then
					smena_armii(0)
					applyarmy(1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0)
				ElseIf $tip_voiska = 1 Then
					smena_armii(1)
					apply_elitnoy_army(0, 0, 0, 0, 0, 1, 0, 4, 0)
				EndIf
			ElseIf $voisko = 2 Then
				$gluksnaboromarmii = 1
			EndIf
		EndIf
	WEnd
	$gluksnaboromarmii = 0
	zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
	sleepwhile("media\Otmena.bmp", 30, 10)
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		go5()
		Sleep(200 * $tormoza)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return 1
	EndIf
	Return 0
EndFunc

Func viborgenipodatakunoini($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	go5()
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 1)
	EndIf
	Return 0
EndFunc

Func viborgenipodataku_elitanoini($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	go5()
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return apply_elitnoy_army($mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena, 1)
	EndIf
	Return 0
EndFunc

Func viborgenipodataku_1nnoini($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	go5()
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	ElseIf haveimage("media\army_values\1.bmp", 20) = 1 Then
		zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
		Return 1
	Else
		Return applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 1)
	EndIf
	Return 0
EndFunc

Func open_usilok($tb_name, $img_usilka, $currentbuf)
	Local $i = 0
	If $currentbuf = 1 Then
		If haveimage("media\Otmena.bmp", 50) = 1 Then Return 1
	EndIf
	If openzvezdap() = 1 Then
		If selecttabatzvezda($tb_name, 1) = 1 Then
			While (haveimage($img_usilka, 50) = 0) AND ($i < 5)
				zvezdamovepolzunokdown(0)
				Sleep(Random(500, 1000, 1) * $tormoza)
				$i = $i + 1
			WEnd
			Return findclickoncenterandwaitresult($img_usilka, "media\Otmena.bmp", 30, 80, 5, 5, 0, 30, 30)
		EndIf
	EndIf
	Return 0
EndFunc

Func plunusilok_koordinati($tb_name, $img_usilka, $kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y, $currentbuf)
	If open_usilok($tb_name, $img_usilka, $currentbuf) = 0 Then Return 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	MouseMove($kudax, $kuday, 10 * $tormoza)
	Sleep(500 * $tormoza)
	MouseClick("left", $kudax, $kuday, 1)
	Sleep(500 * $tormoza)
	go5()
	If $tb_name = "usiliteli" Then
		If $currentbuf = 0 Then zmemsmennuyukartinku("media\Otmena.bmp", 30, "media\Otmena_.bmp", 30)
		Return 1
	ElseIf $tb_name = "raznoe" Then
		zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook.bmp", 30)
		zmemsmennuyukartinku("media\Otmena.bmp", 30, "media\Otmena_.bmp", 30)
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func proverkasliva()
	Local $i = 0, $tx, $ty, $ax, $ay
	If _imagesearch("media\pismo.bmp", 1, $ax, $ay, 50) = 0 Then Return 0
	$proverkasliva = NOT $proverkasliva
	TrayTip("", "Проверка слива запущена", 0)
	While $proverkasliva
		If (_imagesearcharea("media\friend_atak.bmp", 1, $ax, 0, $ax + 300, $ay + 700, $tx, $ty, 30) = 1) or (_imagesearcharea("media\razgromili.bmp", 1, $ax, 0, $ax + 300, $ay + 700, $tx, $ty, 30) = 1) Then
			TrayTip("", "Друг сливается...", 0)
			Sleep(12000 * $tormoza)
			$proverkasliva = NOT $proverkasliva
		EndIf
		$i = $i + 2
		Sleep(2000 * $tormoza)
		If $i > 6000 Then
			MsgBox(0, "Внимание!!!", "Мы не смогли обнаружить слив и вышли по таймеру." & @CR & @CR & "После нажатия кнопки ОК бот продолжит работу.")
			$proverkasliva = NOT $proverkasliva
		EndIf
	WEnd
	TrayTip("", "Проверка слива завершена", 0)
EndFunc

Func proverkasliva2($time, $okclose)
	Local $i = 0
	While (ProcessExists("proverkasliva.exe") <> 0) AND ($i < $time)
		$i = $i + 2
		Sleep(2000 * $tormoza)
	WEnd
	If $okclose = 1 Then
		ProcessClose("proverkasliva.exe")
		Return 1
	ElseIf $okclose = 0 Then
		If $i < $time Then
			ProcessClose("proverkasliva.exe")
			Return 1
		Else
			ProcessClose("proverkasliva.exe")
			Return 0
		EndIf
	Else
		Return 0
	EndIf
EndFunc

Func movegenapxpnoini($otkudax, $otkuday, $img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday, $img2, $k_x2, $k_y2, $else_x2, $else_y2)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	EndIf
	zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	sleepwhile("media\Otmena.bmp", 30, 10)
	While (_imagesearch("media\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
		MouseMove($kudax, $kuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $kudax, $kuday, 1)
		go5()
		Sleep(500 * $tormoza)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	Else
		Return 1
	EndIf
	Return 0
EndFunc

Func otpravitgenu($general, $nomergenerala)
	openzvezdap()
	While haveimage("media\zadacha_geni.bmp", 30) = 0
		If openzvezdap() = 1 Then
			If selecttabatzvezda("specialisti", 1) = 1 Then
				generali($general, $nomergenerala)
				Sleep(500 * $tormoza)
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
			EndIf
		EndIf
	WEnd
	zmemsmennuyukartinku("media\gohome.bmp", 30, "media\gohome_.bmp", 30)
	sleepwhile("media\nubook.bmp", 30, 10)
	zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook_.bmp", 30)
	Return 1
EndFunc

Func openpriglosdruga($prikl, $imya)
	While 1
		If findclickoncenterandwaitresult($userDIR & $prikl, "media\priglos.bmp", 30, 30, 5, 10, 1, -300, -300) = 1 Then
			If findclickoncenterandwaitresult("media\priglos.bmp", "media\igroki_in_prikla.bmp", 30, 30, 10, 10, 1, -300, -300) = 1 Then
				If findclickoncenterandwaitresult("media\plus_igrok.bmp", "media\okdrug_off.bmp", 30, 30, 10, 10, 1, -300, -300) = 1 Then
					Return 1
				Else
					Return 0
				EndIf
			Else
				Return 0
			EndIf
		Else
			Return 0
		EndIf
	WEnd
EndFunc

Func priglosdruga($prikl, $imya)
EndFunc

Func stoitligena($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday, $fl_active)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf
	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday
	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 20)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		if $fl_active = 1 Then
			sleepwhile("media\ataka.bmp", 30, 10)
		Else
			sleepwhile("media\zadacha_geni.bmp", 30, 10)
		EndIf
		go5()
		$i = $i + 1
	WEnd
	If $i < 20 Then
		If $fl_active = 0 Then zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
		Return 1
	EndIf
	Return 0
EndFunc

Global $strelkax = 0, $strelkay = 0, $maxx = 0, $maxy = 0, $minx = 0, $miny = 0, $diffarmy = 0
Global $gluksnaboromarmii = 0, $polezifrx = 0, $polezifry = 0, $skolkokartinka = 0, $skoko_voln_puskaem = 0
Global $general_1_x, $general_1_y, $general_2_x, $general_2_y, $general_1_temp_x, $general_1_temp_y
Global $gluksnaboromarmii = 0, $1sektorx, $1sektory, $skoko_voln_puskaem = 2
Global $search_treasure_menu_x, $search_treasure_menu_y
Global $area0_top_x, $area0_top_y, $area0_bottom_x, $area0_bottom_y
Global $area1_top_x, $area1_top_y, $area1_bottom_x, $area1_bottom_y
Global $area2_top_x, $area2_top_y, $area2_bottom_x, $area2_bottom_y
Global $area3_top_x, $area3_top_y, $area3_bottom_x, $area3_bottom_y
Global $area4_top_x, $area4_top_y, $area4_bottom_x, $area4_bottom_y
Global $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y

Func naborgenarea()
	Local $tx = 0, $ty = 0
	If IsDeclared("Zifri_area") Then
		If _imagesearcharea("media\search_treasure_menu.bmp", 1, $search_treasure_menu_x - 20, $search_treasure_menu_y - 20, $search_treasure_menu_x + 20, $search_treasure_menu_y + 20, $tx, $ty, 20) = 1 Then Return 1
	EndIf
	If _imagesearch("media\search_treasure_menu.bmp", 1, $search_treasure_menu_x, $search_treasure_menu_y, 20) = 1 Then
		Global $zifri_area[4] = [$search_treasure_menu_x - 20, $search_treasure_menu_y + 70, $search_treasure_menu_x + 50, $search_treasure_menu_y + 110]
		Return 1
	EndIf
	Return 0
EndFunc

Func applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, $yes)
	writelog("=====AA " & $nubi & "," & $menti & "," & $soldati & "," & $elita & "," & $luki & "," & $dluki & "," & $arbi & "," & $koni & "," & $puhi & "," & $gena & "," & $yes & @CRLF)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	If smena_armii(0) = 0 Then Return 0
	$search = _imagesearch("media\0.bmp", 1, $tx, $ty, 20)
	If $nubi = 0 AND $menti = 0 AND $soldati = 0 AND $elita = 0 AND $luki = 0 AND $dluki = 0 AND $arbi = 0 AND $koni = 0 AND $puhi = 0 AND $search = 1 Then
		If $yes = 0 Then
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			Return 1
		EndIf
		$gluksnaboromarmii = $gluksnaboromarmii + 1
		zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
		Return 1
	EndIf
	zmemsmennuyukartinku("media\sbros.bmp", 50, "media\sbros_.bmp", 50)
	$diffarmy = $puhi
	If setarmy("puhi", $puhi, $gena) = 1 Then
		$diffarmy = $diffarmy + $arbi
		If setarmy("arbi", $arbi, $gena) = 1 Then
			$diffarmy = $diffarmy + $elita
			If setarmy("elita", $elita, $gena) = 1 Then
				$diffarmy = $diffarmy + $soldati
				If setarmy("soldati", $soldati, $gena) = 1 Then
					$diffarmy = $diffarmy + $koni
					If setarmy("koni", $koni, $gena) = 1 Then
						$diffarmy = $diffarmy + $dluki
						If setarmy("dluki", $dluki, $gena) = 1 Then
							$diffarmy = $diffarmy + $luki
							If setarmy("luki", $luki, $gena) = 1 Then
								$diffarmy = $diffarmy + $menti
								If setarmy("menti", $menti, $gena) = 1 Then
									$diffarmy = $diffarmy + $nubi
									If setarmy("nubi", $nubi, $gena) = 1 Then
										If okclosegena($yes) = 1 Then
											writelog("=====Успех" & @CRLF)
											Return 1
										EndIf
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	writelog("=====ОШИБКА" & @CRLF)
	Return 0
EndFunc

Func setarmy($kogo, $skolko, $gena)
	Local $ty = 0, $tx = 0, $search = 0, $fullGenaImg = 0, $i = 0
	;writelog("| SA " & $kogo & "," & $skolko & "," & $gena & " | ")
	If $skolko = 0 Then
		;writelog("0" & @CRLF)
		Return 1
	EndIf
	$fullGenaImg = getFullGeneralImg($gena)
	If $skolko = 3000 Then ; добиваем до максимума
		viborarmii($kogo)
		$i = 0
		$search = 0
		While ($i < 10) AND ($search = 0)
			MouseMove($maxx, $maxy, 10 * $tormoza)
			MouseClick("left", $maxx, $maxy, 2)
			$search = _imagesearch($fullGenaImg, 1, $tx, $ty, 30)
			Sleep(500 * $tormoza)
			$i = $i + 1
		WEnd
		If $i < 9 Then
			Return 1
		Else
			TrayTip("", "Ошибка: Не набрали войска", 0)
			Return 0
		EndIf
	Else ; ввод обычных значений
		viborarmii($kogo)
		$skolkokartinka = "media\army_values\" & $diffarmy & ".bmp"
		$i = 0
		While vvodzifr($skolko) <> 1
			;writelog("+" & $skolko)
			MouseMove($minx, $miny, 10 * $tormoza)
			MouseClick("left", $minx, $miny, 2)
			$i = $i + 1
			if vvodzifr($skolko) = 2 Then Return 2
            if $i > 5 Then Return 0
		WEnd
		Return 1
	EndIf
	;writelog("Ошибка " & @CRLF)
;	Return 0
EndFunc

Func vvodzifr($skolko)
	If naborgenarea() = 0 Then Return 0
	If $skolko = "" Then
		MsgBox(0, "ОШИБКА", "Количество армии пустое")
		Return 0
	EndIf
	Local $i = 0, $error = 0, $symbol
	While $i < StringLen($skolko)
		$symbol = StringMid($skolko, $i + 1, 1)
		If StringInStr("0123456789", $symbol) <> 0 Then
			$error = $error + 1
		EndIf
		$i = $i + 1
	WEnd
	If $error <> StringLen($skolko) Then
		MsgBox(0, "ОШИБКА", "Недопустимые символы в количестве войск")
		Return 0
	EndIf
	$i = 0
	While ($i < 5)
		MouseMove($polezifrx, $polezifry, 10 * $tormoza)
		MouseClick("left", $polezifrx, $polezifry, 2)
		Sleep(300 * $tormoza)
		Send($skolko)
		Sleep(1000 * $tormoza)
		If haveimagearea($skolkokartinka, 20, $zifri_area[0], $zifri_area[1], $zifri_area[2], $zifri_area[3]) = 1 Then
			Return 1
		EndIf
		$i = $i + 1
	WEnd
;	TrayTip("", "Недостаточно юнитов для набора", 0)
	Return 2
EndFunc

Func okclosegena($yes)
	writelog("==OKG | ")
	Local $ty = 0, $tx = 0, $search = 0, $i = 0
	$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
	If $search = 0 Then
		writelog(" Генерал закрыт ")
		Return 1
	Else
		$i = 0
		$search = 0
		zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		While ($i < 6) AND ($search = 0)
			Sleep(1000 * $tormoza)
			$i = $i + 1
			sleepwhile("media\nub_gena.bmp", 20, 10)
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
		WEnd
		If $i < 6 Then
			If $yes = 0 Then
				$gluksnaboromarmii = $gluksnaboromarmii + 1
				Return 1
			EndIf
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			If $yes = 1 Then
				zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
			EndIf
			If $yes = 2 Then
				zmemsmennuyukartinku("media\gohome.bmp", 30, "media\gohome_.bmp", 30)
				zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook_.bmp", 30)
			EndIf
			writelog(" Успешно ")
			Return 1
		Else
			zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
			TrayTip("", "Ошибка: Не назначили войска", 0)
			writelog(" ОШИБКА ")
			Return 0
		EndIf
	EndIf
	writelog(" ОШИБКА !0! ")
	Return 0
EndFunc

Func viborarmii($tabname)
	writelog("| VA " & $tabname)
	Local $ty = 0, $tx = 0, $search = 0, $ay = 0, $ax = 0
	Switch $tabname
		Case "nubi"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 24
				$maxx = $tx + 84
				$maxy = $ty + 24
				$minx = $tx + 6
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "menti"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 24
				$maxx = $tx + 333
				$maxy = $ty + 24
				$minx = $tx + 257
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "luki"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 24
				$maxx = $tx + 208
				$maxy = $ty + 24
				$minx = $tx + 130
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "dluki"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 78
				$maxx = $tx + 208
				$maxy = $ty + 78
				$minx = $tx + 130
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "koni"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 78
				$maxx = $tx + 84
				$maxy = $ty + 78
				$minx = $tx + 6
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "soldati"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 78
				$maxx = $tx + 333
				$maxy = $ty + 78
				$minx = $tx + 257
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "elita"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 132
				$maxx = $tx + 208
				$maxy = $ty + 132
				$minx = $tx + 130
				$miny = $ty + 132
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "arbi"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 132
				$maxx = $tx + 84
				$maxy = $ty + 132
				$minx = $tx + 6
				$miny = $ty + 132
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "puhi"
			$search = _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 132
				$maxx = $tx + 333
				$maxy = $ty + 132
				$minx = $tx + 257
				$miny = $ty + 132
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
	EndSwitch
	Return 0
EndFunc

Func generalixxx($general, $nomergenerala)
	writelog(" ГЕНЕРАЛЫ ")
	Local $ty = 0, $tx = 0, $search = 0
	Local $general1x = 0, $general1y = 0, $general2x = 0, $general2y = 0, $general3x = 0, $general3y = 0, $general4x = 0, $general4y = 0
	$search = _imagesearch($general, 1, $tx, $ty, 20)
	If $search = 1 Then
		$general1x = $tx
		$general1y = $ty
		If $nomergenerala = 1 Then
			MouseMove($general1x, $general1y, 10 * $tormoza)
			Sleep(100 * $tormoza)
			MouseClick("left", $general1x + Random(1, 2, 1) - 2, $general1y + Random(1, 2, 1) - 2, 1)
			go5()
			sleepwhile("media\zadacha_geni.bmp", 30, 20)
			Return 1
		EndIf
		If _imagesearcharea($general, 1, $general1x, $general1y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general2x = $tx
			$general2y = $ty
			If $nomergenerala = 2 Then
				MouseMove($general2x, $general2y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general2x + Random(1, 2, 1) - 2, $general2y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		ElseIf _imagesearcharea($general, 1, 0, $general1y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general2x = $tx
			$general2y = $ty
			If $nomergenerala = 2 Then
				MouseMove($general2x, $general2y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general2x + Random(1, 2, 1) - 2, $general2y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		EndIf
		If _imagesearcharea($general, 1, $general2x, $general2y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general3x = $tx
			$general3y = $ty
			If $nomergenerala = 3 Then
				MouseMove($general3x, $general3y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general3x + Random(1, 2, 1) - 2, $general3y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		ElseIf _imagesearcharea($general, 1, 0, $general2y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general3x = $tx
			$general3y = $ty
			If $nomergenerala = 3 Then
				MouseMove($general3x, $general3y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general3x + Random(1, 2, 1) - 2, $general3y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		EndIf
		If _imagesearcharea($general, 1, $general3x, $general3y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general4x = $tx
			$general4y = $ty
			If $nomergenerala = 4 Then
				MouseMove($general4x, $general4y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general4x + Random(1, 2, 1) - 2, $general4y + Random(1, 2, 1) - 2, 2)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		ElseIf _imagesearcharea($general, 1, 0, $general3y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general4x = $tx
			$general4y = $ty
			If $nomergenerala = 4 Then
				MouseMove($general4x, $general4y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general4x + Random(1, 2, 1) - 2, $general4y + Random(1, 2, 1) - 2, 2)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func generali($general, $nomergenerala)
	Sleep(500 * $tormoza)
	Local $ty = 0, $tx = 0, $search = 0, $i = 0, $t = 0, $ii = 0, $count_list = 1, $count_line = 1, $count_gen_in_line = 9
	Local $general1x = 0, $general1y = 0, $general2x = 0, $general2y = 0
	$count_list = int(ReadINI("main", "total_generals", "50")/($count_line * $count_gen_in_line)) - 4
	;Если на открывщемся экране нет гены, то нажимаем вкладку "специалисты", и если снова гены нет, то листаем по 1 строке
	;Листаем пока не найдём гену или до последнего экрана с генералами пока есть ползунок. Если не нашли гену, выходим с ошибкой.
	;Если нашли гену на экране в 4 строки, то поднимаем первую картинку гены во вторую строку сверху.
	While 1
		If (haveimageAREA($general, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 0) Then
			selecttabatzvezda("specialisti", 0)
			while (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0 AND ($ii < $count_list)
				If (haveimageAREA($general, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 165) = 1) Then
					ExitLoop
				Else
					zvezdamovepolzunokdown(0)
					$ii = $ii + 1
				EndIf
			Wend
			If $ii >= $count_list Then 
				;TrayTip("ОШИБКА", "Не нашли ни одного из выбранных ген!", 5)
				Return 0
			EndIf
		ElseIf _imagesearcharea($general, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then
			ExitLoop
		EndIf
	WEnd

	If $nomergenerala = 1 Then
		While $i < 10
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(500 * $tormoza)
			MouseClick("left", $tx + Random(1, 2, 1) - 2, $ty + Random(1, 2, 1) - 2, 1)
			go5()
			sleepwhile("media\zadacha_geni.bmp", 30, 10)
			If haveimage("media\zadacha_geni.bmp", 30) = 1 Then Return 1
			$i = $i + 1
		WEnd
		Return 0
	EndIf

	If $nomergenerala = -1 Then
		$i = 0
		While $i < 100
			If _imagesearcharea($general, 1, $tx, $ty - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general2x = $tx
				$general2y = $ty
			ElseIf _imagesearcharea($general, 1, 0, $ty, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general2x = $tx
				$general2y = $ty
			Else
				While $t < 10
					MouseMove($tx, $ty, 10 * $tormoza)
					Sleep(500 * $tormoza)
					MouseClick("left", $tx + Random(1, 2, 1) - 2, $ty + Random(1, 2, 1) - 2, 1)
					go5()
					sleepwhile("media\zadacha_geni.bmp", 30, 10)
					If haveimage("media\zadacha_geni.bmp", 30) = 1 Then Return 1
					$t = $t + 1
				WEnd
			EndIf
			$tx = $general2x
			$ty = $general2y
			$i = $i + 1
		WEnd
		Return 0
	EndIf

	$i = 1
	While $i < $nomergenerala
		$i = $i + 1
		If _imagesearcharea($general, 1, $tx, $ty - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general2x = $tx
			$general2y = $ty
			If $i = $nomergenerala Then
				MouseMove($general2x, $general2y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general2x + Random(1, 2, 1) - 2, $general2y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
				If haveimage("media\zadacha_geni.bmp", 30) = 1 Then Return 1
			EndIf
		ElseIf _imagesearcharea($general, 1, 0, $ty, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general2x = $tx
			$general2y = $ty
			If $i = $nomergenerala Then
				MouseMove($general2x, $general2y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general2x + Random(1, 2, 1) - 2, $general2y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\zadacha_geni.bmp", 30, 10)
				If haveimage("media\zadacha_geni.bmp", 30) = 1 Then Return 1
			EndIf
		Else
			Return 0
		EndIf
		$tx = $general2x
		$ty = $general2y
	WEnd
	Return 0
EndFunc

Func generaliproverka($general, $nomergenerala)
	writelog(" ГЕНЕРАЛЫ ПРОВЕРКА ")
	Local $ty = 0, $tx = 0, $search = 0, $i = 0, $skoka_gen_nashli = 0
	Local $general1x = 0, $general1y = 0, $general2x = 0, $general2y = 0, $general3x = 0, $general3y = 0, $general4x = 0, $general4y = 0, $general5x = 0, $general5y = 0, $general6x = 0, $general6y = 0
	While $i < 4
		$search = _imagesearch($general, 1, $tx, $ty, 20)
		If $search = 1 Then
			$general1x = $tx
			$general1y = $ty
			$skoka_gen_nashli = 1
			If $nomergenerala = 1 Then
				Return 1
			EndIf
			If _imagesearcharea($general, 1, $general1x, $general1y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general2x = $tx
				$general2y = $ty
				$skoka_gen_nashli = 2
				If $nomergenerala = 2 Then
					Return 1
				EndIf
			ElseIf _imagesearcharea($general, 1, 0, $general1y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general2x = $tx
				$general2y = $ty
				$skoka_gen_nashli = 2
				If $nomergenerala = 2 Then
					Return 1
				EndIf
			EndIf
			If _imagesearcharea($general, 1, $general2x, $general2y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general3x = $tx
				$general3y = $ty
				$skoka_gen_nashli = 3
				If $nomergenerala = 3 Then
					Return 1
				EndIf
			ElseIf _imagesearcharea($general, 1, 0, $general2y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general3x = $tx
				$general3y = $ty
				$skoka_gen_nashli = 3
				If $nomergenerala = 3 Then
					Return 1
				EndIf
			EndIf
			If _imagesearcharea($general, 1, $general3x, $general3y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general4x = $tx
				$general4y = $ty
				$skoka_gen_nashli = 4
				If $nomergenerala = 4 Then
					Return 1
				EndIf
			ElseIf _imagesearcharea($general, 1, 0, $general3y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general4x = $tx
				$general4y = $ty
				$skoka_gen_nashli = 4
				If $nomergenerala = 4 Then
					Return 1
				EndIf
			EndIf
			If _imagesearcharea($general, 1, $general4x, $general4y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general5x = $tx
				$general5y = $ty
				$skoka_gen_nashli = 5
				If $nomergenerala = 5 Then
					Return 1
				EndIf
			ElseIf _imagesearcharea($general, 1, 0, $general4y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general5x = $tx
				$general5y = $ty
				$skoka_gen_nashli = 5
				If $nomergenerala = 5 Then
					Return 1
				EndIf
			EndIf
			If _imagesearcharea($general, 1, $general5x, $general5y - 50, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general6x = $tx
				$general6y = $ty
				$skoka_gen_nashli = 6
				If $nomergenerala = 6 Then
					Return 1
				EndIf
			ElseIf _imagesearcharea($general, 1, 0, $general5y, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
				$general6x = $tx
				$general6y = $ty
				$skoka_gen_nashli = 6
				If $nomergenerala = 6 Then
					Return 1
				EndIf
			EndIf
		EndIf
		$i = $i + 1
		$nomergenerala = $nomergenerala - $skoka_gen_nashli
		zvezdamovepolzunokdown(1)
		Sleep(1000 * $tormoza)
	WEnd
	Return 0
EndFunc

Func openprikla($kartinka, $kartinka2)
	Local $tx = 0, $ty = 0
	If haveimage($kartinka2, 30) = 1 Then
		Return 1
	EndIf
	If openzvezda() = 1 Then
		If selecttabatzvezda("prikli", 0) = 1 Then
			While (_imagesearch($kartinka, 1, $tx, $ty, 20) = 0)
				zvezdamovepolzunokdown(1)
				Sleep(300 * $tormoza)
			WEnd
			If findclickoncenterandwaitresult($kartinka, "media\open_prikla2.bmp", 20, 20, 5, 5, 1, 300, 5) = 1 Then
				zmemsmennuyukartinku("media\open_prikla2.bmp", 30, "media\open_prikla2_.bmp", 30)
				Sleep(2000 * $tormoza)
				zmemsmennuyukartinku("media\open_prikla2.bmp", 30, "media\open_prikla2_.bmp", 30)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func openotpravkagen($kartinka)
	WinActivate($windowTitle)
	;writelog("=====ОТПРАВКА ГЕНЕРАЛОВ " & $kartinka & @CRLF)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	If findclickoncenterandwaitresult($kartinka, "media\otpravit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\otpravit.bmp", "media\otpravka_no.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			Sleep(2000 * $tormoza)
			sleepwhile("media\otppravka_vniz.bmp", 100, 5)
			If _imagesearcharea("media\otpravka_no.bmp", 1, 500, 100, @DesktopWidth - 200, @DesktopHeight, $tx, $ty, 40) = 0 Then Return 0
			$area0_top_x = $tx - 305
			$area0_top_y = $ty - 144
			$area0_bottom_x = $tx - 46
			$area0_bottom_y = $ty - 80
			$area1_top_x = $tx - 305
			$area1_top_y = $ty - 316
			$area1_bottom_x = $tx - 46
			$area1_bottom_y = $ty - 228
			$area2_top_x = $tx - 46
			$area2_top_y = $ty - 305
			$area2_bottom_x = $tx + 216
			$area2_bottom_y = $ty - 228
			$area3_top_x = $tx - 305
			$area3_top_y = $ty - 228
			$area3_bottom_x = $tx - 46
			$area3_bottom_y = $ty - 144
			$area4_top_x = $tx - 46
			$area4_top_y = $ty - 228
			$area4_bottom_x = $tx + 216
			$area4_bottom_y = $ty - 144
			Return 1
		Else
			$search = 0
		EndIf
	EndIf
	Return 0
EndFunc

Func gotopricla($kartinka)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	writelog("=====ПЕРЕХОД В ПРИКЛЮЧЕНИЕ " & $kartinka & @CRLF)
	If findclickoncenterandwaitresult($kartinka, "media\posetit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\posetit.bmp", "media\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
				Sleep(6000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i > 98 Then
				Return 0
			EndIf
			collectwarikiatprikl()
			TrayTip("", "Ждём прибытия генералов", 0)
			Sleep(960000 - 6000 * $i)
			writelog("=====Успех " & $i * 6 & @CRLF)
			Return 1
		EndIf
	EndIf
	writelog("=====Ошибка " & $i * 6 & @CRLF)
	Return 0
EndFunc

Func gotopriclanosleep($kartinka)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	writelog("=====ПЕРЕХОД В ПРИКЛЮЧЕНИЕ " & $kartinka & @CRLF)
	If findclickoncenterandwaitresult($kartinka, "media\posetit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\posetit.bmp", "media\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
				Sleep(6000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i = 100 Then
				Return 0
			EndIf
			collectwarikiatprikl()
			Return 1
		EndIf
	EndIf
	Return 0
EndFunc

Func gotohome($kartinka)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	If findclickoncenterandwaitresult($kartinka, "media\gotohome.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\gotohome.bmp", "media\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
				Sleep(6000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i = 100 Then
				Return 0
			EndIf
			sleepwhile($kartinka, 30, 30)
			If haveimage($kartinka, 30) = 1 Then
				Sleep(2000 * $tormoza)
				Return 1
			Else
				Return 0
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func endpricla($sekund)
	Sleep($sekund * 1000)
	writelog("=====ЗАКОНЧИМ ПРИКЛЮЧЕНИЕ " & $sekund & @CRLF)
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\KNZOK.bmp", 30)
	If findclickoncenterandwaitnoneresult("media\KNZOK.bmp", 20, 10, 10, 100, 10) = 1 Then
		Sleep(1000 * $tormoza)
		zmemsmennuyukartinku("media\KNZOK.bmp", 30, "media\KNZOK_.bmp", 30)
		While haveimage("media\go_home.bmp", 50) = 0
			Sleep(1000 * $tormoza)
		WEnd
		If findclickoncenterandwaitresult("media\go_home.bmp", "media\perehod_v_zonu.bmp", 50, 20, 2, 60, 0, 200, 2) = 1 Then
			While haveimage("media\perehod_v_zonu.bmp", 50) = 1
				Sleep(1000 * $tormoza)
			WEnd
			writelog("=====УСПЕХ " & @CRLF)
			Return 1
		EndIf
	EndIf
	writelog("=====ОШИБКА " & @CRLF)
	Return 0
EndFunc

Func ozidanierasstanovki2($image, $image_NA, $yes)
	; Ждём генерала от LEKALA (ака Андрей)
	Local $tx = 0, $ty = 0, $i = 1, $ii = 0, $count_list = 5, $count_line = 3, $count_gen_in_line = 9
	; $count_list - задаем количество листаний звезды - число ген из ини файла делим на количество ген на одном экране звезды (3 верхних строки по 9 ген в строке) Идея и реализация от Marsik-A.
	$count_list = int(ReadINI("main", "total_generals", "50")/($count_line * $count_gen_in_line))
	Sleep(500 * $tormoza)
	openzvezdap()
	While ($ii < 2)
		selecttabatzvezda("specialisti", 0)
		$i = 1
		While ($i < $count_list)
			Select
				Case haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 1 AND haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 0	
					;Если условие выполняется на первом экране, то ждём появления хотя бы одного активного.
					If (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) = 0 Then
						;TrayTip("Отсутствует ползунок", "Нашли только пассивных на одном экране, ждём появления одного активного.", 5)
						sleepwhile($image, 30, 900/$count_list)
					EndIf					
					;Если условие выполняется на 4 строки, то проверяем выполнение условия в первой строке.
					while (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0
						;TrayTip("Видим только пассивных", "Нашли только пассивных, листаем по 1 строке до первой и ждём появления одного активного.", 5)
						If (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) AND (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 0) Then
							sleepwhile($image, 30, 900/$count_list)
							ExitLoop
						Else
							zvezdamovepolzunokdown(0)
						EndIf
					Wend
					$i = $i + 1
				Case haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0 AND haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0
					;Если условие выполняется на 3 верхних строки, то листаем 3 строки и добавляем счётчик экранов.
					If (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) = 0 Then
						;TrayTip("Отсутствует ползунок", "Не нашли ни активных, ни пассивных на одном экране. Надо куда-то выйти", 5)
						ExitLoop
 					EndIf					
					;TrayTip("Не видим никого", "Не нашли ни активных, ни пассивных, листаем 3 строки", 5)
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					sleep(500*tormoza)
					$i = $i + 1
				Case Else
				;Если оба предыдущих условия не являются истинными, то проверяем отсутствие активных в 3 верхних строках. 
					If (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0) Then
						While (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0
							;Если активные в 3 верхних строках отсутствуют, то, листая построчно, проверяем наличие пассивных ИЛИ активных в первой строке.
							If (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) Or (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) Then
								ExitLoop
							Else
								zvezdamovepolzunokdown(0)
							EndIf
						Wend
					;Если отсутствие активных в 3 верхних строках становится не истинным, то без лишнего листания выходим на закрытие функции УСПЕХОМ.
					;Листание по 1 строке до верхней можно добавить, если тестеры пожелают, но я пока не вижу в этом необходимости.
					ElseIf (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 1) Then
						;TrayTip("Видим одного активного", "Нашли хотя бы одного активного, выходим", 5)
						ExitLoop 2
					EndIf
			EndSelect		
		Wend
		$ii = $ii + 1
		If $i > $count_list Then ExitLoop	
	Wend
	If $ii = 2 Then
		;TrayTip("ОШИБКА", "Не нашли ни одного из выбранных ген!", 5)
		Return 0
	EndIf
	If ($yes = 1) Then
		zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
	EndIf
	;TrayTip("УСПЕХ", "Нашли хотя бы одного активного из выбранных ген!", 5)
	Return 1
EndFunc

Func ozidanierasstanovki($image, $image_NA, $yes)
	; Ждём всех генералов от LEKALA (ака Андрей)
	Local $tx = 0, $ty = 0, $i = 1, $ii = 0, $count_list = 5, $count_line = 3, $count_gen_in_line = 9
	; $count_list - задаем количество листаний звезды - число ген из ини файла делим на количество ген на одном экране звезды (3 верхних строки по 9 ген в строке) Идея и реализация от Marsik-A.
	$count_list = int(ReadINI("main", "total_generals", "50")/($count_line * $count_gen_in_line))
	Sleep(500 * $tormoza)
	openzvezdap()
	while ($ii < 2)
		selecttabatzvezda("specialisti", 0)
		$i = 1
		sleep(500*tormoza)
		while ($i < $count_list)
			Select
				Case haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 1 AND haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 1	
					If (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) = 0 Then
						;TrayTip("Отсутствует ползунок", "Нашли и активных, и пассивных на одном экране, ждём пропадания пассивных до 5 мин.", 5)
						sleepNOwhile($image_NA, 30, 300)
					EndIf					
					;Если условие выполняется на 4 строки, то проверяем выполнение условия в первой строке.
					while (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0
						;TrayTip("Видим разных", "Нашли и активных, и пассивных, листаем по 1 строке до первой и ждём пропадания пассивных до 5 мин", 5)
						If (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) OR (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) Then
							sleepNOwhile($image_NA, 30, 300)
							ExitLoop 
						Else
							zvezdamovepolzunokdown(0)
						EndIf
					Wend
					$i = $i + 1
				Case haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 1 AND haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3]) = 0	
					If (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) = 0 Then
						;TrayTip("Отсутствует ползунок", "Нашли только пассивных на одном экране, ждём пропадания пассивных до 5 мин.", 5)
						sleepNOwhile($image_NA, 30, 300)
					EndIf					
					;Если условие выполняется на 4 строки, то проверяем выполнение условия в первой строке.
					while (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0
						;TrayTip("Видим только пассивных", "Нашли только пассивных, листаем по 1 строке до первой и ждём пропадания пассивных до 5 мин", 5)
						If (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) AND (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 0) Then
							sleepNOwhile($image_NA, 30, 300)
							ExitLoop
						Else
							zvezdamovepolzunokdown(0)
						EndIf
					Wend
					$i = $i + 1
				Case haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0 AND haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0
					If (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) = 0 Then
						;TrayTip("Отсутствует ползунок", "Не нашли ни активных, ни пассивных на одном экране. Надо куда-то выйти", 5)
						ExitLoop
 					EndIf					
					;TrayTip("Не видим никого", "Не нашли ни активных, ни пассивных, листаем 3 строки", 5)
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					sleep(500*tormoza)
					$i = $i + 1
				Case Else
					If (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 0) AND (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 82) = 1) Then
						while (_imagesearcharea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 1, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25, $tx, $ty, 45)) <> 0
							If (haveimageAREA($image_NA, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 0) AND (haveimageAREA($image, 20, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3] - 250) = 1) Then
								ExitLoop
							Else
								zvezdamovepolzunokdown(0)
							EndIf
						Wend
						;TrayTip("Видим только активных", "Нашли только активных, выходим", 5)
						ExitLoop 2
					EndIf
			EndSelect		
		Wend
		$ii = $ii + 1
		If $i > $count_list Then ExitLoop	
	Wend
	If $ii = 2 Then
		;TrayTip("ОШИБКА", "Не нашли ни одного из выбранных ген!", 5)
		Return 0
	EndIf
	If ($yes = 1) Then
		zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
	EndIf
		;TrayTip("УСПЕХ", "Нашли только активных из выбранных ген!", 5)
	Return 1
EndFunc

#comments-start
Func ozidanierasstanovki2($image, $yes)
; Ждем одного генерала
	Local $tx = 0, $ty = 0, $ii = 1, $i = 0, $fl = 0, $count_list = 5, $count_line = 4, $count_gen_in_line = 9
	
	$count_list = int(ReadINI("main", "total_generals", "50")/($count_line * $count_gen_in_line)) ;задаем количество листаний звезды - число ген из ини файла делим на количество ген на одном экране звезды (4 видимых строки по 9 ген в строке)
	Sleep(500 * $tormoza)
	while ($i < 900) ; макисмальное время ожидания в секундах (15 минут)
		If openzvezdap() = 0 Then
			Return 0
		EndIf
		$ii = 1
		selecttabatzvezda("specialisti", 0)
		while 1
			If (_imagesearcharea($image, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 20) = 1) Then
				$fl = 1
				ExitLoop
			Else
				zvezdamovepolzunokdown(1)
				$ii = $ii + 1
				If $ii > $count_list Then ExitLoop
			EndIf
		WEnd
		If ($fl = 1) Then ExitLoop
		$i = $i + 1
		Sleep(1000)
	Wend
	If ($fl = 1) and ($yes = 1) Then
		zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
	EndIf
	If $i = 900 Then
		Return 0
	EndIf
	Return 1
EndFunc

Func ozidanierasstanovki($image, $image_NA, $yes)
; Ждем всех генералов
	Local $tx = 0, $ty = 0, $ii = 1, $i = 0, $fl = 0, $count_list = 5, $count_line = 4, $count_gen_in_line = 9
	
	$count_list = int(ReadINI("main", "total_generals", "50")/($count_line * $count_gen_in_line)) ;задаем количество листаний звезды - число ген из ини файла делим на количество ген на одном экране при листании звезды (3 видимых строки по 9 ген в строке)
	Sleep(500 * $tormoza)
	while 1 AND ($i < 900) ; макисмальное время ожидания в секундах (15 минут)
		If openzvezdap() = 0 Then
			Return 0
		EndIf
		$ii = 1
		selecttabatzvezda("specialisti", 0)
		while 1
			If (_imagesearcharea($image, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 20) = 1) AND (_imagesearcharea($image_NA, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 20) = 0)  Then
				$fl = 1
				ExitLoop
			Else
				sleep(500*tormoza)
				zvezdamovepolzunokdown(0)
				sleep(500*tormoza)
				zvezdamovepolzunokdown(0)
				sleep(500*tormoza)
				zvezdamovepolzunokdown(0)
				$ii = $ii + 1
				If $ii > $count_list Then ExitLoop
			EndIf
		WEnd
		If ($fl = 1) Then ExitLoop
		$i = $i + 1
		Sleep(1000)
	Wend
	If ($fl = 1) and ($yes = 1) Then
		zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
	EndIf
	If $i = 900 Then
		writelog("=====ОШИБКА " & $i & @CRLF)
			Return 0
	EndIf
	writelog("=====УСПЕХ " & $i & @CRLF)
	Return 1
EndFunc
#comments-end

Func vibor_elitnoy_armii($tabname)
	writelog("| VA " & $tabname)
	Local $ty = 0, $tx = 0, $search = 0, $ay = 0, $ax = 0
	Switch $tabname
		Case "mechniki"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 24
				$maxx = $tx + 84
				$maxy = $ty + 24
				$minx = $tx + 6
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "rizari"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 24
				$maxx = $tx + 333
				$maxy = $ty + 24
				$minx = $tx + 257
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "km"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 24
				$maxx = $tx + 208
				$maxy = $ty + 24
				$minx = $tx + 130
				$miny = $ty + 24
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "sb"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 78
				$maxx = $tx + 208
				$maxy = $ty + 78
				$minx = $tx + 130
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "strelki"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 78
				$maxx = $tx + 84
				$maxy = $ty + 78
				$minx = $tx + 6
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "ks"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 78
				$maxx = $tx + 333
				$maxy = $ty + 78
				$minx = $tx + 257
				$miny = $ty + 78
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "mo"
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 132
				$maxx = $tx + 84
				$maxy = $ty + 132
				$minx = $tx + 6
				$miny = $ty + 132
				_imagesearcharea("media\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
	EndSwitch
	Return 0
EndFunc

Func apply_elitnoy_army($mo, $ks, $strelki, $sb, $rizari, $km, $mechniki, $gena, $yes)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	writelog(@CRLF & "=====AEA " & $mo & "," & $ks & "," & $strelki & "," & $sb & "," & $rizari & "," & $km & "," & $mechniki & "," & $gena & "," & $yes & @CRLF)
	If smena_armii(1) = 0 Then Return 0
	$search = _imagesearch("media\0.bmp", 1, $tx, $ty, 20)
	go5()
	If $mo = 0 AND $ks = 0 AND $strelki = 0 AND $sb = 0 AND $km = 0 AND $rizari = 0 AND $mechniki = 0 AND $search = 1 Then
		If $yes = 0 Then
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			Return 1
		EndIf
		$gluksnaboromarmii = $gluksnaboromarmii + 1
		zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
		Return 1
	EndIf
	zmemsmennuyukartinku("media\sbros.bmp", 50, "media\sbros_.bmp", 50)
	$diffarmy = $mo
	If set_elitnoy_army("mo", $mo, $gena) = 1 Then
		$diffarmy = $diffarmy + $ks
		If set_elitnoy_army("ks", $ks, $gena) = 1 Then
			$diffarmy = $diffarmy + $strelki
			If set_elitnoy_army("strelki", $strelki, $gena) = 1 Then
				$diffarmy = $diffarmy + $sb
				If set_elitnoy_army("sb", $sb, $gena) = 1 Then
					$diffarmy = $diffarmy + $km
					If set_elitnoy_army("km", $km, $gena) = 1 Then
						$diffarmy = $diffarmy + $rizari
						If set_elitnoy_army("rizari", $rizari, $gena) = 1 Then
							$diffarmy = $diffarmy + $mechniki
							If set_elitnoy_army("mechniki", $mechniki, $gena) = 1 Then
								If okclose_elitnoy_gena($yes) = 1 Then
									Return 1
								Else
									Return 0
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	writelog("=====ОШИБКА" & @CRLF)
	Return 0
EndFunc

Func set_elitnoy_army($kogo, $skolko, $gena)
	Local $ty = 0, $tx = 0, $search = 0, $fullGenaImg = 0, $i = 0
	;writelog("| SEA " & $kogo & "," & $skolko & "," & $gena & " | ")
	If $skolko = 0 Then
		;writelog("0" & @CRLF)
		Return 1
	EndIf
	$fullGenaImg = getFullGeneralImg($gena)
	If $skolko = 3000 Then
		vibor_elitnoy_armii($kogo)
		$i = 0
		$search = 0
		While ($i < 10) AND ($search = 0)
			MouseMove($maxx, $maxy, 10 * $tormoza)
			MouseClick("left", $maxx, $maxy, 2)
			$search = _imagesearch($fullGenaImg, 1, $tx, $ty, 30)
			Sleep(500 * $tormoza)
			$i = $i + 1
		WEnd
		If $i < 9 Then
			Return 1
		Else
			;writelog("Ошибка " & $i & @CRLF)
			TrayTip("", "Ошибка: Не набрали войска", 0)
			Return 0
		EndIf
	Else
		vibor_elitnoy_armii($kogo)
		$skolkokartinka = "media\army_values\" & $diffarmy & ".bmp"
		;writelog("+" & $skolko)
		$i = 0
		While vvodzifr($skolko) <> 1
			;writelog("+" & $skolko)
			MouseMove($minx, $miny, 10 * $tormoza)
			MouseClick("left", $minx, $miny, 2)
			$i = $i + 1
			if vvodzifr($skolko) = 2 Then Return 2
            if $i > 5 Then Return 0
		WEnd
		;writelog(" Успех " & $diffarmy & @CRLF)
		Return 1
	EndIf
	;writelog("Ошибка " & @CRLF)
	Return 0
EndFunc

Func okclose_elitnoy_gena($yes)
	Local $ty = 0, $tx = 0, $search = 0, $i = 0
	writelog("==OKEG | ")
	$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
	If $search = 0 Then
		writelog(" Генерал закрыт ")
		Return 1
	Else
		$i = 0
		$search = 0
		zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		While ($i < 6) AND ($search = 0)
			Sleep(1000 * $tormoza)
			$i = $i + 1
			sleepwhile("media\mechnik.bmp", 20, 10)
			$search = _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
		WEnd
		If $i < 6 Then
			If $yes = 0 Then
				$gluksnaboromarmii = $gluksnaboromarmii + 1
				Return 1
			EndIf
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			If $yes = 1 Then
				zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
			EndIf
			If $yes = 2 Then
				zmemsmennuyukartinku("media\gohome.bmp", 30, "media\gohome_.bmp", 30)
				zmemsmennuyukartinku("media\nubook.bmp", 30, "media\nubook_.bmp", 30)
			EndIf
			writelog(" Успешно ")
			Return 1
		Else
			zmemsmennuyukartinku("media\closegena.bmp", 30, "media\closegena_.bmp", 30)
			TrayTip("", "Ошибка: Не назначили войска", 0)
			writelog(" ОШИБКА ")
			Return 0
		EndIf
	EndIf
	writelog(" ОШИБКА !0! ")
	Return 0
EndFunc

Func smena_armii($kakaya)
	Local $tx = 0, $ty = 0, $i = 0
	If $kakaya = 1 Then
		writelog("Элитная армия ")
		If _imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20) = 1 Then
			writelog("уже назначена" & @CRLF)
			Return 1
		Else
			zmemsmennuyukartinku("media\zamena_boicov.bmp", 50, "media\zamena_boicov_.bmp", 50)
			$i = 0
			While (_imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20) <> 1) AND ($i < 30)
				Sleep(2000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i < 29 Then Return 1
		EndIf
	Else
		writelog("Простая армия ")
		If _imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20) = 1 Then
			writelog("уже назначена" & @CRLF)
			Return 1
		Else
			zmemsmennuyukartinku("media\zamena_boicov.bmp", 50, "media\zamena_boicov_.bmp", 50)
			$i = 0
			While (_imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20) <> 1) AND ($i < 30)
				Sleep(2000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i < 29 Then Return 1
		EndIf
	EndIf
	writelog("ОШИБКА!!!" & @CRLF)
	Return 0
EndFunc

Func openpriklaxxx($kartinka, $kartinka2)
	Local $tx = 0, $ty = 0
	If haveimage($userDIR & $kartinka2, 30) = 1 Then
		Return 1
	EndIf
	If openzvezda() = 1 Then
		If selecttabatzvezda("prikli", 0) = 1 Then
			While (_imagesearch($userDIR & $kartinka, 1, $tx, $ty, 20) = 0)
				zvezdamovepolzunokdown(1)
				Sleep(300 * $tormoza)
			WEnd
			If findclickoncenterandwaitresult($userDIR & $kartinka, "media\open_prikla2.bmp", 20, 20, 5, 5, 1, 300, 5) = 1 Then
				zmemsmennuyukartinku("media\open_prikla2.bmp", 30, "media\open_prikla2_.bmp", 30)
				Sleep(2000 * $tormoza)
				zmemsmennuyukartinku("media\open_prikla2.bmp", 30, "media\open_prikla2_.bmp", 30)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func sborostatkovarmii($army_type, $fl_otpravka)
	Local $tx = 0, $ty = 0
	If $army_type = 1 Then
		If smena_armii($army_type) = 1 Then
			_imagesearch("media\mechnik.bmp", 1, $tx, $ty, 20)
			MouseClick("left", $tx + 83, $ty + 131, 1) ; мастера осады
			MouseClick("left", $tx + 332, $ty + 78, 1) ; конные стрелки
			MouseClick("left", $tx + 208, $ty + 78, 1) ; стрелки в броне
			MouseClick("left", $tx + 83, $ty + 78, 1)  ; стрелки
			MouseClick("left", $tx + 332, $ty + 24, 1) ; рыцари
			MouseClick("left", $tx + 208, $ty + 24, 1) ; конные мечники
			MouseClick("left", $tx + 83, $ty + 24, 1)  ; мечники
			Sleep(500 * $tormoza)
			Return okclose_elitnoy_gena($fl_otpravka)
		EndIf
	ElseIf $army_type = 0 Then
		If smena_armii($army_type) = 1 Then
			_imagesearch("media\nub_gena.bmp", 1, $tx, $ty, 20)
			MouseClick("left", $tx + 332, $ty + 132, 1)
			MouseClick("left", $tx + 208, $ty + 132, 1)
			MouseClick("left", $tx + 83, $ty + 132, 1)
			MouseClick("left", $tx + 332, $ty + 78, 1)
			MouseClick("left", $tx + 208, $ty + 78, 1)
			MouseClick("left", $tx + 83, $ty + 78, 1)
			MouseClick("left", $tx + 332, $ty + 24, 1)
			MouseClick("left", $tx + 208, $ty + 24, 1)
			MouseClick("left", $tx + 83, $ty + 24, 1)
			Sleep(500 * $tormoza)
			Return okclosegena($fl_otpravka)
		EndIf
	Else
		Return 0
	EndIf
EndFunc

; Новая функция отправки ген в прикл
Func otpravkagenvprikl($prikl, $gena, $shtuk, $imya)
	Local $tx = 0, $ty = 0, $i = 0, $generalov = 0, $ax = 0, $ay = 0, $search = 0, $error_otpravka = 0
	Local $for_i, $area_tmp_top_x, $area_tmp_top_y, $area_tmp_bottom_x, $area_tmp_bottom_y
	chatoff()
	drugioff()
	While 1
		If openotpravkagen($userDIR & $prikl) = 1 Then
			While ($generalov <> $shtuk) AND ($i < (ReadINI("main", "total_generals", "50") / 2))
				If haveimagearea("media\error_otpravka.bmp", 40, $area0_top_x, $area0_top_y, $area0_bottom_x, $area0_bottom_y) = 1 Then
					$error_otpravka = $error_otpravka + 1
					If $error_otpravka = 5 Then ExitLoop
				EndIf
				; цикл по области поиска генералов
				For $for_i = 1 To 4 Step 1
					; задаем площадь для поиска иконки гены
					Switch $for_i
						Case 1
							$area_tmp_top_x = $area1_top_x
							$area_tmp_top_y = $area1_top_y
							$area_tmp_bottom_x = $area1_bottom_x
							$area_tmp_bottom_y = $area1_bottom_y
						Case 2
							$area_tmp_top_x = $area2_top_x
							$area_tmp_top_y = $area2_top_y
							$area_tmp_bottom_x = $area2_bottom_x
							$area_tmp_bottom_y = $area2_bottom_y
						Case 3
							$area_tmp_top_x = $area3_top_x
							$area_tmp_top_y = $area3_top_y
							$area_tmp_bottom_x = $area3_bottom_x
							$area_tmp_bottom_y = $area3_bottom_y
						Case 4
							$area_tmp_top_x = $area4_top_x
							$area_tmp_top_y = $area4_top_y
							$area_tmp_bottom_x = $area4_bottom_x
							$area_tmp_bottom_y = $area4_bottom_y
					EndSwitch
					; ищем гену
					If _imagesearcharea($gena, 1, $area_tmp_top_x, $area_tmp_top_y, $area_tmp_bottom_x, $area_tmp_bottom_y, $tx, $ty, 20) = 1 Then
						If _imagesearcharea("media\Gena_plus.bmp", 1, $area_tmp_top_x, $area_tmp_top_y, $area_tmp_bottom_x, $area_tmp_bottom_y, $tx, $ty, 20) = 1 Then
							While _imagesearcharea("media\Gena_plus_yes.bmp", 1, $area_tmp_top_x, $area_tmp_top_y, $area_tmp_bottom_x, $area_tmp_bottom_y, $ax, $ay, 20) <> 1
								If haveimagearea("media\error_otpravka.bmp", 40, $area0_top_x, $area0_top_y, $area0_bottom_x, $area0_bottom_y) = 1 Then
									$error_otpravka = $error_otpravka + 1
									If $error_otpravka = 5 Then ExitLoop 3
								EndIf
								If $imya = "-" Then
									; листаем 1й раз отправку
									MouseMove($tx, $ty, 10 * $tormoza)
									Sleep(100 * $tormoza)
									MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
									Sleep(100 * $tormoza)
									removemouse(300, 0, 300)
								Else
									If skolko_voisk_v_gene($imya, $area_tmp_top_x, $area_tmp_top_y, $area_tmp_bottom_x, $area_tmp_bottom_y) = 0 Then
										$generalov = $generalov - 1
										ExitLoop
									Else
										MouseMove($tx, $ty, 10 * $tormoza)
										Sleep(100 * $tormoza)
										MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
										Sleep(100 * $tormoza)
										removemouse(300, 0, 300)
									EndIf
								EndIf
							WEnd
							go5()
							$generalov = $generalov + 1
							If $generalov = $shtuk Then ExitLoop 2
						EndIf
					EndIf
				Next
				$search = _imagesearcharea("media\otppravka_vniz.bmp", 1, 500, 100, @DesktopWidth - 200, @DesktopHeight, $tx, $ty, 90)
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(100 * $tormoza)
				; листаем окно отправки 1й раз
				MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
				Sleep(1000 * $tormoza)
				; листаем окно отправки 2й раз
				MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
				Sleep(500 * $tormoza)
				removemouse(300, 0, 300)
				$i = $i + 1
			WEnd
			If $generalov = $shtuk Then
				zmemsmennuyukartinku("media\otpravka_ok.bmp", 30, "media\otpravka_ok_.bmp", 30)
				Return 1
			EndIf
			zmemsmennuyukartinku("media\closegena.bmp", 90, "media\closegena_.bmp", 90)
			$generalov = 0
			$error_otpravka = 0
			$i = 0
		EndIf
	WEnd
EndFunc

Func skolko_voisk_v_gene($imya, $area_top_x, $area_top_y, $area_bottom_x, $area_bottom_y)
	Sleep(1000 * $tormoza)
	Local $i = 0, $tx, $ty, $current_nik1_x, $current_nik1_y, $error = 0, $nik_symbol
	If _imagesearcharea("media\text\X.bmp", 1, $area_top_x, $area_top_y, $area_bottom_x, $area_bottom_y, $tx, $ty, 40) = 0 Then
		Return 0
	EndIf
	If $imya = "+" Then
		MouseMove($tx, $ty, 10 * $tormoza)
		Sleep(100 * $tormoza)
		Sleep(900 * $tormoza)
		If (haveimage("media\otpravkingena2.bmp", ReadINI("main", "general_name_graphics", "100")) = 0) AND (haveimage("media\otpravkingena.bmp", ReadINI("main", "general_name_graphics", "100")) = 0) Then
			go5()
			Return 0
		Else
			Return 1
		EndIf
	EndIf
	$current_nik1_x = $tx + 15
	$current_nik1_y = $ty - 10
	While $i < StringLen($imya)
		$nik_symbol = StringMid($imya, $i + 1, 1)
		If (_imagesearcharea("media\text\" & $nik_symbol & ".bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) OR (_imagesearcharea("media\text\" & $nik_symbol & "_.bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) OR (_imagesearcharea("media\text\" & $nik_symbol & "__.bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) Then
			$i = $i + 1
			$current_nik1_x = $tx
		Else
			$error = $error + 1
			$i = $i + 1
			$current_nik1_x = $current_nik1_x + 7
			If $error = 1 Then $i = 3000
		EndIf
	WEnd
	If $i = StringLen($imya) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func rungeolog($kuda, $skolko, $kakih)
   	Local $i = 0, $ii = 0, $tx, $ty

	Local $vidgeologov[0]
	Local $allGeologistsJson = getDataGroupSpecialists("geologists")
	Local $count = UBound($allGeologistsJson) - 1
	For $j = 0 To $count  Step + 1
		_ArrayAdd($vidgeologov, "media\" & Json_Get($allGeologistsJson, '[' & $j & '].img_active'))
	Next

	WinActivate($windowTitle)
	chatoff()
	drugioff()
	If openzvezda() = 0 Then Return 0
	If selecttabatzvezda("specialisti", 0) = 0 Then Return 0
	If $kakih == 0 Then
		While $i < $skolko
			If openzvezda() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					While 1
						MouseMove($zvezda_area[0] + + Random(-2, 2, 1), $zvezda_area[3] + + Random(-2, 2, 1), 10* $tormoza)
						For $j = 0 To $count Step + 1
							If _imagesearcharea($vidgeologov[$j], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop 2
						Next
						$ii = $ii + 1
						MouseMove($zvezda_area[0] + + Random(-2, 2, 1), $zvezda_area[3] + + Random(-2, 2, 1), 10* $tormoza)
						If $ii > 5 Then
							If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 30, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 1 Then
								zvezdamovepolzunokdown(1)
								Sleep(Random(500, 1000, 1) * $tormoza)
							Else
								zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
								Return 0
							EndIf
						EndIf
					WEnd
					$ii = 0
					While $ii < 6
						MouseMove($tx, $ty, 10 * $tormoza)
						Sleep(300 * $tormoza)
						MouseClick("left", $tx + Random(-2, 2, 1), $ty + Random(-2, 2, 1), 1)
						removemouse(543, 0, 100)
						sleepwhile("media\search_treasure_menu.bmp", 20, 10)
						If haveimage("media\search_treasure_menu.bmp", 20) = 1 Then ExitLoop
						$ii = $ii + 1
						If $ii = 6 Then Return 0
					WEnd
					selecttabatgeolog($kuda, 1)
					$i = $i + 1
				EndIf
			EndIf
		WEnd
		Return 1
	Else
		While $i < $skolko
			If openzvezda() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					While 1
						If _imagesearcharea($kakih, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						$ii = $ii + 1
						zvezdamovepolzunokdown(1)
						Sleep(Random(500, 1000, 1))
						If $ii > 8 Then
							If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 70, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 0 Then
								Return 0
							EndIf
						EndIf
					WEnd
					$ii = 0
					While $ii < 6
						MouseMove($tx, $ty, 10 * $tormoza)
						Sleep(300 * $tormoza)
						MouseClick("left", $tx + Random(-2, 2, 1), $ty + Random(-2, 2, 1), 1)
						sleepwhile("media\search_treasure_menu.bmp", 20, 10)
						If haveimage("media\search_treasure_menu.bmp", 20) = 1 Then ExitLoop
						$ii = $ii + 1
						If $ii = 6 Then Return 0
					WEnd
					selecttabatgeolog($kuda, 1)
					$i = $i + 1
				EndIf
			EndIf
		WEnd
		Return 1
	EndIf
	Return 0
EndFunc

Global $gx, $gy, $finterrupt = 0, $gpx = 0, $gpy = 0, $vidpoiska = 0, $tippoiska = 0, $kartinkatippoiska = 0, $kartinkavidpoiska = 0, $kartinkatippoiska2 = 0, $kartinkavidpoiska2 = 0, $schet = 0
#Region Запуск Почты

	Func viborpisma($kuda)
		Local $ty = 0, $tx = 0, $search = 0, $tcount = 0, $ay = 0, $ax = 0
		While ($tcount < 5555)
			If _imagesearcharea("media\srazenie.bmp", 1, 200, 50, (@DesktopWidth / 2), (@DesktopHeight / 3 * 2), $gpx, $gpy, 5) = 1 OR _imagesearcharea("media\baf.bmp", 1, 200, 50, (@DesktopWidth / 2), (@DesktopHeight / 3 * 2), $gpx, $gpy, 5) = 1 Then
				MouseMove($gpx + 536, $gpy, 5 * $tormoza)
				MouseClick("left", $gpx + Random(1, 2, 1) + 536, $gpy + Random(1, 2, 1), 1)
				MouseMove($gpx + 556, $gpy, 5 * $tormoza)
				Sleep(1000 * $tormoza)
			Else
				If _imagesearcharea("media\sunduk_po4ta.bmp", 1, 200, 50, (@DesktopWidth / 2), (@DesktopHeight / 3 * 2), $gpx, $gpy, 5) = 1 Then
					kliknasklad($kuda)
				ElseIf _imagesearcharea("media\prikl_po4ta.bmp", 1, 200, 50, (@DesktopWidth / 2), (@DesktopHeight / 3 * 2), $gpx, $gpy, 5) = 1 Then
					kliknasklad($kuda)
				Else
					If _imagesearch("media\prinyato_off.bmp", 1, $gpx, $gpy, 5) = 1 OR _imagesearch("media\prinyato_on.bmp", 1, $gpx, $gpy, 5) = 1 Then
						MouseClick("left", $gpx + Random(1, 2, 1), $gpy + Random(1, 2, 1), 1)
						Sleep(1000 * $tormoza)
						_imagesearch("media\OK_po4ta.bmp", 1, $ax, $ay, 5)
						MouseMove($ax, $ay, 5 * $tormoza)
						MouseClick("left", $ax + Random(1, 2, 1), $ay + Random(1, 2, 1), 1)
						Sleep(1000 * $tormoza)
					Else
						Return 0
					EndIf
				EndIf
			EndIf
			$tcount = $tcount + 1
			$schet = $schet + 1
		WEnd
		Return 0
	EndFunc

	Func kliknasklad($kuda)
		Local $ty = 0, $tx = 0, $sklad = 0, $ok = 0
		MouseMove($gpx, $gpy, 10 * $tormoza)
		MouseClick("left", $gpx + Random(1, 2, 1), $gpy + Random(1, 2, 1), 1)
		Sleep(2500 * $tormoza)
		$sklad = _imagesearcharea($kuda, 1, (@DesktopWidth / 2), (@DesktopHeight / 2), @DesktopWidth, (@DesktopHeight - 50), $tx, $ty, 20)
		If $sklad = 1 Then
			MouseMove($tx, $ty, 10 * $tormoza)
			MouseClick("left", $tx + Random(1, 5, 1), $ty + Random(1, 4, 1), 1)
			Sleep(200 * $tormoza)
			Return 1
		Else
			$sklad = _imagesearcharea("media\vniz_po4ta.bmp", 1, (@DesktopWidth / 3 * 2), (@DesktopHeight / 2), @DesktopWidth, (@DesktopHeight - 50), $tx, $ty, 20)
			If $sklad = 1 Then
				MouseMove($tx, $ty, 10 * $tormoza)
				MouseClick("left", $tx + Random(1, 5, 1), $ty + Random(1, 4, 1), 4)
				Sleep(200 * $tormoza)
				$sklad = _imagesearcharea($kuda, 1, (@DesktopWidth / 2), (@DesktopHeight / 2), @DesktopWidth, (@DesktopHeight - 50), $tx, $ty, 20)
				If $sklad = 1 Then
					MouseMove($tx, $ty, 10 * $tormoza)
					MouseClick("left", $tx + Random(1, 5, 1), $ty + Random(1, 4, 1), 1)
					Sleep(200 * $tormoza)
					Return 1
				EndIf
			EndIf
		EndIf
		Return 0
	EndFunc

	Func runpo4ta($kuda)
		WinActivate($windowTitle)
		Local $x = 0, $y = 0
		TrayTip("", "Почитаем почту...", 0)
		If openpo4ta() = 0 Then
			TrayTip("", "Не удалось открыть почту! Отменяем!", 0)
			Return 0
		EndIf
		While viborpisma($kuda) = 1
			$schet = $schet + 1
		WEnd
		If _imagesearch("media\close.bmp", 1, $x, $y, 70) = 1 Then
			MouseMove($x, $y, 10 * $tormoza)
			MouseClick("left", $x + Random(1, 5, 1), $y + Random(1, 4, 1), 1)
			TrayTip("", "Мы обработали " & $schet & " писем", 0)
			Return 1
		EndIf
		Return 0
	EndFunc

#EndRegion

Func runrazved($adv_srch, $arti, $vidpoiska, $tippoiska, $count_kakih, $Arr_kakih)
	Local $adv_search_yes = 0
	Local $curr_i, $j = 0, $i = 0, $ii = 0, $tx, $ty

	Local $name_razvedov[0], $vidrazvedov[0], $flag_adv_search[0], $slat_yes[0]
	Local $allScoutsJson = getDataGroupSpecialists("scouts")
	Local $count = UBound($allScoutsJson) - 1

	For $j = 0 To $count Step + 1
		_ArrayAdd($name_razvedov, Json_Get($allScoutsJson, '[' & $j & '].name'))
		_ArrayAdd($vidrazvedov, "media\" & Json_Get($allScoutsJson, '[' & $j & '].img_active'))
		_ArrayAdd($flag_adv_search, Json_Get($allScoutsJson, '[' & $j & '].adv_search'))
		_ArrayAdd($slat_yes, 0)
	Next

	WinActivate($windowTitle)
	Switch $tippoiska
		Case "Быстрый"
			$kartinkatippoiska = "media\search_treasure_fast.bmp"
			$kartinkatippoiska2 = "media\search_treasure_fast_.bmp"
		Case "Средний"
			$kartinkatippoiska = "media\search_treasure_sredny.bmp"
			$kartinkatippoiska2 = "media\search_treasure_sredny_.bmp"
		Case "Долгий"
			$kartinkatippoiska = "media\search_treasure_long.bmp"
			$kartinkatippoiska2 = "media\search_treasure_long_.bmp"
		Case "ОченьДолгий"
			$kartinkatippoiska = "media\search_treasure_very_long.bmp"
			$kartinkatippoiska2 = "media\search_treasure_very_long_.bmp"
		Case "Длительный"
			$kartinkatippoiska = "media\search_treasure_super_long.bmp"
			$kartinkatippoiska2 = "media\search_treasure_super_long_.bmp"
	EndSwitch
	Switch $vidpoiska
		Case "Сокровища"
			$kartinkavidpoiska = "media\search_treasure_button.bmp"
			$kartinkavidpoiska2 = "media\search_treasure_button_.bmp"
		Case "Приключения"
			$kartinkavidpoiska = "media\poisk_prikla.bmp"
			$kartinkavidpoiska2 = "media\poisk_prikla_.bmp"
	EndSwitch
	chatoff()
	drugioff()
	If openzvezda() = 0 Then Return 0
	If selecttabatzvezda("specialisti", 0) = 0 Then Return 0

	If $count_kakih = 0 Then
		; шлем всех
		For $j = 0 To $count Step + 1
			$slat_yes[$j] = 1
		Next
	Else
		; выбираем кого слать
		For $i = 0 To $count ; цикл по всем разведам
			For $j = 0 To $count_kakih - 1 ; цикл по разведам, кого нужно отправить
				If $Arr_kakih[$j] = $name_razvedov[$i] Then
					$slat_yes[$i] = 1
					Exitloop
				EndIf
			Next
		Next
	EndIf

	; Отправка
	$ii = 0
	While 1
		If openzvezda() = 1 Then
			While 1
				MouseMove($zvezda_area[0] + + Random(-2, 2, 1), $zvezda_area[3] + + Random(-2, 2, 1), 10 * $tormoza)
				For $j = 0 To $count Step + 1
					If $slat_yes[$j] = 1 Then
						If _imagesearcharea($vidrazvedov[$j], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then
							If ($adv_srch = 1) And ($flag_adv_search[$j] = 1) Then $adv_search_yes = 1
							ExitLoop 2
						EndIf
					EndIf
				Next
				$ii = $ii + 1
				MouseMove($zvezda_area[0] + + Random(-2, 2, 1), $zvezda_area[3] + + Random(-2, 2, 1), 10 * $tormoza)
				
				; если 5 раз подергали мышь и не нашли, кого отправить - то листаем звезду 
				If $ii > 5 Then
					If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 70, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 1 Then
						zvezdamovepolzunokdown(1)
						Sleep(Random(500, 1000, 1) * $tormoza)
					Else
						zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
						Return 1
					EndIf
				EndIf	
			WEnd
			$ii = 0
			While $ii < 6
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(300 * $tormoza)
				MouseClick("left", $tx + Random(-2, 2, 1), $ty + Random(-2, 2, 1), 1)
				removemouse(543, 0, 100)
				sleepwhile("media\search_treasure_menu.bmp", 20, 10)
				If haveimage("media\search_treasure_menu.bmp", 20) = 1 Then ExitLoop
				$ii = $ii + 1
				If $ii = 6 Then Return 0
			WEnd
			If $adv_search_yes = 1 Then
				zmemsmennuyukartinku("media\poisk_prikla.bmp", 30, "media\poisk_prikla_.bmp", 30)
				go5()
				$adv_search_yes = 0
				If $kartinkatippoiska = "media\search_treasure_super_long.bmp" Then
					zmemsmennuyukartinkuizdem("media\search_treasure_very_long.bmp", 30, "media\search_treasure_very_long_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
					zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
				EndIf
			Else
				zmemsmennuyukartinku($kartinkavidpoiska, 30, $kartinkavidpoiska2, 30)
				go5()
				removemouse(500, 0, 500)
				If ($arti = 1) and (haveimage("media\search_artifact.bmp", 20) = 1) Then
					zmemsmennuyukartinkuizdem("media\search_artifact.bmp", 30, "media\search_artifact_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
				Else
					zmemsmennuyukartinkuizdem($kartinkatippoiska, 30, $kartinkatippoiska2, 30, "media\search_button_OK_enabled.bmp", 20)
				EndIf
				zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
			EndIf
		EndIf
	WEnd
EndFunc

Func clickOnCoordinates($img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $i = 0

	Sleep(1000 * $tormoza)

	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $kudax)) AND (($tochka_sektora_x + $kudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $kuday)) AND (($tochka_sektora_y + $kuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf

	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday

	MouseMove($kudax, $kuday, 10 * $tormoza)
	Sleep(200 * $tormoza)
	MouseClick("left", $kudax, $kuday, 2)
	go5()
	Sleep(200 * $tormoza)

	Return 1
EndFunc

Func openGenaOnpxp($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday)
	Local $tx = 0, $ty = 0, $i = 0

	Sleep(500 * $tormoza)

	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, $sectorGraph) = 1) Then
		If (200 < ($tochka_sektora_x + $otkudax)) AND (($tochka_sektora_x + $otkudax) < (@DesktopWidth - 200)) Then
			If (200 < ($tochka_sektora_y + $otkuday)) AND (($tochka_sektora_y + $otkuday) < (@DesktopHeight - 200)) Then
				$centrovat = 1
			Else
				$centrovat = 1
				If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
			EndIf
		Else
			$centrovat = 1
			If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
		EndIf
	Else
		$centrovat = 1
		If find_sektor($img, $k_x, $k_y, $else_x, $else_y) = 0 Then Return 0
	EndIf

	$otkudax = $tochka_sektora_x + $otkudax
	$otkuday = $tochka_sektora_y + $otkuday

	While (_imagesearch("media\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 20)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\Truba.bmp", 30, 6)
		$i = $i + 1
	WEnd
	If $i = 20 Then
		Return 0
	EndIf
	
	Return 1
EndFunc