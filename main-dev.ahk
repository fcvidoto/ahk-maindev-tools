#SingleInstance, Force
#NoEnv ;*[AHK]
; #Include C:\Users\fcvid\Documents\AHK\Studio\Class\Acc.ahk
DetectHiddenWindows, on
SetTitleMatchMode, 2
SendMode,Input

;-------------------------------------------------------------------
;ATALHOS DE APPS

#d::
HotKeysInGITBash.abreGITbash()
return

;Abre a tela do Sublime
#s::
HotkeysInSublime.AbreSublime()
return

;Abre o Chrome
#c::
HotkeysInChrome.AbreChrome()
return

;Abre a janela do IE
#i::
HotKeysInIE.AbreIeWindow()
return

;Abre o chrome dev tools
#a::
HotkeysInChrome.AbreChromeDevTools()
return

;ativa o explorer
#q::
HotKeysInWindows.ativaExplorer()
return
;-------------------------------------------------------------------
;GITBASH
;Cola os valores no gitbash
$^v::
HotKeysInGITBash.pasteValues()
return

;-------------------------------------------------------------------
;WINDOWS EXPLORER
;Cria um novo file no windows
^!n::
HotKeysInWindows.CriaNovoFile()
return	

;-------------------------------------------------------------------
;SPOTIFY
;Aumenta o volume
^Numpad8::
HotKeysInSpotify.aumentaVolume()
return

;Diminui o volume
^Numpad5::
HotKeysInSpotify.diminuiVolume()
return

;Troca a musica - proxima ->
^Numpad6::
HotKeysInSpotify.trocaMusicaProxima()
return

;Troca a musica - anterior ->
^Numpad4::
HotKeysInSpotify.trocaMusicaAnterior()
return

;Pausa o spotify
^Numpad3::
HotKeysInSpotify.pausaSpotify()
return

;Fica mute
^Numpad9::
HotKeysInSpotify.volumeMute()
return

;-------------------------------------------------------------------
;SUBLIME
;Ativa o Sublime
^Numpad7::
HotKeysInSpotify.ativaSpotify()
return

;Insere linha acima no sublime
^\::
HotkeysInSublime.inserirLinhaAcima()
return

;Insere comment ""
+`::
HotkeysInSublime.insereComment()
return

;deleta linha do sublime
^k::
HotkeysInSublime.deletaLinha()
return
;-------------------------------------------------------------------

;Sai do app
+Escape::
ExitApp
return


;Relacionadas ao Google Chrome
class HotKeysInGITBash {

	;Ativa a janela do git bash
	;Detecta se algum bash, 
	abreGITbash() {

		if WinExist("ahk_class mintty") {

			;pega o total de bash e vai ativando
			WinGet, countBash, Count, ahk_class mintty 
			Loop, %countBash%
			{
				WinActivateBottom, ahk_class mintty
			}		
		}

	}

	;Cola os valores no gitbash
	pasteValues() {

		if WinActive("ahk_class mintty") {
			Send, +{Insert}
			} else {
				Send, ^v
			}
	}
}


;Google Chrome
Class HotKeysInChrome{
	
	;Ativa o Chrome
	AbreChrome() {
		
		;Verifica se a janela do Chrome já existe
		If WinExist("Google Chrome"){
			WinActivate
		}
		
		;Se a janela do Chrome não existe, cria uma nova
		else{
			Run, Chrome
		}
	}	
	
	AbreChromeDevTools() {
		if WinExist("Developer Tools") {
			WinActivate
		}
	}
	
}

;Internet Explorer
Class HotKeysInIE{
	
	;Ativa a janela do internet explorer
	AbreIeWindow(){
		
		;Ativa o janela o Internet Explorer
		If WinExist("ahk_class IEFrame"){
			WinActivate
		}
		else{
			Run, iexplore
		}
	}
	
}

class HotKeysInSpotify {
	
	aumentaVolume() {
		Send {Volume_Up}
		return	
	}
	
	diminuiVolume() {
		Send {Volume_Down}
		return
	}
	
	trocaMusicaProxima() {
		DetectHiddenWindows, On 
		ControlSend, ahk_parent, ^{Right}, ahk_class SpotifyMainWindow 
		DetectHiddenWindows, Off  
		return
	}
	
	trocaMusicaAnterior() {
		DetectHiddenWindows, On 
		ControlSend, ahk_parent, ^{Left}, ahk_class SpotifyMainWindow 
		DetectHiddenWindows, Off  
		return
	}
	
	volumeMute() {
		Send {Volume_Mute}	
		return
	}
	
	ativaSpotify() {

		;verifica se o spotify existe
		if WinExist("ahk_class SpotifyMainWindow") {

			;Se a janela do Spotify estiver ativa, oculta
			if WinActive("ahk_class SpotifyMainWindow") {
				this.ocultaSpotify()
				
			;Se a janela não estiver ativa, a ativa
			} else {			
				if WinExist("ahk_class SpotifyMainWindow") {
					WinActivate
				}	
			}

		;se o spotify nao existir, cria um novo
		} else {
			run, C:\Users\fcvid\AppData\Roaming\Spotify\Spotify.exe
		}

	}
	
	ocultaSpotify() {
		MouseGetPos,,, OutputVarWin
		WinSet Bottom,, ahk_id %OutputVarWin%
		MouseGetPos,,, OutputVarWin
		WinActivate ahk_id %OutputVarWin%
		return
	}
	
	pausaSpotify() {
		if WinActive("ahk_class SpotifyMainWindow") {
			Send, {Space}
			
		} else if WinExist("ahk_class SpotifyMainWindow") {
			
			WinHide
			WinActivate
			Send {space}
			this.ocultaSpotify()
			WinShow
			
		}
		
		return
	}
	
}

;Sublime
Class HotkeysInSublime {
	
	;Verifica se o sublime está aberto
	AbreSublime() {
		
		If WinExist("ahk_class PX_WINDOW_CLASS") {
			WinActivate
		} else {
			Run, C:\Program Files\Sublime Text 3\sublime_text.exe
		}
		
	}
	
	;Insere o enter na linha acima do sublime
	inserirLinhaAcima() {
		
		if WinActive("ahk_class PX_WINDOW_CLASS") {
			Send, ^+{Enter}
		}
		return
	}
	
	;Insere comment na linha
	insereComment() {
		Send, "
	}
	
	deletaLinha() {
		
		if WinActive("ahk_class PX_WINDOW_CLASS") {
			Send, ^+{k}
		}
		return
	}
	
}

;Referente a HotKyes no Windows
Class HotKeysInWindows{
	
	;ativa a janela do explorer
	ativaExplorer() {

		if WinExist("ahk_class CabinetWClass") {
			WinActivate
		}
	}

	;Cria um arquivo txt no windows explorer
	CriaNovoFile() {
		
		SetTitleMatchMode RegEx
		
		WinGetText, full_path, A
		StringSplit, word_array, full_path, `n
		Loop, %word_array0%
		{
			IfInString, word_array%A_Index%, Address
			{
				full_path := word_array%A_Index%
				break
			}
		} 
		full_path := RegExReplace(full_path, "^Address: ", "")
		StringReplace, full_path, full_path, `r, , all
		
		IfInString full_path, \
		{
			NoFile = 0
			Loop
			{
				IfExist  %full_path%\NewTextFile%NoFile%.txt
					NoFile++
				else
					break
			}
			FileAppend, ,%full_path%\NewTextFile%NoFile%.txt
		}
		else
		{
			return
		}
		;}
	}

}

;Ctrl + Shift + Escape sai da aplicação
^+Escape::
ExitApp
return