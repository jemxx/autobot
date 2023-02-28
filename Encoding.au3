#include-once

#CS Header
	# UDF Info # ==================================================================================================
	AutoIt.........:  3.3.0.0 +
	UDF Version....:  1.7
	Name...........:  Encoding.au3
	Description....:  Collection of functions that used to work with different string encoding.
	
	Author(s)......:  (Mr)CreatoR, amel27, LEX1, trancexx, Ward, Latoid, LazyCat (Loopback)
	Remarks........:
	Related........:
	Link...........:
	Example........:	Yes. See the attached examples.
	
	Version History:
	                 [v1.7], 19.03.2016
	                  * _Encoding_RemoteEncode renamed to _Encoding_PhpEncode, since it's used a small local php server.
					  - Removed $bUnicode parameter from _Encoding_PhpEncode function.
					 
					 [v1.6], 15.03.2016
	                  + Added UDFs headers with detailed documentation.
					  + Added _Encoding_RemoteEncode function (Remotly encode/decode string using php functions).
					  * Code optimized.
					 
					 [v1.5], 24.09.2012
	                  * UDF encoding changed back to code page (ANSI), it was causing problems with syntax checking utility.
	                  * _Encoding_HexSymbolsToANSI renamed to _Encoding_QuotedPrintableToANSI. _Encoding_HexSymbolsToANSI still supported (depracated).
	
	                 [v1.4], 26.01.2011
	                  * Updated/Fixed _Encoding_Base64* functions.
	
	                 [v1.3], 20.07.2010
	                  * Fixed _Encoding_Base64Decode function, wrong return on non-ANSI characters.
	
	                 [v1.2], 20.05.2010
	                  + Added _Encoding_ISO8859To1251 function.
	
	                 [v1.1], 25.01.2010
	                  * Global functions renaming, instead of "_String" prefix now used "_Encoding_" prefix.
	                  * Fixed _StringIsUTF8Format (_Encoding_IsUTF8Format),
	                    and added parameter $iCheckASCIICode (default is False) to check the special ASCII symbols (Char < 128).
	                  + Added 7 more functions:
	                      1) _Encoding_CyrillicTo1251 - Converts cyrillic string of any encoding to Microsoft 1251 codepage.
	                      2) _Encoding_HexSymbolsToANSI - Converts HEX symbols in string (Ex.: "=D2=C1=C2=CF") to ANSI symbols.
	                      3) _Encoding_GetCyrillicANSIEncoding - Finds out the ANSI encoding of cyrillic string.
	                           Needs at least 3-4 proper Russian words for certain definition.
	                      4) _Encoding_866To1251 - Converts cyrillic string from IBM 866 codepage to Microsoft 1251 codepage.
	                      5) _Encoding_KOI8To1251 - Converts cyrillic string from KOI8-R to Microsoft 1251 codepage.
	                      6) _Encoding_ISO8859To1251 - Converts cyrillic string from ISO-8859-5 to Microsoft 1251 codepage.
	                      7) _Encoding_GetFileEncoding - Gets the encoding type of specified file.
	
	===============================================================================================================

	Functions List:

		_Encoding_866To1251
		_Encoding_ANSIToOEM
		_Encoding_ANSIToUTF8
		_Encoding_Base64Decode
		_Encoding_Base64Encode
		_Encoding_CyrillicTo1251
		_Encoding_GetCyrillicANSIEncoding
		_Encoding_GetFileEncoding
		_Encoding_QuotedPrintableToANSI
		_Encoding_HexToURL
		_Encoding_ISO88591To1251
		_Encoding_ISO8859To1251
		_Encoding_IsUTF8Format
		_Encoding_JavaUnicodeDecode
		_Encoding_JavaUnicodeEncode
		_Encoding_KOI8To1251
		_Encoding_OEM2ANSI
		_Encoding_PhpEncode
		_Encoding_StringToUTF8
		_Encoding_URIDecode
		_Encoding_URIEncode
		_Encoding_URLToHex
		_Encoding_UTF8BOMDecode
		_Encoding_UTF8ToANSI
		_Encoding_UTF8ToANSI_API
		_Encoding_UTF8ToUnicode_API

#CE

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_866To1251
; Description ...: Converts cyrillic string from IBM 866 codepage to Microsoft 1251 codepage.
; Syntax ........: _Encoding_866To1251($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_866To1251($sString)
	Local $sResult = '', $iCode
	Local $aSplit = StringSplit($sString, '')
	
	For $i = 1 To $aSplit[0]
		$iCode = Asc($aSplit[$i])
		
		Switch $iCode
			Case 128 To 175
				$aSplit[$i] = Chr($iCode + 64)
			Case 224 To 239
				$aSplit[$i] = Chr($iCode + 16)
			Case 240
				$aSplit[$i] = Chr(168)
			Case 241
				$aSplit[$i] = Chr(184)
			Case 252
				$aSplit[$i] = Chr(185)
		EndSwitch
		
		$sResult &= $aSplit[$i]
	Next
	
	Return $sResult
EndFunc ;==>_Encoding_866To1251

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_ANSIToOEM
; Description ...: Converts ANSI string to OEM encoded string.
; Syntax ........: _Encoding_ANSIToOEM($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: 	Success: Encoded string.
;					Failure: Empty string and set @error as following:
;															1 - DLL error
;															2 - CharToOem failure
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_ANSIToOEM($sString)
	Local $sBuffer = DllStructCreate('char[' & StringLen($sString) + 1 & ']')
	Local $aRet = DllCall('User32.dll', 'int', 'CharToOem', 'str', $sString, 'ptr', DllStructGetPtr($sBuffer))
	
	If Not IsArray($aRet) Then Return SetError(1, 0, '') ; DLL error
	If $aRet[0] = 0 Then Return SetError(2, $aRet[0], '') ; Function error
	
	Return DllStructGetData($sBuffer, 1)
EndFunc ;==>_Encoding_ANSIToOEM

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_ANSIToUTF8
; Description ...: Converts ANSI string to UTF-8 encoding.
; Syntax ........: _Encoding_ANSIToUTF8($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_ANSIToUTF8($sString)
	Return BinaryToString(StringToBinary($sString, 4))
EndFunc ;==>_Encoding_ANSIToUTF8

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_Base64Decode
; Description ...: Decode string from Base64 data format.
; Syntax ........: _Encoding_Base64Decode($sData)
; Parameters ....: $sData               - String to encode.
; Return values .: 	Success: Encoded string.
;					Failure: Empty string and set @error as following:
;															1 - error calculating the length of the buffer needed
;															2 - error decoding
; Author ........: trancexx
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_Base64Decode($sData)
	Local $struct = DllStructCreate("int")
	
	$a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sData, _
			"int", 0, _
			"int", 1, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	
	If @error Or Not $a_Call[0] Then
		Return SetError(1, 0, "") ; error calculating the length of the buffer needed
	EndIf
	
	Local $a = DllStructCreate("byte[" & DllStructGetData($struct, 1) & "]")
	
	$a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sData, _
			"int", 0, _
			"int", 1, _
			"ptr", DllStructGetPtr($a), _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	
	If @error Or Not $a_Call[0] Then
		Return SetError(2, 0, "") ; error decoding
	EndIf
	
	Return BinaryToString(DllStructGetData($a, 1))
EndFunc ;==>_Encoding_Base64Decode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_Base64Encode
; Description ...: Encode string to Base64 data format.
; Syntax ........: _Encoding_Base64Encode($sData)
; Parameters ....: $sData               - String to encode.
; Return values .: 	Success: Encoded string.
;					Failure: Empty string and set @error as following:
;															1 - error calculating the length of the buffer needed
;															2 - error encoding
; Author ........: trancexx
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_Base64Encode($sData)
	$sData = Binary($sData)
	
	Local $struct = DllStructCreate("byte[" & BinaryLen($sData) & "]")
	
	DllStructSetData($struct, 1, $sData)
	
	Local $strc = DllStructCreate("int")
	
	Local $a_Call = DllCall("Crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($struct), _
			"int", DllStructGetSize($struct), _
			"int", 1, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($strc))
	
	If @error Or Not $a_Call[0] Then
		Return SetError(1, 0, "") ; error calculating the length of the buffer needed
	EndIf
	
	Local $a = DllStructCreate("char[" & DllStructGetData($strc, 1) & "]")
	
	$a_Call = DllCall("Crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($struct), _
			"int", DllStructGetSize($struct), _
			"int", 1, _
			"ptr", DllStructGetPtr($a), _
			"ptr", DllStructGetPtr($strc))
	
	If @error Or Not $a_Call[0] Then
		Return SetError(2, 0, "") ; error encoding
	EndIf
	
	Return BinaryToString(DllStructGetData($a, 1))
EndFunc ;==>_Encoding_Base64Encode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_CyrillicTo1251
; Description ...: Converts cyrillic string of any encoding to Microsoft 1251 codepage.
; Syntax ........: _Encoding_CyrillicTo1251($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_CyrillicTo1251($sString)
	If StringRegExp($sString, '(=[A-Fa-f0-9]{2}=[A-Fa-f0-9]{2})') Then
		$sString = _Encoding_HexSymbolsToANSI($sString)
	EndIf
	
	If _Encoding_IsUTF8Format($sString) Then
		$sString = BinaryToString(StringToBinary($sString), 4)
		
		If Asc(StringLeft($sString, 1)) = 63 Then
			$sString = StringTrimLeft($sString, 1)
		EndIf
	EndIf
	
	Local $sEncoding = _Encoding_GetCyrillicANSIEncoding($sString)
	
	If $sEncoding = 'IBM-866' Then
		Return _Encoding_866To1251($sString)
	ElseIf $sEncoding = 'KOI8-R' Then
		Return _Encoding_KOI8To1251($sString)
	ElseIf $sEncoding = 'ISO-8859-5' Then
		Return _Encoding_ISO8859To1251($sString)
	Else
		Return $sString
	EndIf
EndFunc ;==>_Encoding_CyrillicTo1251

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_GetCyrillicANSIEncoding
; Description ...: Finds out the ANSI encoding of cyrillic string. Needs at least 3-4 proper Russian words for certain definition.
; Syntax ........: _Encoding_GetCyrillicANSIEncoding($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: 	Success: The name of ANSI encoding (KOI8-R, WINDOWS-1251, IBM-866 or ISO-8859-5).
;					Failure: False and set @error to 1.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_GetCyrillicANSIEncoding($sString)
	Local $iWIN = 0, $iDOS = 0, $iKOI = 0, $iISO = 0
	Local $aStr = StringSplit($sString, '')
	
	For $i = 1 To $aStr[0]
		Switch Asc($aStr[$i])
			Case 192, 224, 200, 232, 206, 238, 210, 242
				$iWIN += 1
			Case 128, 160, 136, 168, 142, 174, 146
				$iDOS += 1
			Case 225, 193, 233, 201, 239, 207, 244, 212
				$iKOI += 1
			Case 176, 208, 184, 216, 190, 222, 194
				$iISO += 1
			Case 226
				$iDOS += 1
				$iISO += 1
		EndSwitch
	Next
	
	If $iKOI >= $iWIN And $iKOI > $iDOS And $iKOI > $iISO Then
		Return 'KOI8-R'
	ElseIf $iWIN > $iKOI And $iWIN > $iDOS And $iWIN > $iISO Then
		Return 'WINDOWS-1251'
	ElseIf $iDOS > $iKOI And $iDOS > $iWIN And $iDOS > $iISO Then
		Return 'IBM-866'
	ElseIf $iISO > $iWIN And $iISO > $iDOS And $iISO > $iKOI Then
		Return 'ISO-8859-5'
	Else
		Return SetError(1, 0, False)
	EndIf
EndFunc ;==>_Encoding_GetCyrillicANSIEncoding

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_GetFileEncoding
; Description ...: Gets the encoding type of specified file.
; Syntax ........: _Encoding_GetFileEncoding($sFile[, $nReadSize = -1])
; Parameters ....: $sFile               - File path to check.
;                  $nReadSize           - [optional] Size to read the file for checking. Default is -1 - read whole file.
; Return values .: 	Success: Encoding type (0 = ANSI, 1 = UTF-8, 2 = UTF-16, 4 = UTF-32).
;					Failure: -1 and set @error as following:
;															1 - unable to read the file
;															2 - unable to determine file encoding
; Author ........: Lazycat (Loopback)
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_GetFileEncoding($sFile, $nReadSize = -1)
	Local $hFile, $sRead, $iIs_UTF8 = 0, $sChar
	Local $nByte1, $nByte2, $nByte3, $nByte4
	
	Local $hFile = FileOpen($sFile, 16)
	If $hFile = -1 Then Return SetError(1, 0, -1)
	
	Local $sRead = FileRead($hFile, 4)
	FileClose($hFile)
	
	Local $nByte1 = BinaryMid($sRead, 1, 1)
	Local $nByte2 = BinaryMid($sRead, 2, 1)
	Local $nByte3 = BinaryMid($sRead, 3, 1)
	Local $nByte4 = BinaryMid($sRead, 4, 1)
	
	Select
		Case ($nByte1 = 0xFF) And ($nByte2 = 0xFE) And ($nByte3 = 0) And ($nByte4 = 0)
			Return 4 ; Unicode UTF-32
		Case ($nByte1 = 0) And ($nByte2 = 0) And ($nByte3 = 0xFE) And ($nByte4 = 0xFF)
			Return 4 ; Unicode UTF-32
		Case (($nByte1 = 0xFF) And ($nByte2 = 0xFE)) Or (($nByte1 = 0xFE) And ($nByte2 = 0xFF))
			Return 2 ; Unicode UTF-16
		Case ($nByte1 = 0xEF) And ($nByte2 = 0xBB) And ($nByte3 = 0xBF)
			Return 1 ; Unicode UTF-8 with BOM
	EndSelect
	
	; If no BOMs found, try to check if text is UTF-8 without BOM...
	If $nReadSize = -1 Then $nReadSize = FileGetSize($sFile)
	$hFile = FileOpen($sFile, 16)
	$sRead = FileRead($hFile, $nReadSize)
	FileClose($hFile)
	
	For $i = 1 To $nReadSize
		$sChar = BinaryMid($sRead, $i, 1)
		If $sChar < 0x80 Then ContinueLoop
		
		$iIs_UTF8 = 1
		
		If BitAND($sChar, 0xE0) = 0xC0 Then
			If $nReadSize - $i < 2 Then Return 0
			$sChar = BinaryMid($sRead, $i + 1, 1)
			$iBit = BitShift($sChar, 6)
			If BitAND($sChar, 0xC0) <> 0x80 Then Return 0
			$iBit = BitNOT(BitAND($sChar, 0x3F))
			If $iBit < 0 Then $iBit = 0xFF - $iBit
			If $iBit < 0x80 Then Return 0
		ElseIf BitAND($sChar, 0xF0) = 0xE0 Then
			Return SetError(2, 0, -1) ; ATM - 3-bytes symbols not supported
		EndIf
	Next
	
	Return $iIs_UTF8 ; ASCII
EndFunc ;==>_Encoding_GetFileEncoding

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_QuotedPrintableToANSI
; Description ...: Converts HEX symbols (quoted-printable) in string (Ex.: "=D2=C1=C2=CF") to ANSI symbols.
; Syntax ........: _Encoding_QuotedPrintableToANSI($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: ANSI string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_QuotedPrintableToANSI($sString)
	Return _Encoding_HexSymbolsToANSI($sString)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_HexSymbolsToANSI
; Description ...: [Deprecated] Converts HEX symbols (quoted-printable) in string (Ex.: "=D2=C1=C2=CF") to ANSI symbols.
; Syntax ........: _Encoding_HexSymbolsToANSI($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: ANSI string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_HexSymbolsToANSI($sString)
	Local $symbolfound = 2, $decodedstring = ''
	$sString = StringRegExpReplace($sString, '=\r\n', '')
	
	For $i = 1 To StringLen($sString)
		If StringRegExp(StringMid($sString, $i, 3), '=[A-Fa-f0-9]{2}') Then
			$symbolfound = 0
			$decodedstring &= BinaryToString('0x' & StringMid($sString, $i + 1, 2))
		Else
			$symbolfound += 1
			If $symbolfound = 3 Then
				$symbolfound = 2
				$decodedstring &= StringMid($sString, $i, 1)
			EndIf
		EndIf
	Next
	
	Return $decodedstring
EndFunc ;==>_Encoding_HexSymbolsToANSI

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_HexToURL
; Description ...: Converts HEX string to URL string (equivalent to _StringURIDecode function).
; Syntax ........: _Encoding_HexToURL($sURLHex)
; Parameters ....: $sURLHex             - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_HexToURL($sURLHex)
	Local $aURLHexSplit = StringSplit($sURLHex, '')
	Local $sRetString = '', $iDec, $iUbound = UBound($aURLHexSplit)
	
	For $i = 1 To $iUbound - 1
		If $aURLHexSplit[$i] = '%' And $i + 2 <= $iUbound - 1 Then
			$i += 2
			$iDec = Dec($aURLHexSplit[$i - 1] & $aURLHexSplit[$i])
			
			If Not @error Then
				$sRetString &= Chr($iDec)
			Else
				$sRetString &= $aURLHexSplit[$i - 2]
			EndIf
		Else
			$sRetString &= $aURLHexSplit[$i]
		EndIf
	Next
	
	Return _Encoding_UTF8ToANSI($sRetString)
EndFunc ;==>_Encoding_HexToURL

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_ISO8859To1251
; Description ...: Converts cyrillic string from ISO-8859-5 to Microsoft 1251 codepage.
; Syntax ........: _Encoding_ISO8859To1251($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_ISO8859To1251($sString)
	Local $sResult = '', $iCode
	Local $aSplit = StringSplit($sString, '')
	
	For $i = 1 To $aSplit[0]
		$iCode = Asc($aSplit[$i])
		
		Switch $iCode
			Case 176 To 239
				$aSplit[$i] = Chr($iCode + 16)
			Case 161
				$aSplit[$i] = Chr(168)
			Case 241
				$aSplit[$i] = Chr(184)
			Case 240
				$aSplit[$i] = Chr(185)
		EndSwitch
		
		$sResult &= $aSplit[$i]
	Next
	
	Return $sResult
EndFunc ;==>_Encoding_ISO8859To1251

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_ISO88591To1251
; Description ...: Converts cyrillic string from ISO-8859-1 to Microsoft 1251 codepage.
; Syntax ........: _Encoding_ISO88591To1251($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_ISO88591To1251($sString)
	Return StringFromASCIIArray(StringToASCIIArray($sString, 0, Default, 0), 0, Default, 2)
EndFunc ;==>_Encoding_ISO88591To1251

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_IsUTF8Format
; Description ...: Checks if a given string is stored in UTF-8 encoding.
; Syntax ........: _Encoding_IsUTF8Format($sString [, $iCheckASCIICode = False])
; Parameters ....: $sString               - String to check.
;                  $iCheckASCIICode     - [optional] Check string as ASCII Code. Default is False.
; Return values .: True if given string is stored in UTF-8 encoding, otherwise False.
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_IsUTF8Format($sText, $iCheckASCIICode = False)
	Local $iAsc, $iExt, $iLen = StringLen($sText), $bLess128 = True
	
	For $i = 1 To $iLen
		$iAsc = Asc(StringMid($sText, $i, 1))
		
		If $iCheckASCIICode And $iAsc > 128 Then $bLess128 = False
		
		If Not BitAND($iAsc, 0x80) Then
			ContinueLoop
		ElseIf Not BitXOR(BitAND($iAsc, 0xE0), 0xC0) Then
			$iExt = 1
		ElseIf Not (BitXOR(BitAND($iAsc, 0xF0), 0xE0)) Then
			$iExt = 2
		ElseIf Not BitXOR(BitAND($iAsc, 0xF8), 0xF0) Then
			$iExt = 3
		Else
			Return False
		EndIf
		
		If $i + $iExt > $iLen Then Return False
		
		For $j = $i + 1 To $i + $iExt
			$iAsc = Asc(StringMid($sText, $j, 1))
			If BitXOR(BitAND($iAsc, 0xC0), 0x80) Then Return False
		Next
		
		$i += $iExt
	Next
	
	If $iCheckASCIICode Then Return($bLess128 = False)
	
	Return True
EndFunc ;==>_Encoding_IsUTF8Format

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_JavaUnicodeEncode
; Description ...: Encode string to Java Unicode format.
; Syntax ........: _Encoding_JavaUnicodeEncode($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_JavaUnicodeEncode($sString)
	Local $iOld_Opt_EVS = Opt('ExpandVarStrings', 0)
	Local $iOld_Opt_EES = Opt('ExpandEnvStrings', 0)
	
	Local $iLen = StringLen($sString), $sChr, $iAsc
	Local $stChr = DllStructCreate('wchar[' & $iLen + 1 & ']'), $sOut = ''
	Local $stAsc = DllStructCreate('ushort[' & $iLen + 1 & ']', DllStructGetPtr($stChr))
	DllStructSetData($stChr, 1, $sString)
	
	For $i = 1 To StringLen($sString)
		$sChr = DllStructGetData($stChr, 1, $i)
		$iAsc = DllStructGetData($stAsc, 1, $i)
		
		If $sChr = '\' Or $sChr = "'" Then
			$sOut &= '\' & $sChr
		ElseIf $iAsc < 128 Then
			$sOut &= $sChr
		Else
			$sOut &= '\u' & Hex($iAsc, 4)
		EndIf
	Next
	
	Opt('ExpandVarStrings', $iOld_Opt_EVS)
	Opt('ExpandEnvStrings', $iOld_Opt_EES)
	
	Return $sOut
EndFunc ;==>_Encoding_JavaUnicodeEncode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_JavaUnicodeDecode
; Description ...: Decode string from Java Unicode format.
; Syntax ........: _Encoding_JavaUnicodeDecode($sString)
; Parameters ....: $sString             - String to decode.
; Return values .: Decoded string.
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_JavaUnicodeDecode($sString)
	Local $iOld_Opt_EVS = Opt('ExpandVarStrings', 0)
	Local $iOld_Opt_EES = Opt('ExpandEnvStrings', 0)
	
	Local $sOut = "", $aString = StringRegExp($sString, "(\\\\|\\'|\\u[[:xdigit:]]{4}|[[:ascii:]])", 3)
	
	For $i = 0 To UBound($aString) - 1
		Switch StringLen($aString[$i])
			Case 1
				$sOut &= $aString[$i]
			Case 2
				$sOut &= StringRight($aString[$i], 1)
			Case 6
				$sOut &= ChrW(Dec(StringRight($aString[$i], 4)))
		EndSwitch
	Next
	
	Opt('ExpandVarStrings', $iOld_Opt_EVS)
	Opt('ExpandEnvStrings', $iOld_Opt_EES)
	
	Return $sOut
EndFunc ;==>_Encoding_JavaUnicodeDecode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_KOI8To1251
; Description ...: Converts cyrillic string from KOI8-R to Microsoft 1251 codepage.
; Syntax ........: _Encoding_KOI8To1251($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: Latoid
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_KOI8To1251($sString)
	Local $sResult = '', $iCode
	Local $aSplit = StringSplit($sString, '')
	
	For $i = 1 To $aSplit[0]
		$iCode = Asc($aSplit[$i])
		
		Switch $iCode
			Case 63
				$aSplit[$i] = Chr(185)
			Case 163
				$aSplit[$i] = Chr(184)
			Case 179
				$aSplit[$i] = Chr(168)
			Case 233 To 240
				$aSplit[$i] = Chr($iCode - 33)
			Case 242 To 245
				$aSplit[$i] = Chr($iCode - 34)
			Case 201 To 208
				$aSplit[$i] = Chr($iCode + 31)
			Case 210 To 213
				$aSplit[$i] = Chr($iCode + 30)
			Case 225 To 226
				$aSplit[$i] = Chr($iCode - 33)
			Case 228 To 229
				$aSplit[$i] = Chr($iCode - 32)
			Case 193 To 194
				$aSplit[$i] = Chr($iCode + 31)
			Case 247
				$aSplit[$i] = Chr(194)
			Case 231
				$aSplit[$i] = Chr(195)
			Case 246
				$aSplit[$i] = Chr(198)
			Case 250
				$aSplit[$i] = Chr(199)
			Case 230
				$aSplit[$i] = Chr(212)
			Case 232
				$aSplit[$i] = Chr(213)
			Case 227
				$aSplit[$i] = Chr(214)
			Case 254
				$aSplit[$i] = Chr(215)
			Case 251
				$aSplit[$i] = Chr(216)
			Case 253
				$aSplit[$i] = Chr(217)
			Case 255
				$aSplit[$i] = Chr(218)
			Case 249
				$aSplit[$i] = Chr(219)
			Case 248
				$aSplit[$i] = Chr(220)
			Case 252
				$aSplit[$i] = Chr(221)
			Case 224
				$aSplit[$i] = Chr(222)
			Case 241
				$aSplit[$i] = Chr(223)
			Case 215
				$aSplit[$i] = Chr(226)
			Case 199
				$aSplit[$i] = Chr(227)
			Case 196
				$aSplit[$i] = Chr(228)
			Case 197
				$aSplit[$i] = Chr(229)
			Case 214
				$aSplit[$i] = Chr(230)
			Case 218
				$aSplit[$i] = Chr(231)
			Case 198
				$aSplit[$i] = Chr(244)
			Case 200
				$aSplit[$i] = Chr(245)
			Case 195
				$aSplit[$i] = Chr(246)
			Case 222
				$aSplit[$i] = Chr(247)
			Case 219
				$aSplit[$i] = Chr(248)
			Case 221
				$aSplit[$i] = Chr(249)
			Case 223
				$aSplit[$i] = Chr(250)
			Case 217
				$aSplit[$i] = Chr(251)
			Case 216
				$aSplit[$i] = Chr(252)
			Case 220
				$aSplit[$i] = Chr(253)
			Case 192
				$aSplit[$i] = Chr(254)
			Case 209
				$aSplit[$i] = Chr(255)
		EndSwitch
		
		$sResult &= $aSplit[$i]
	Next
	
	Return $sResult
EndFunc ;==>_Encoding_KOI8To1251

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_OEM2ANSI
; Description ...: Converts OEM encoded string to ANSI string.
; Syntax ........: _Encoding_OEM2ANSI($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: 	Success: Encoded string.
;					Failure: Empty string and set @error as following:
;															1 - DLL error
;															2 - OemToChar failure
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_OEM2ANSI($sString)
	Local $sBuffer = DllStructCreate('char[' & StringLen($sString) + 1 & ']')
	Local $aRet = DllCall('User32.dll', 'int', 'OemToChar', 'str', $sString, 'ptr', DllStructGetPtr($sBuffer))
	
	If Not IsArray($aRet) Then Return SetError(1, 0, '') ; DLL error
	If $aRet[0] = 0 Then Return SetError(2, $aRet[0], '') ; Function error
	
	Return DllStructGetData($sBuffer, 1)
EndFunc ;==>_Encoding_OEM2ANSI

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_PhpEncode
; Description ...: Encode/decode string using php functions.
; Syntax ........: _Encoding_PhpEncode($sString, $sEncoding)
; Parameters ....: $sString             - String to encode.
;                  $sEncoding           - Encoding to use (php syntax).
; Return values .: Encoded string.
; Author ........: Alex33 & G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_PhpEncode($sString, $sEncoding)
	;Return BinaryToString(InetRead(StringFormat('http://autoit-script.ru/Tools/encode.php?str=%s&enc=%s', $sString, $sEncoding)), $bUnicode ? 4 : 0)
	
	Local $sPHP_Exe = @TempDir & '\php.exe'
	Local $sPHP_Dll = @TempDir & '\php5ts.dll'
	
	If Not FileExists($sPHP_Exe) Then
		InetGet('http://autoit-script.ru/Tools/php/php.exe', $sPHP_Exe, 3)
	EndIf
	
	If Not FileExists($sPHP_Dll) Then
		InetGet('http://autoit-script.ru/Tools/php/php5ts.dll', $sPHP_Dll, 3)
	EndIf
	
	If Not FileExists($sPHP_Exe) Or Not FileExists($sPHP_Dll) Then
		Return SetError(1, 0, 0)
	EndIf
	
	$sString = StringStripCR($sString)
	$sString = StringReplace($sString, @LF, '\r\n')
	$sString = StringReplace($sString, '"', '\x22')
	
	Local $sCmd = '-r echo ' & $sEncoding & '(""' & $sString & '"");'
	Local $iPID = Run('"' & $sPHP_Exe & '" "' & $sCmd & '"', @ScriptDir, @SW_HIDE, 6)
	ProcessWaitClose($iPID)
	
	Local $sRet = StdoutRead($iPID)
	
	If @error Then
		Return SetError(2, 0, 0)
	EndIf
	
	Return $sRet
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_StringToUTF8
; Description ...: Converts any string to UTF-8 encoding.
; Syntax ........: _Encoding_StringToUTF8($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: String in UTF8 encoding.
; Author ........: LEX1
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_StringToUTF8($sString)
	Local $sResult = '', $iCode
	Local $aSplit = StringSplit($sString, '')
	
	For $i = 1 To $aSplit[0]
		$iCode = Asc($aSplit[$i])
		
		Switch $iCode
			Case 192 To 239
				$aSplit[$i] = Chr(208) & Chr($iCode - 48)
			Case 240 To 255
				$aSplit[$i] = Chr(209) & Chr($iCode - 112)
			Case 168
				$aSplit[$i] = Chr(208) & Chr(129)
			Case 184
				$aSplit[$i] = Chr(209) & Chr(145)
			Case Else
				$aSplit[$i] = Chr($iCode)
		EndSwitch
		
		$sResult &= $aSplit[$i]
	Next
	
	Return $sResult
EndFunc ;==>_Encoding_StringToUTF8

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_URIDecode
; Description ...: Decode string from URI format (Uniform Resource Identifier).
; Syntax ........: _Encoding_URIDecode($sString)
; Parameters ....: $sString             - String to Decode.
; Return values .: Decoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_URIDecode($sString)
	Local $oSC = ObjCreate('ScriptControl')
	
	If Not IsObj($oSC) Then
		Return _Encoding_URLToHex($sString)
	EndIf
	
	$oSC.Language = 'JavaScript'
	Local $sResult = $oSC.Eval("decodeURI('" & $sString & "');")
	
	$oSC = 0
	
	Return $sResult
EndFunc ;==>_Encoding_URIDecode

;Description: 
;Author: CreatoR

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_URIEncode
; Description ...: Encode string to URI format (Uniform Resource Identifier)
; Syntax ........: _Encoding_URIEncode($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_URIEncode($sString)
	Local $oSC = ObjCreate('ScriptControl')
	
	If Not IsObj($oSC) Then
		Return _Encoding_HexToURL($sString)
	EndIf
	
	$oSC.Language = 'JavaScript'
	Local $sResult = $oSC.Eval("encodeURI('" & $sString & "');")
	
	$oSC = 0
	
	Return $sResult
EndFunc ;==>_Encoding_URIEncode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_URLToHex
; Description ...: Converts URL string to HEX string (equivalent to _StringURIEncode function).
; Syntax ........: _Encoding_URLToHex($sURLString)
; Parameters ....: $sString          - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_URLToHex($sString)
	$sString = _Encoding_ANSIToUTF8($sString)
	
	Local $aSplit = StringSplit($sString, '')
	Local $sResult = ''
	
	For $i = 1 To UBound($aSplit) - 1
		If Not StringRegExp($aSplit[$i], '(?i)[a-z]|\.|-|_') Then
			$aSplit[$i] = '%' & Hex(Asc($aSplit[$i]), 2)
		EndIf
		
		$sResult &= $aSplit[$i]
	Next
	
	Return $sResult
EndFunc ;==>_Encoding_URLToHex

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_UTF8BOMDecode
; Description ...: Converts UTF-8 (with BOM) string to ANSI encoding.
; Syntax ........: _Encoding_UTF8BOMDecode($sString)
; Parameters ....: $sString             - String to decode.
; Return values .: Decoded string.
; Author ........: amel27 (mod. by AZJIO)
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_UTF8BOMDecode($sString)
	Local $sRetStr, $iMidleStr, $iMidleStr_Pos, $iMidleStr_Chck
	
	Local $sDecodeStr = BinaryToString('0xC3A0C3A1C3A2C3A3C3A4C3A5C3A6C3A7C3A8C3A9C3AAC3ABC3ACC3ADC3AEC3AFC3B0C3B1C3B2C3B3C3B4C3B5C3B6C3B7C3B8C3B9C3BCC3BBC3BDC3BEC3BF', 4)
	Local $sEncodeStr = 'абвгдежзийклмнопрстуфхцчшщьыэю€'
	
	For $i = 1 To StringLen($sString)
		$iMidleStr = StringMid($sString, $i, 1)
		$iMidleStr_Pos = StringInStr($sDecodeStr, $iMidleStr)
		
		If $iMidleStr_Pos Then
			$iMidleStr_Chck = StringMid($sEncodeStr, $iMidleStr_Pos, 1)
			
			If StringIsUpper($iMidleStr) Then
				$iMidleStr_Chck = StringUpper($iMidleStr_Chck) ; актуально только дл€ изменЄнного символа
			EndIf
		Else
			$iMidleStr_Chck = $iMidleStr
		EndIf
		
		$sRetStr &= $iMidleStr_Chck
	Next
	
	Return $sRetStr
EndFunc ;==>_Encoding_UTF8BOMDecode

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_UTF8ToANSI
; Description ...: Converts UTF-8 string to ANSI encoding.
; Syntax ........: _Encoding_UTF8ToANSI($sString)
; Parameters ....: $sString             - String to encode.
; Return values .: Encoded string.
; Author ........: G.Sandler
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_UTF8ToANSI($sString)
	Return BinaryToString(StringToBinary($sString), 4)
EndFunc ;==>_Encoding_UTF8ToANSI

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_UTF8ToANSI_API
; Description ...: Converts UTF-8 string to ANSI encoding.
; Syntax ........: _Encoding_UTF8ToANSI_API($sString)
; Parameters ....: $sString        - String to encode.
; Return values .: 	Success: Encoded string.
;					Failure: Empty string and set @error to 1.
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_UTF8ToANSI_API($sString)
	Local $iLen = StringLen($sString)
	Local $stBuf = DllStructCreate('byte[' & $iLen * 2 & '];byte[2]')
	
	Local $aRet = DllCall('Kernel32.dll', 'int', 'MultiByteToWideChar', _
			'int', 65001, 'int', 0, _
			'str', $sString, 'int', -1, _
			'ptr', DllStructGetPtr($stBuf), 'int', $iLen * 2 + 2)
	
	Local $stOut = DllStructCreate('char[' & $iLen & '];char')
	
	$aRet = DllCall('kernel32.dll', 'int', 'WideCharToMultiByte', _
			'int', 0, 'int', 0, _
			'ptr', DllStructGetPtr($stBuf), 'int', -1, _
			'ptr', DllStructGetPtr($stOut), 'int', $iLen + 1, _
			'int', 0, 'int', 0)
	
	Local $sRet = DllStructGetData($stOut, 1)
	If $sRet = 0 Then Return SetError(1, 0, '')
	
	Return $sRet
EndFunc ;==>_Encoding_UTF8ToANSI_API

; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_UTF8ToUnicode_API
; Description ...: Converts UTF-8 string to Unicode encoding.
; Syntax ........: _Encoding_UTF8ToUnicode_API($sString)
; Parameters ....: $sString        - String to encode.
; Return values .: Encoded string.
; Author ........: amel27
; Modified ......: 
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: No
; ===============================================================================================================================
Func _Encoding_UTF8ToUnicode_API($sString)
	Local $iBufferSize = StringLen($sString)
	Local $stBuffer = DllStructCreate('byte[' & $iBufferSize * 2 & ']')
	
	DllCall('Kernel32.dll', 'int', 'MultiByteToWideChar', _
			'int', 65001, _
			'int', 0, _
			'str', $sString, _
			'int', StringLen($sString), _
			'ptr', DllStructGetPtr($stBuffer), _
			'int', $iBufferSize)
	
	Local $bUnicodeBinary = DllStructGetData($stBuffer, 1)
	Local $nUnicodeHex = StringReplace($bUnicodeBinary, '0x', '')
	Local $iStrLen = StringLen($nUnicodeHex)
	Local $nHexTmp, $sRet
	
	For $i = 1 To $iStrLen Step 4
		$nHexTmp = StringMid($nUnicodeHex, $i, 4)
		$iDecTmp = Dec(StringMid($nHexTmp, 3, 2) & StringMid($nHexTmp, 1, 2))
		
		If $iDecTmp Then
			$sRet &= ChrW($iDecTmp)
		EndIf
	Next
	
	Return $sRet
EndFunc
