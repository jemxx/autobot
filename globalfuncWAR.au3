Dim $proverkasliva

Func podgotovka()
	chatoff()
	drugioff()
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\army_values\Close.bmp", 30)
	zmemsmennuyukartinku("media\army_values\Close.bmp", 30, "media\army_values\Close_.bmp", 30)
	openmashtab()
	collectwarikiatprikl()
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\army_values\Close.bmp", 30)
	zmemsmennuyukartinku("media\army_values\Close.bmp", 30, "media\army_values\Close_.bmp", 30)
	If openzvezdap() = 1 Then
		If selecttabatzvezda("specialisti", 0) = 1 Then
			zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
			openmashtab()
			Return 1
		EndIf
	EndIf
EndFunc

Func find_sektor($img, $k_x, $k_y, $else_x, $else_y)
	WinActivate("The Settlers Онлайн")
	Local $tx = 0, $ty = 0, $search = 0, $i = 0, $ax = 0, $ay = 0, $search2 = 0, $ttx = 0, $tty = 0
	$search2 = _imagesearch("media\pismo.bmp", 1, $ax, $ay, 50)
	$k_x = $ax + $k_x
	$k_y = $ay + $k_y
	If _imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1 Then
		writelog("Карта изначально привязана X:" & $tochka_sektora_x & " Y:" & $tochka_sektora_y)
		Return 1
	EndIf
	While (_imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) <> 1) AND ($i < 10)
		go5()
		$search = _imagesearch($img, 1, $tx, $ty, read_ini(1))
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
			$search = _imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1))
			writelog("Переместили карту X:" & $tochka_sektora_x & " Y:" & $tochka_sektora_y)
			If _imagesearcharea($img, 1, $k_x - 30, $k_y - 30, $k_x + 30, $k_y + 30, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1 Then
				Return 1
			EndIf
			If _imagesearcharea($img, 1, $k_x - 50, $k_y - 50, $k_x + 50, $k_y + 50, $tochka_sektora_x, $tochka_sektora_y, read_ini(1) + 30) = 1 Then
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

Func perestanovka_geni_iz_zvezdi($general, $nomergenerala, $voisko, $tip_voiska, $img, $k_x, $k_y, $else_x, $else_y, $kudax, $kuday)
	Local $tx = 0, $ty = 0, $i = 0
	$gluksnaboromarmii = 0
	While $gluksnaboromarmii <> 1
		writelog($gluksnaboromarmii)
		If openzvezdap() = 1 Then
			While _imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				Sleep(1000 * $tormoza)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
		While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
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
		While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0) AND ($i < 10)
			MouseMove($otkudax, $otkuday, 10 * $tormoza)
			Sleep(500 * $tormoza)
			MouseClick("left", $otkudax, $otkuday, 1)
			go5()
			sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
			sleepwhile("media\army_values\Otmena.bmp", 30, 10)
			While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 6)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 5)
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
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
			While _imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
			While _imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
			While _imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	ElseIf haveimage("media\army_values\1.bmp", 20) = 1 Then
		zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
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

Func atakalageraotkritimgenoynoini($kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	$kudax = $tochka_sektora_x + $kudax
	$kuday = $tochka_sektora_y + $kuday
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
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
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 6)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 5)
		go5()
		$i = $i + 1
	WEnd
	If $i = 6 Then
		Return 0
	EndIf
	zmemsmennuyukartinku("media\Ataka.bmp", 30, "media\Ataka_.bmp", 30)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 6)
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
			While _imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0
				generali($general, $nomergenerala)
				Sleep(1000 * $tormoza)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
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
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
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
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(200 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	ElseIf haveimage("media\army_values\1.bmp", 20) = 1 Then
		zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
		Return 1
	Else
		Return applyarmy($nubi, $menti, $soldati, $elita, $luki, $dluki, $arbi, $koni, $puhi, $gena, 1)
	EndIf
	Return 0
EndFunc

Func open_usilok($tb_name, $img_usilka, $currentbuf)
	Local $i = 0
	If $currentbuf = 1 Then
		If haveimage("media\army_values\Otmena.bmp", 50) = 1 Then Return 1
	EndIf
	If openzvezdap() = 1 Then
		If selecttabatzvezda($tb_name, 1) = 1 Then
			While (haveimage($img_usilka, 50) = 0) AND ($i < 5)
				zvezdamovepolzunokdown(0)
				Sleep(Random(500, 1000, 1) * $tormoza)
				$i = $i + 1
			WEnd
			Return findclickoncenterandwaitresult($img_usilka, "media\army_values\Otmena.bmp", 30, 80, 5, 5, 0, 30, 30)
		EndIf
	EndIf
	Return 0
EndFunc

Func plunusilok_koordinati($tb_name, $img_usilka, $kudax, $kuday, $img, $k_x, $k_y, $else_x, $else_y, $currentbuf)
	If open_usilok($tb_name, $img_usilka, $currentbuf) = 0 Then Return 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
		If $currentbuf = 0 Then zmemsmennuyukartinku("media\army_values\Otmena.bmp", 30, "media\army_values\Otmena_.bmp", 30)
		Return 1
	ElseIf $tb_name = "raznoe" Then
		zmemsmennuyukartinku("media\army_values\nubook.bmp", 30, "media\army_values\nubook.bmp", 30)
		zmemsmennuyukartinku("media\army_values\Otmena.bmp", 30, "media\army_values\Otmena_.bmp", 30)
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
		If _imagesearcharea("media\army_values\friend_atak.bmp", 1, $ax, 0, $ax + 300, $ay + 700, $tx, $ty, 30) = 1 Then
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
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 30) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		go5()
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
		$i = $i + 1
	WEnd
	If $i = 10 Then
		Return 0
	EndIf
	zmemsmennuyukartinku("media\truba.bmp", 50, "media\truba_.bmp", 50)
	$i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	sleepwhile("media\army_values\Otmena.bmp", 30, 10)
	While (_imagesearch("media\army_values\Otmena.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 10)
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
	While haveimage("media\army_values\zadacha_geni.bmp", 30) = 0
		If openzvezdap() = 1 Then
			If selecttabatzvezda("specialisti", 1) = 1 Then
				generali($general, $nomergenerala)
				Sleep(1000 * $tormoza)
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
			EndIf
		EndIf
	WEnd
	zmemsmennuyukartinku("media\army_values\gohome.bmp", 30, "media\army_values\gohome_.bmp", 30)
	zmemsmennuyukartinku("media\army_values\nubook.bmp", 30, "media\army_values\nubook_.bmp", 30)
	Return 1
EndFunc

Func openpriglosdruga($prikl, $imya)
	While 1
		If findclickoncenterandwaitresult("media\army_values\" & $prikl, "media\army_values\priglos.bmp", 30, 30, 5, 10, 1, -300, -300) = 1 Then
			If findclickoncenterandwaitresult("media\army_values\priglos.bmp", "media\army_values\igroki_in_prikla.bmp", 30, 30, 10, 10, 1, -300, -300) = 1 Then
				If findclickoncenterandwaitresult("media\army_values\plus_igrok.bmp", "media\army_values\okdrug_off.bmp", 30, 30, 10, 10, 1, -300, -300) = 1 Then
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

Func stoitligena($img, $k_x, $k_y, $else_x, $else_y, $otkudax, $otkuday)
	Local $tx = 0, $ty = 0, $search = 0, $i = 0
	If ($centrovat = 0) AND (_imagesearch($img, 1, $tochka_sektora_x, $tochka_sektora_y, read_ini(1)) = 1) Then
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
	While (_imagesearch("media\army_values\zadacha_geni.bmp", 1, $tx, $ty, 20) = 0) AND ($i < 10)
		MouseMove($otkudax, $otkuday, 10 * $tormoza)
		Sleep(500 * $tormoza)
		MouseClick("left", $otkudax, $otkuday, 1)
		sleepwhile("media\army_values\zadacha_geni.bmp", 30, 5)
		go5()
		$i = $i + 1
	WEnd
	If $i < 10 Then
		zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
		Return 1
	EndIf
	Return 0
EndFunc

Global $strelkax = 0, $strelkay = 0, $maxx = 0, $maxy = 0, $minx = 0, $miny = 0, $diffarmy = 0
Global $gluksnaboromarmii = 0, $polezifrx = 0, $polezifry = 0, $skolkokartinka = 0, $skoko_voln_puskaem = 0
Global $general_1_x, $general_1_y, $general_2_x, $general_2_y, $general_1_temp_x, $general_1_temp_y
Global $gluksnaboromarmii = 0, $1sektorx, $1sektory, $skoko_voln_puskaem = 2
Global $search_treasure_menu_x, $search_treasure_menu_y
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
	$search = _imagesearch("media\army_values\0.bmp", 1, $tx, $ty, 20)
	If $nubi = 0 AND $menti = 0 AND $soldati = 0 AND $elita = 0 AND $luki = 0 AND $dluki = 0 AND $arbi = 0 AND $koni = 0 AND $puhi = 0 AND $search = 1 Then
		If $yes = 0 Then
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			Return 1
		EndIf
		$gluksnaboromarmii = $gluksnaboromarmii + 1
		zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
		Return 1
	EndIf
	zmemsmennuyukartinku("media\army_values\sbros.bmp", 50, "media\army_values\sbros_.bmp", 50)
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
	writelog("| SA " & $kogo & "," & $skolko & "," & $gena & " | ")
	If $skolko = 0 Then
		writelog("0" & @CRLF)
		Return 1
	EndIf

	$fullGenaImg = getFullGeneralImg($gena)

	If $skolko = 1000 Then
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
			$i = 0
			$search = 0
			Return 1
			If findclickoncenterandwaitresult1("media\search_button_OK_enabled.bmp", "media\army_values\zdem.bmp", 30, 20, 3, 5, 1, -100, 1) = 1 Then
				While ($i < 30 * $tormoza) AND ($search = 0)
					Sleep(1000 * $tormoza)
					$i = $i + 1
					$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
				WEnd
				If $i < 20 Then
					Return 1
				EndIf
			Else
				TrayTip("", "Ошибка: Не нажали Ок", 0)
				Return 0
			EndIf
		Else
			TrayTip("", "Ошибка: Не набрали войска", 0)
			Return 0
		EndIf
	Else
		viborarmii($kogo)
		$skolkokartinka = "media\army_values\" & $diffarmy & ".bmp"
		While vvodzifr($skolko) <> 1
			MouseMove($minx, $miny, 10 * $tormoza)
			MouseClick("left", $minx, $miny, 2)
		WEnd
		Return 1
	EndIf
	Return 0
EndFunc

Func vvodzifr($skolko)
	If read_ini(5) = 1 Then Return vvodzifr2($skolko)
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
	$error = 0
	While StringInStr($skolko, "0") <> 0
		$skolko = $skolko - 1
		$i = $i + 1
	WEnd
	If $i = 0 Then
		MouseMove($polezifrx, $polezifry, 10 * $tormoza)
		MouseClick("left", $polezifrx, $polezifry, 2)
		Sleep(300 * $tormoza)
		Send($skolko)
		Sleep(1000 * $tormoza)
		If haveimagearea($skolkokartinka, 20, $zifri_area[0], $zifri_area[1], $zifri_area[2], $zifri_area[3]) = 1 Then
			Return 1
		EndIf
	Else
		$i = $i + 5
		MouseMove($polezifrx, $polezifry, 10 * $tormoza)
		MouseClick("left", $polezifrx, $polezifry, 2)
		Sleep(300 * $tormoza)
		Send($skolko)
		Sleep(1000 * $tormoza)
		While (haveimagearea($skolkokartinka, 20, $zifri_area[0], $zifri_area[1], $zifri_area[2], $zifri_area[3]) <> 1) AND ($i > 0)
			MouseMove($strelkax, $strelkay, 10 * $tormoza)
			MouseClick("left", $strelkax, $strelkay, 1)
			Sleep(2000 * $tormoza)
			MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
			MouseClick("left", $strelkax, $strelkay - 15, 1)
			$i = $i - 1
		WEnd
		If haveimagearea($skolkokartinka, 20, $zifri_area[0], $zifri_area[1], $zifri_area[2], $zifri_area[3]) = 1 Then
			Return 1
		EndIf
	EndIf
EndFunc

Func vvodzifr2($skolko)
	Local $i = 0
	Switch $skolko
		Case "1"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300 * $tormoza)
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "2"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300 * $tormoza)
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "3"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300 * $tormoza)
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "4"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300 * $tormoza)
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "5"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "6"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "7"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "8"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "9"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "10"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "11"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "12"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "13"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "14"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "15"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "16"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "17"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "18"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "19"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "20"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "21"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "22"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "23"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "24"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "25"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "26"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "27"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "28"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "29"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "30"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "31"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "32"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "33"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "34"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "35"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "36"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "37"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "38"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "39"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "40"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "41"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "42"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "43"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "44"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "45"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "46"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "47"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "48"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "49"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "50"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "51"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "52"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "53"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "54"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "55"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "56"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "57"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "58"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "59"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "60"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "61"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{1}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "62"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{2}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "63"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{3}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "64"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{4}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "65"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{5}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "66"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{6}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "67"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{7}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "68"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{8}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "69"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "70"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "71"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "72"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "73"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "74"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "75"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "76"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "77"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "78"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "79"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "80"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "81"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "82"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "83"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "84"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "85"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "86"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "87"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "88"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "89"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "90"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "91"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "92"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "93"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "94"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "95"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "96"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "97"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "98"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "99"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "100"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "101"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "102"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "103"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "104"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "105"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "106"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "107"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "108"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 11)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "109"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 15)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "110"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 15)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "111"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "112"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "113"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "114"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "115"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "116"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "117"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "118"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "119"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "120"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "121"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "122"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "123"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "124"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "125"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "126"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "127"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "128"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "129"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "130"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "131"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "132"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "133"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "134"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "135"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "136"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "137"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "138"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "139"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "140"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "141"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "142"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "143"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "144"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "145"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "146"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "147"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "148"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "149"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "150"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "151"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "152"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "153"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "154"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "155"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "156"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "157"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "158"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "159"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "160"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "161"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "162"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "163"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "164"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "165"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "166"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "167"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "168"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "169"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "170"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{6}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "171"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "172"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "173"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "174"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "175"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "176"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "177"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "178"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "179"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "180"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "181"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "182"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "183"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "184"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "185"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "186"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "187"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "188"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "189"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "190"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "191"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "192"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "193"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "194"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "195"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "196"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "197"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "198"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "199"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "200"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "201"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "202"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "203"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "204"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "205"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "206"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "207"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "208"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "209"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "210"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{1}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 12)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "211"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "212"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "213"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "214"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "215"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "216"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "217"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "218"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "219"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "220"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "221"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "222"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "223"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "224"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "225"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "226"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "227"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "228"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "229"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "230"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{2}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "231"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "232"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "233"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "234"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "235"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "236"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "237"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "238"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "239"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "240"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{3}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "241"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "242"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "243"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "244"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "245"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "246"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "247"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "248"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "249"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "250"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "251"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "252"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "253"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "254"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "255"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "256"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "257"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "258"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "259"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "260"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{5}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "261"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "262"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "263"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "264"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "265"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "266"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "267"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "268"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "269"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "270"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{6}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "271"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "272"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "273"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "274"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "275"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "276"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "277"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "278"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "279"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "280"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{7}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "281"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "282"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "283"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "284"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "285"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "286"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "287"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "288"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "289"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "290"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{8}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "291"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{1}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "292"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{2}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "293"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{3}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "294"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{4}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "295"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "296"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{6}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "297"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{7}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "298"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{8}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "299"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "300"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{2}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "350"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "400"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{3}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "425"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{2}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "450"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "500"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{4}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "550"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "600"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{5}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "650"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "700"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "620"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{6}")
			Send("{1}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "725"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{2}")
			Send("{5}")
			Sleep(1000 * $tormoza)
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "750"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "800"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{7}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "850"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{4")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "900"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{8}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "950"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{4}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
		Case "999"
			MouseMove($polezifrx, $polezifry, 10 * $tormoza)
			MouseClick("left", $polezifrx, $polezifry, 2)
			Sleep(300)
			Send("{9}")
			Send("{9}")
			Send("{9}")
			Sleep(1000 * $tormoza)
			$i = 0
			While (haveimage($skolkokartinka, 20) <> 1) AND ($i < 10)
				MouseMove($strelkax, $strelkay, 10 * $tormoza)
				MouseClick("left", $strelkax, $strelkay, 1)
				Sleep(2000 * $tormoza)
				MouseMove($strelkax, $strelkay - 15, 1 * $tormoza)
				MouseClick("left", $strelkax, $strelkay - 15, 1)
				$i = $i + 1
			WEnd
			If haveimage($skolkokartinka, 20) = 1 Then
				Return 1
			EndIf
	EndSwitch
EndFunc

Func okclosegena($yes)
	writelog("==OKG | ")
	Local $ty = 0, $tx = 0, $search = 0, $i = 0
	$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
	If $search = 0 Then
		writelog(" Генерал закрыт ")
		Return 1
	Else
		$i = 0
		$search = 0
		zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		While ($i < 6 * $tormoza) AND ($search = 0)
			Sleep(1000 * $tormoza)
			$i = $i + 1
			sleepwhile("media\army_values\nub_gena.bmp", 20, 10)
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
		WEnd
		If $i < 6 Then
			If $yes = 0 Then
				$gluksnaboromarmii = $gluksnaboromarmii + 1
				Return 1
			EndIf
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
			writelog(" Успешно ")
			Return 1
		Else
			zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
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
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 24
				$maxx = $tx + 84
				$maxy = $ty + 24
				$minx = $tx + 6
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "menti"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 24
				$maxx = $tx + 333
				$maxy = $ty + 24
				$minx = $tx + 257
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "luki"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 24
				$maxx = $tx + 208
				$maxy = $ty + 24
				$minx = $tx + 130
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "dluki"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 78
				$maxx = $tx + 208
				$maxy = $ty + 78
				$minx = $tx + 130
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "koni"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 78
				$maxx = $tx + 84
				$maxy = $ty + 78
				$minx = $tx + 6
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "soldati"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 78
				$maxx = $tx + 333
				$maxy = $ty + 78
				$minx = $tx + 257
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "elita"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 132
				$maxx = $tx + 208
				$maxy = $ty + 132
				$minx = $tx + 130
				$miny = $ty + 132
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "arbi"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 132
				$maxx = $tx + 84
				$maxy = $ty + 132
				$minx = $tx + 6
				$miny = $ty + 132
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "puhi"
			$search = _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 132
				$maxx = $tx + 333
				$maxy = $ty + 132
				$minx = $tx + 257
				$miny = $ty + 132
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
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
			sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 20)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func generali($general, $nomergenerala)
	Sleep(1000 * $tormoza)
	Local $ty = 0, $tx = 0, $search = 0, $i = 0, $t = 0, $ii = 0
	Local $general1x = 0, $general1y = 0, $general2x = 0, $general2y = 0
	
	;If _imagesearch($general, 1, $tx, $ty, 20) = 0 Then Return 0
	While 1
		If _imagesearcharea($general, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
		
		$ii = $ii + 1
		zvezdamovepolzunokdown(0)
		zvezdamovepolzunokdown(0)

		Sleep(Random(500, 1000, 1) * $tormoza)
		If $ii > 5 Then
			If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 70, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 0 Then
				Return 1
			EndIf
		EndIf
	WEnd

	If $nomergenerala = 1 Then
		While $i < 10
			MouseMove($tx, $ty, 10 * $tormoza)
			Sleep(500 * $tormoza)
			MouseClick("left", $tx + Random(1, 2, 1) - 2, $ty + Random(1, 2, 1) - 2, 1)
			go5()
			sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
			If haveimage("media\army_values\zadacha_geni.bmp", 30) = 1 Then Return 1
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
					sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
					If haveimage("media\army_values\zadacha_geni.bmp", 30) = 1 Then Return 1
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
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
				If haveimage("media\army_values\zadacha_geni.bmp", 30) = 1 Then Return 1
			EndIf
		ElseIf _imagesearcharea($general, 1, 0, $ty, @DesktopWidth, @DesktopHeight, $tx, $ty, 20) = 1 Then
			$general2x = $tx
			$general2y = $ty
			If $i = $nomergenerala Then
				MouseMove($general2x, $general2y, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $general2x + Random(1, 2, 1) - 2, $general2y + Random(1, 2, 1) - 2, 1)
				go5()
				sleepwhile("media\army_values\zadacha_geni.bmp", 30, 10)
				If haveimage("media\army_values\zadacha_geni.bmp", 30) = 1 Then Return 1
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
			If findclickoncenterandwaitresult($kartinka, "media\army_values\open_prikla2.bmp", 20, 20, 5, 5, 1, 300, 5) = 1 Then
				zmemsmennuyukartinku("media\army_values\open_prikla2.bmp", 30, "media\army_values\open_prikla2_.bmp", 30)
				Sleep(2000 * $tormoza)
				zmemsmennuyukartinku("media\army_values\open_prikla2.bmp", 30, "media\army_values\open_prikla2_.bmp", 30)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func openotpravkagen($kartinka)
	WinActivate("The Settlers Онлайн")
	writelog("=====ОТПРАВКА ГЕНЕРАЛОВ " & $kartinka & @CRLF)
	Local $search = 0, $i = 0, $tx = 0, $ty = 0
	If findclickoncenterandwaitresult($kartinka, "media\army_values\otpravit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\army_values\otpravit.bmp", "media\army_values\otpravka_no.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			Sleep(2000 * $tormoza)
			sleepwhile("media\army_values\otppravka_vniz.bmp", 100, 5)
			If _imagesearcharea("media\army_values\otpravka_no.bmp", 1, 500, 100, @DesktopWidth - 200, @DesktopHeight, $tx, $ty, 40) = 0 Then Return 0
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
			$area5_top_x = $tx - 305
			$area5_top_y = $ty - 144
			$area5_bottom_x = $tx - 46
			$area5_bottom_y = $ty - 80
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
	If findclickoncenterandwaitresult($kartinka, "media\army_values\posetit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\army_values\posetit.bmp", "media\army_values\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\army_values\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
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
	If findclickoncenterandwaitresult($kartinka, "media\army_values\posetit.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\army_values\posetit.bmp", "media\army_values\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\army_values\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
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
	If findclickoncenterandwaitresult($kartinka, "media\army_values\gotohome.bmp", 20, 50, 2, 5, 1, -300, -100) = 1 Then
		If findclickoncenterandwaitresult("media\army_values\gotohome.bmp", "media\army_values\perehod_v_zonu.bmp", 50, 20, 2, 5, 1, 0, -100) = 1 Then
			While (_imagesearch("media\army_values\perehod_v_zonu.bmp", 1, $tx, $ty, 20) = 1) AND ($i < 100)
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
	zmemsmennuyukartinkuizdem("media\pismo.bmp", 30, "media\pismo_.bmp", 30, "media\army_values\KNZOK.bmp", 30)
	If findclickoncenterandwaitnoneresult("media\army_values\KNZOK.bmp", 20, 10, 10, 100, 10) = 1 Then
		Sleep(1000 * $tormoza)
		zmemsmennuyukartinku("media\army_values\KNZOK.bmp", 30, "media\army_values\KNZOK_.bmp", 30)
		While haveimage("media\army_values\go_home.bmp", 50) = 0
			Sleep(1000 * $tormoza)
		WEnd
		If findclickoncenterandwaitresult("media\army_values\go_home.bmp", "media\army_values\perehod_v_zonu.bmp", 50, 20, 2, 60, 0, 200, 2) = 1 Then
			While haveimage("media\army_values\perehod_v_zonu.bmp", 50) = 1
				Sleep(1000 * $tormoza)
			WEnd
			writelog("=====УСПЕХ " & @CRLF)
			Return 1
		EndIf
	EndIf
	writelog("=====ОШИБКА " & @CRLF)
	Return 0
EndFunc

Func ozidanierasstanovki($image, $yes)
	writelog("=====ОЖИДАЕМ ПЕРЕСТАНОВКУ " & $yes & @CRLF)
	Local $tx = 0, $ty = 0, $i = 0
	Sleep(500 * $tormoza)
	If openzvezdap() = 1 Then
		selecttabatzvezda("specialisti", 1)
		While (_imagesearcharea($image, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 20) = 1) AND ($i < 300)
			Sleep(3000 * $tormoza)
			If $i = 20 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 40 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 60 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 80 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 100 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 120 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 140 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 160 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 180 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 200 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 220 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 240 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			$i = $i + 1
		WEnd
		If $yes = 1 Then
			zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		EndIf
		If $i = 300 Then
			writelog("=====ОШИБКА " & $i & @CRLF)
			Return 0
		EndIf
		writelog("=====УСПЕХ " & $i & @CRLF)
		Return 1
	EndIf
	writelog("=====ОШИБКА " & $i & @CRLF)
	Return 0
EndFunc

Func ozidanierasstanovki2($image, $yes)
	writelog("=====ОЖИДАЕМ ПЕРЕСТАНОВКу " & $yes & @CRLF)
	Local $tx = 0, $ty = 0, $i = 0
	Sleep(500 * $tormoza)
	If openzvezdap() = 1 Then
		selecttabatzvezda("specialisti", 1)
		While (_imagesearcharea($image, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 20) = 0) AND ($i < 300)
			Sleep(3000 * $tormoza)
			If $i = 20 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 40 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 60 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 80 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 100 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 120 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 140 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 160 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 180 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 200 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 220 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			If $i = 240 Then
				zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
				If openzvezdap() = 0 Then
					Return 0
				EndIf
				Sleep(500 * $tormoza)
			EndIf
			$i = $i + 1
		WEnd
		If $yes = 1 Then
			zmemsmennuyukartinku("media\close-zv.bmp", 90, "media\close-zv_.bmp", 90)
		EndIf
		If $i = 300 Then
			writelog("=====ОШИБКА " & $i & @CRLF)
			Return 0
		EndIf
		writelog("=====УСПЕХ " & $i & @CRLF)
		Return 1
	EndIf
	writelog("=====ОШИБКА " & $i & @CRLF)
	Return 0
EndFunc

Func vibor_elitnoy_armii($tabname)
	writelog("| VA " & $tabname)
	Local $ty = 0, $tx = 0, $search = 0, $ay = 0, $ax = 0
	Switch $tabname
		Case "mechniki"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 24
				$maxx = $tx + 84
				$maxy = $ty + 24
				$minx = $tx + 6
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "rizari"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 24
				$maxx = $tx + 333
				$maxy = $ty + 24
				$minx = $tx + 257
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "km"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 24
				$maxx = $tx + 208
				$maxy = $ty + 24
				$minx = $tx + 130
				$miny = $ty + 24
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "sb"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 220
				$strelkay = $ty + 78
				$maxx = $tx + 208
				$maxy = $ty + 78
				$minx = $tx + 130
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "strelki"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 78
				$maxx = $tx + 84
				$maxy = $ty + 78
				$minx = $tx + 6
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "ks"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 347
				$strelkay = $ty + 78
				$maxx = $tx + 333
				$maxy = $ty + 78
				$minx = $tx + 257
				$miny = $ty + 78
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
				$polezifrx = $ax + 25
				$polezifry = $ay
				Return 1
			Else
				Return 0
			EndIf
		Case "mo"
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			If $search = 1 Then
				$strelkax = $tx + 96
				$strelkay = $ty + 132
				$maxx = $tx + 84
				$maxy = $ty + 132
				$minx = $tx + 6
				$miny = $ty + 132
				_imagesearcharea("media\army_values\delimetr.bmp", 1, $strelkax - 100, $strelkay - 40, $strelkax, $strelkay, $ax, $ay, 40)
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
	$search = _imagesearch("media\army_values\0.bmp", 1, $tx, $ty, 20)
	go5()
	If $mo = 0 AND $ks = 0 AND $strelki = 0 AND $sb = 0 AND $km = 0 AND $rizari = 0 AND $mechniki = 0 AND $search = 1 Then
		If $yes = 0 Then
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			Return 1
		EndIf
		$gluksnaboromarmii = $gluksnaboromarmii + 1
		zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
		Return 1
	EndIf
	zmemsmennuyukartinku("media\army_values\sbros.bmp", 50, "media\army_values\sbros_.bmp", 50)
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
	writelog("| SEA " & $kogo & "," & $skolko & "," & $gena & " | ")
	If $skolko = 0 Then
		writelog("0" & @CRLF)
		Return 1
	EndIf

	$fullGenaImg = getFullGeneralImg($gena)

	If $skolko = 1000 Then
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
			$i = 0
			$search = 0
			writelog("Успех " & $i & @CRLF)
			Return 1
			If findclickoncenterandwaitresult1("media\search_button_OK_enabled.bmp", "media\army_values\zdem.bmp", 30, 20, 3, 5, 1, -100, 1) = 1 Then
				While ($i < 30 * $tormoza) AND ($search = 0)
					Sleep(1000 * $tormoza)
					$i = $i + 1
					$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
				WEnd
				If $i < 20 Then
					Return 1
				EndIf
			Else
				TrayTip("", "Ошибка: Не нажали Ок", 0)
				Return 0
			EndIf
		Else
			writelog("Ошибка " & $i & @CRLF)
			TrayTip("", "Ошибка: Не набрали войска", 0)
			Return 0
		EndIf
	Else
		vibor_elitnoy_armii($kogo)
		$skolkokartinka = "media\army_values\" & $diffarmy & ".bmp"
		writelog("+" & $skolko)
		While vvodzifr($skolko) <> 1
			writelog("+" & $skolko)
			MouseMove($minx, $miny, 10 * $tormoza)
			MouseClick("left", $minx, $miny, 2)
		WEnd
		writelog(" Успех " & $diffarmy & @CRLF)
		Return 1
	EndIf
	writelog("Ошибка " & @CRLF)
	Return 0
EndFunc

Func okclose_elitnoy_gena($yes)
	Local $ty = 0, $tx = 0, $search = 0, $i = 0
	writelog("==OKEG | ")
	$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
	If $search = 0 Then
		writelog(" Генерал закрыт ")
		Return 1
	Else
		$i = 0
		$search = 0
		zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
		While ($i < 6 * $tormoza) AND ($search = 0)
			Sleep(1000 * $tormoza)
			$i = $i + 1
			sleepwhile("media\army_values\mechnik.bmp", 20, 10)
			$search = _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
		WEnd
		If $i < 6 Then
			If $yes = 0 Then
				$gluksnaboromarmii = $gluksnaboromarmii + 1
				Return 1
			EndIf
			$gluksnaboromarmii = $gluksnaboromarmii + 1
			zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
			writelog(" Успешно ")
			Return 1
		Else
			zmemsmennuyukartinku("media\army_values\closegena.bmp", 30, "media\army_values\closegena_.bmp", 30)
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
		If _imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20) = 1 Then
			writelog("уже назначена" & @CRLF)
			Return 1
		Else
			zmemsmennuyukartinku("media\army_values\zamena_boicov.bmp", 50, "media\army_values\zamena_boicov_.bmp", 50)
			$i = 0
			While (_imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20) <> 1) AND ($i < 30)
				Sleep(2000 * $tormoza)
				$i = $i + 1
			WEnd
			If $i < 29 Then Return 1
		EndIf
	Else
		writelog("Простая армия ")
		If _imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20) = 1 Then
			writelog("уже назначена" & @CRLF)
			Return 1
		Else
			zmemsmennuyukartinku("media\army_values\zamena_boicov.bmp", 50, "media\army_values\zamena_boicov_.bmp", 50)
			$i = 0
			While (_imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20) <> 1) AND ($i < 30)
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
	If haveimage("media\army_values\" & $kartinka2, 30) = 1 Then
		Return 1
	EndIf
	If openzvezda() = 1 Then
		If selecttabatzvezda("prikli", 0) = 1 Then
			While (_imagesearch("media\army_values\" & $kartinka, 1, $tx, $ty, 20) = 0)
				zvezdamovepolzunokdown(1)
				Sleep(300 * $tormoza)
			WEnd
			If findclickoncenterandwaitresult("media\army_values\" & $kartinka, "media\army_values\open_prikla2.bmp", 20, 20, 5, 5, 1, 300, 5) = 1 Then
				zmemsmennuyukartinku("media\army_values\open_prikla2.bmp", 30, "media\army_values\open_prikla2_.bmp", 30)
				Sleep(2000 * $tormoza)
				zmemsmennuyukartinku("media\army_values\open_prikla2.bmp", 30, "media\army_values\open_prikla2_.bmp", 30)
				Return 1
			EndIf
		EndIf
	EndIf
	Return 0
EndFunc

Func sborostatkovarmii($army_type)
	Local $tx = 0, $ty = 0
	If $army_type = 1 Then
		If smena_armii($army_type) = 1 Then
			_imagesearch("media\army_values\mechnik.bmp", 1, $tx, $ty, 20)
			MouseClick("left", $tx + 83, $ty + 24, 1)
			MouseClick("left", $tx + 83, $ty + 78, 1)
			MouseClick("left", $tx + 83, $ty + 131, 1)
			MouseClick("left", $tx + 208, $ty + 24, 1)
			MouseClick("left", $tx + 208, $ty + 78, 1)
			MouseClick("left", $tx + 332, $ty + 24, 1)
			MouseClick("left", $tx + 332, $ty + 78, 1)
			Sleep(500 * $tormoza)
			Return okclose_elitnoy_gena(1)
		EndIf
	ElseIf $army_type = 0 Then
		If smena_armii($army_type) = 1 Then
			_imagesearch("media\army_values\nub_gena.bmp", 1, $tx, $ty, 20)
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
			Return okclosegena(1)
		EndIf
	Else
		Return 0
	EndIf
EndFunc

Func otpravkagenvprikl($prikl, $gena, $shtuk, $imya)
	Local $tx = 0, $ty = 0, $i = 0, $generalov = 0, $ax = 0, $ay = 0, $search = 0, $error_otpravka = 0
	chatoff()
	drugioff()
	While 1
		If openotpravkagen("media\army_values\" & $prikl) = 1 Then
			While ($generalov <> $shtuk) AND ($i < (read_ini(4) / 2))
				If haveimagearea("media\error_otpravka.bmp", 40, $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y) = 1 Then
					$error_otpravka = $error_otpravka + 1
					If $error_otpravka = 5 Then ExitLoop
				EndIf
				If _imagesearcharea($gena, 1, $area1_top_x, $area1_top_y, $area1_bottom_x, $area1_bottom_y, $tx, $ty, 20) = 1 Then
					If _imagesearcharea("media\army_values\Gena_plus.bmp", 1, $area1_top_x, $area1_top_y, $area1_bottom_x, $area1_bottom_y, $tx, $ty, 20) = 1 Then
						While _imagesearcharea("media\army_values\Gena_plus_yes.bmp", 1, $area1_top_x, $area1_top_y, $area1_bottom_x, $area1_bottom_y, $ax, $ay, 20) <> 1
							If haveimagearea("media\error_otpravka.bmp", 40, $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y) = 1 Then
								$error_otpravka = $error_otpravka + 1
								If $error_otpravka = 5 Then ExitLoop 2
							EndIf
							If $imya = "-" Then
								MouseMove($tx, $ty, 10 * $tormoza)
								Sleep(100 * $tormoza)
								MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
								Sleep(100 * $tormoza)
								removemouse(300, 0, 300)
							Else
								If skolko_voisk_v_gene($imya, $area1_top_x, $area1_top_y, $area1_bottom_x, $area1_bottom_y) = 0 Then
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
					EndIf
				EndIf
				If $generalov = $shtuk Then ExitLoop
				If _imagesearcharea($gena, 1, $area2_top_x, $area2_top_y, $area2_bottom_x, $area2_bottom_y, $tx, $ty, 20) = 1 Then
					If _imagesearcharea("media\army_values\Gena_plus.bmp", 1, $area2_top_x, $area2_top_y, $area2_bottom_x, $area2_bottom_y, $tx, $ty, 20) = 1 Then
						While _imagesearcharea("media\army_values\Gena_plus_yes.bmp", 1, $area2_top_x, $area2_top_y, $area2_bottom_x, $area2_bottom_y, $ax, $ay, 20) <> 1
							If haveimagearea("media\error_otpravka.bmp", 40, $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y) = 1 Then
								$error_otpravka = $error_otpravka + 1
								If $error_otpravka = 5 Then ExitLoop 2
							EndIf
							If $imya = "-" Then
								MouseMove($tx, $ty, 10 * $tormoza)
								Sleep(100 * $tormoza)
								MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
								Sleep(100 * $tormoza)
								removemouse(300, 0, 300)
							Else
								If skolko_voisk_v_gene($imya, $area2_top_x, $area2_top_y, $area2_bottom_x, $area2_bottom_y) = 0 Then
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
					EndIf
				EndIf
				If $generalov = $shtuk Then ExitLoop
				If _imagesearcharea($gena, 1, $area3_top_x, $area3_top_y, $area3_bottom_x, $area3_bottom_y, $tx, $ty, 20) = 1 Then
					If _imagesearcharea("media\army_values\Gena_plus.bmp", 1, $area3_top_x, $area3_top_y, $area3_bottom_x, $area3_bottom_y, $tx, $ty, 20) = 1 Then
						While _imagesearcharea("media\army_values\Gena_plus_yes.bmp", 1, $area3_top_x, $area3_top_y, $area3_bottom_x, $area3_bottom_y, $ax, $ay, 20) <> 1
							If haveimagearea("media\error_otpravka.bmp", 40, $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y) = 1 Then
								$error_otpravka = $error_otpravka + 1
								If $error_otpravka = 5 Then ExitLoop 2
							EndIf
							If $imya = "-" Then
								MouseMove($tx, $ty, 10 * $tormoza)
								Sleep(100 * $tormoza)
								MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
								Sleep(100 * $tormoza)
								removemouse(300, 0, 300)
							Else
								If skolko_voisk_v_gene($imya, $area3_top_x, $area3_top_y, $area3_bottom_x, $area3_bottom_y) = 0 Then
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
						$generalov = $generalov + 1
						go5()
					EndIf
				EndIf
				If $generalov = $shtuk Then ExitLoop
				If _imagesearcharea($gena, 1, $area4_top_x, $area4_top_y, $area4_bottom_x, $area4_bottom_y, $tx, $ty, 20) = 1 Then
					If _imagesearcharea("media\army_values\Gena_plus.bmp", 1, $area4_top_x, $area4_top_y, $area4_bottom_x, $area4_bottom_y, $tx, $ty, 20) = 1 Then
						While _imagesearcharea("media\army_values\Gena_plus_yes.bmp", 1, $area4_top_x, $area4_top_y, $area4_bottom_x, $area4_bottom_y, $ax, $ay, 20) <> 1
							If haveimagearea("media\error_otpravka.bmp", 40, $area5_top_x, $area5_top_y, $area5_bottom_x, $area5_bottom_y) = 1 Then
								$error_otpravka = $error_otpravka + 1
								If $error_otpravka = 5 Then ExitLoop 2
							EndIf
							If $imya = "-" Then
								MouseMove($tx, $ty, 10 * $tormoza)
								Sleep(100 * $tormoza)
								MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
								Sleep(100 * $tormoza)
								removemouse(300, 0, 300)
							Else
								If skolko_voisk_v_gene($imya, $area4_top_x, $area4_top_y, $area4_bottom_x, $area4_bottom_y) = 0 Then
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
						$generalov = $generalov + 1
						go5()
					EndIf
				EndIf
				If $generalov = $shtuk Then ExitLoop
				$search = _imagesearcharea("media\army_values\otppravka_vniz.bmp", 1, 500, 100, @DesktopWidth - 200, @DesktopHeight, $tx, $ty, 90)
				MouseMove($tx, $ty, 10 * $tormoza)
				Sleep(100 * $tormoza)
				MouseClick("left", $tx + Random(0, 2, 1), $ty + Random(0, 2, 1), 1)
				Sleep(500 * $tormoza)
				removemouse(300, 0, 300)
				$i = $i + 1
			WEnd
			If $generalov = $shtuk Then
				zmemsmennuyukartinku("media\army_values\otpravka_ok.bmp", 30, "media\army_values\otpravka_ok_.bmp", 30)
				Return 1
			EndIf
			zmemsmennuyukartinku("media\army_values\closegena.bmp", 90, "media\army_values\closegena_.bmp", 90)
			$generalov = 0
			$error_otpravka = 0
			$i = 0
		EndIf
	WEnd
EndFunc

Func skolko_voisk_v_gene($imya, $area_top_x, $area_top_y, $area_bottom_x, $area_bottom_y)
	Sleep(1000 * $tormoza)
	Local $i = 0, $tx, $ty, $current_nik1_x, $current_nik1_y, $error = 0, $nik_symbol
	If _imagesearcharea("media\army_values\text\X.bmp", 1, $area_top_x, $area_top_y, $area_bottom_x, $area_bottom_y, $tx, $ty, 40) = 0 Then
		Return 0
	EndIf
	If $imya = "+" Then
		MouseMove($tx, $ty, 10 * $tormoza)
		Sleep(100 * $tormoza)
		Sleep(900 * $tormoza)
		If (haveimage("media\army_values\otpravkingena2.bmp", read_ini(2)) = 0) AND (haveimage("media\army_values\otpravkingena.bmp", read_ini(2)) = 0) Then
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
		If (_imagesearcharea("media\army_values\text\" & $nik_symbol & ".bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) OR (_imagesearcharea("media\army_values\text\" & $nik_symbol & "_.bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) OR (_imagesearcharea("media\army_values\text\" & $nik_symbol & "__.bmp", 1, $current_nik1_x - 1, $current_nik1_y, $current_nik1_x + 15, $current_nik1_y + 25, $tx, $ty, 10) = 1) Then
			$i = $i + 1
			$current_nik1_x = $tx
		Else
			$error = $error + 1
			$i = $i + 1
			$current_nik1_x = $current_nik1_x + 7
			If $error = 1 Then $i = 1000
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
   Local $vidgeologov[10] = ["media\vesel_geolog.bmp", "media\geolog.bmp", "media\x2geolog.bmp", "media\zelezny_geolog.bmp", "media\kamen_geolog.bmp", $dr & "byvalyj_geolog.bmp", $dr & "zolotoj_geolog.bmp", $dr & "arheolog_geolog.bmp", $dr & "prelestnyj_geolog.bmp", $dr & "skrupuleznyj_geolog.bmp"]
   WinActivate("The Settlers Онлайн")
   chatoff()
   drugioff()
   If openzvezda() = 0 Then Return 0
   If selecttabatzvezda("specialisti", 0) = 0 Then Return 0
   If $kakih == 0 Then
		While $i < $skolko
			If openzvezda() = 1 Then
				If selecttabatzvezda("specialisti", 1) = 1 Then
					While 1
						If _imagesearcharea($vidgeologov[0], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[1], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[2], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[3], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[4], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[5], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[6], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[7], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[8], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
						If _imagesearcharea($vidgeologov[9], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
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
		WinActivate("The Settlers Онлайн")
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

Func runrazved($tetki, $arti, $vidpoiska, $tippoiska, $kakih)
	Local $vidrazvedov[14] = ["media\scout1.bmp", "media\scout2.bmp", "media\scout3.bmp", "media\scout4.bmp", "media\scout5.bmp", "media\scout6.bmp", $dr & "avantyurist.bmp", $dr & "zoi.bmp", $dr & "iskrennij.bmp", $dr & "skromnyj.bmp", $dr & "zacharovannyj.bmp", $dr & "milyj.bmp", $dr & "nastojchivyj.bmp", $dr & "bezuderzhnyj.bmp"]
	Local $seychactetka = 0
	Local $i = 0, $ii = 0, $tx, $ty
	WinActivate("The Settlers Онлайн")
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
	If $kakih == 0 Then
		While 1
			If openzvezda() = 1 Then
				While 1
					If _imagesearcharea($vidrazvedov[0], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[1], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[2], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[3], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[4], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[5], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[7], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[8], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[9], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[10], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[11], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[12], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
					If _imagesearcharea($vidrazvedov[13], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then ExitLoop
				    If _imagesearcharea($vidrazvedov[6], 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then
						If $tetki = 1 Then $seychactetka = 1
						ExitLoop
					EndIf
					$ii = $ii + 1
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					Sleep(Random(500, 1000, 1) * $tormoza)
					If $ii > 5 Then
						If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 70, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 0 Then
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
				If $seychactetka = 1 Then
					zmemsmennuyukartinku("media\poisk_prikla.bmp", 30, "media\poisk_prikla.bmp_", 30)
					go5()
					$seychactetka = 0
					If $kartinkatippoiska = "media\search_treasure_super_long.bmp" Then
						zmemsmennuyukartinkuizdem("media\search_treasure_very_long.bmp", 30, "media\search_treasure_very_long_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
						zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
					EndIf
				Else
					zmemsmennuyukartinku($kartinkavidpoiska, 30, $kartinkavidpoiska2, 30)
					go5()
					removemouse(500, 0, 500)
					zmemsmennuyukartinkuizdem($kartinkatippoiska, 30, $kartinkatippoiska2, 30, "media\search_button_OK_enabled.bmp", 20)
					If $arti = 1 Then zmemsmennuyukartinkuizdem("media\search_artifact.bmp", 30, "media\search_artifact_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
					zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
				EndIf
			EndIf
		WEnd
	Else
		While 1
			If openzvezda() = 1 Then
				While 1
					If _imagesearcharea($kakih, 1, $zvezda_area[0], $zvezda_area[1], $zvezda_area[2], $zvezda_area[3], $tx, $ty, 30) = 1 Then
						If $kakih = "media\scout6.bmp" Then
							If $tetki = 1 Then $seychactetka = 1
						EndIf
						ExitLoop
					EndIf
					$ii = $ii + 1
					zvezdamovepolzunokdown(0)
					zvezdamovepolzunokdown(0)
					Sleep(Random(500, 1000, 1) * $tormoza)
					If $ii > 5 Then
						If haveimagearea("media\zvezda_polzunok_ewe_mojno_vniz.bmp", 70, $zvezda_area[0] + 385, $zvezda_area[1] + 200, $zvezda_area[2] + 25, $zvezda_area[3] + 25) = 0 Then
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
				If $seychactetka = 1 Then
					zmemsmennuyukartinku("media\poisk_prikla.bmp", 30, "media\poisk_prikla.bmp_", 30)
					go5()
					$seychactetka = 0
					If $kartinkatippoiska = "media\search_treasure_super_long.bmp" Then
						zmemsmennuyukartinkuizdem("media\search_treasure_very_long.bmp", 30, "media\search_treasure_very_long_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
						zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
					EndIf
				Else
					zmemsmennuyukartinku($kartinkavidpoiska, 30, $kartinkavidpoiska2, 30)
					go5()
					zmemsmennuyukartinkuizdem($kartinkatippoiska, 30, $kartinkatippoiska2, 30, "media\search_button_OK_enabled.bmp", 20)
					If $arti = 1 Then zmemsmennuyukartinkuizdem("media\search_artifact.bmp", 30, "media\search_artifact_.bmp", 30, "media\search_button_OK_enabled.bmp", 20)
					zmemsmennuyukartinku("media\search_button_OK_enabled.bmp", 20, "media\search_button_OK_enabled_.bmp", 20)
				EndIf
			EndIf
		WEnd
	EndIf
 EndFunc