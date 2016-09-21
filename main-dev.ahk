#SingleInstance, Force
#NoEnv ;*[AHK]
#Include C:\Users\fcvid\Documents\AHK\Studio\Class\Acc.ahk
DetectHiddenWindows, on
SetTitleMatchMode, 2
SendMode,Input
;------------------------------------------------------------------------------------

;Jogar o Tab dentro do AHK
;Tab::
;HotKeysInExcel.TabInAdvancedEditor()
;return	
 ;*[AHK]
;Abre a tela do Sublime
#s::
HotkeysInSublime.AbreSublime()
return

;Quando dar o alt + tab seleciona o txtfield do 'Advanced Editor'
;#e::    
;HotKeysInExcel.SelectAdvancedEditor()
;return

;Maximiza a janela
;#~::
;HotKeysInWindows.MaximizaJanela()
;return

;Windows + A - Abre o Accessible Info Viewer
;Windows + A - Abre o ATOM
#a::
;HotkeysInATOM.AbreATOM()
;HotKeysInAHK.LoadAccInfo()
HotkeysInChrome.AbreChromeDevTools()
return

;Windows + C - Abre o Chrome
#c::
HotkeysInChrome.AbreChrome()
return

;Windows + H - abre a janela do AHK Studio
#h::
HotKeysInAHK.AtivaAHKstudio()
return

;Abre a janela do IE
#i::
HotKeysInIE.AbreIeWindow()
return

;Windows + K - Mata todas as instancias de Excel
;#k::
;HotKeysInExcel.KillExcelInstances()
;return

^!n::
HotKeysInWindows.CriaNovoFile()
return	

;-------------------------------------------------------------------
;Relacionados ao Spotify
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
;*******************************************************************

;Sai do app
+Escape::
ExitApp
return

;Todas as hotkeys relacionadas ao ATOM
Class HotkeysInATOM{
	
	;Abre o ATOM
	;Verifica se o ATOM está aberto - se estiver foca // Se não estiver, abre uma instância
	AbreATOM(){
		
		if WinExist("Atom"){
			WinActivate
		} else {		
			Run, Atom
		}
	}
	
	;Roda a página 
	OpenIndex(){
		
		;Só roda se o ATOM estiver focado
		if WinActive("Atom"){
			Run, C:\Users\Fernando\Documents\npm\index.html			
		}
	}
}

;Todas as hotkeys relacionadas ao Google Chrome
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

;Todas as hotkeys relacionadas ao app do AHK
Class HotKeysInAHK{
	
	;Fecha a janela do Omni-Search
	CloseOmniSearch(){
		
		If WinActive("Omni-Search"){
			Send, !{F4}
		}	
		else{
			Send, {Escape}
		}
	}
	
	;Muda a aba do AHK Studio para baixo
	MudaAbaBaixo(){
		
		;Se a janela do AHK Studio estiver aberta
		If WinActive("AHK Studio"){
			ControlFocus, SysTreeView321
			Send, {Down}
		}
		
		;Se não for dentro do AHK Studio
		else{
			Send, ^{Pgdn}
		}
	}	
	
	;Muda de aba pra cima
	MudaAbaCima(){
		
		;Se o AHK Studio estiver aberto, muda a aba pra cima
		If WinActive("AHK Studio"){
			ControlFocus, SysTreeView321
			Send, {Up}
		}
		
		;Se não for dentro do AHK Studio
		else{
			Send, ^{PgUp}
		}
	}
	
	;Atualiza o AHK Studio com a nova lista de #include
	RefreshAHK(){
		
		;Fecha o AHK Studio e reabre 
		If WinActive("AHK Studio"){
			
			WinClose
			Run, C:\Users\Fernando\Documents\AHK\Studio\AHK Studio.ahk
		}
		else{
			Send, {F9}
		}
	}	
	
	;Carrega a janela do Accessible Info Viewer
	LoadAccInfo(){
		
		;Se a janela do Acc Info Viwer existir, ativa
		If WinExist("Accessible Info Viewer"){
			
			;Após ativar seleciona o campo 
			ControlGetText, ClassNN, Edit4
			Clipboard := ClassNN
		}
		;Se a janela não existir, instancia
		else{
			Run, C:\Users\fcvid\Documents\AHK\Studio\Framework\AccViewer Source.ahk
		}
	}
	
	;Relacionado aos valores de variáveis
	InsereVariavel(){
		
		If WinActive("AHK Studio"){
			
			Clipboard := "" ;Limpa o clipboard antes
			
			;Captura a string do texto do Clipboard
			Send, ^c
			
			;Se o Clipboard não for vazio
			If (Clipboard <> ""){
				
				;Se o clipboard não for vazio verifica se existe o '%' e substitui por nada
				if RegExMatch(Clipboard, "%",, 1){
					
					clipboardtemp := RegExReplace(Clipboard, "%", "")
					Clipboard := clipboardtemp
					
					;cola os novos dados
					Send, ^v
				}
				;Se não identificar o sinal de %, transforma o texto em variável
				else{ 
					
					clipboardtemp := "%" . Clipboard . "%"
					Clipboard := clipboardtemp
					
					;Cola os novos dados
					Send, ^v
				}		
			}
			;Se o Clipboard for vazio, coloca %
			else{
				Send, +{5}		
			}
		}
		;Qualquer outra janela do windows
		else{
			Send, ^{Space}
		}		
	}
	
	;Ativa a janala do hotKey
	AtivaAHKstudio(){
		;Se a janela do hotkey existir, ativa
		If WinExist("AHK Studio"){
			WinActivate
		}
		else{
			Run, C:\Users\fcvid\Documents\AHK\Studio\Studio v2\AHK_Studio.ahk
		}		
	}
}

;Todas as hotkeys relacionadas ao notepad++
Class HoketKeysInNotepadPlusPlus{	
	
	RunAHKcode(){
		
		;Se a janela do Notepad++ estiver aberta
		if WinActive("ahk_class Notepad++"){
			
			;Verifica se a os botões do compiler estão habilitados
			ControlGet, botaoHabilidado, Enabled,, TBitBtn2
			
			;Verifica se os botões do compiler existem
			ControlGet, botaoVisivel, Enabled,, TBitBtn2
			
			;Se o botão já estiver visível, roda
			If (botaoHabilidado = true and botaoVisivel = true){
				ControlClick, TBitBtn2, ahk_class Notepad++
				return
			}
			
			;Se o botão não existir abre a janela do debugger
			If (botaoVisivel = false or botaoVisivel = ""){
				
				;Abre a janela do Debugger
				WinMenuSelectItem,,, Plugins, DBGp, Debugger
			}
			
			;Se os botões do compiler estiver hablitados *significa que pode dar run
			If (botaoHabilidado = False or botaoHabilidado = ""){
				
				;Monta a string do endereço do compiler
				aspas := """"
				Clipboard := aspas . "C:\Program Files\AutoHotkey\AutoHotkeyA32.exe" . aspas . " /Debug " . aspas . "$(FULL_CURRENT_PATH)" . aspas
				
				;Carrega a janela do 'run code'
				WinMenuSelectItem,,, Run, Run
				
				;Quando aparecer a janela do run, clica em Ok
				Sleep, 300
				If WinExist("Run..."){
					
					;Apaga os dados anteriores		
					Send, {Backspace}
					
					;Cola os dados
					Sleep, 100
					Send, ^v
					
					;Clica no botão1 - Ok
					;SetTimer, BotaoOk,Click, 50
				}
				
			}
		}
		
		;Se for a janela do AHK Studio
		else if WinActive("AHK Studio"){
			WinMenuSelectItem, AHK Studio,, File, Run
		}
		
		;Se for outra janela que não o Notepad ++
		else{
			SendInput, {F5}
		}	
	}
}

;Todas as hotkeys relacionadas ao MS Excel
Class HotKeysInExcel{
	
	;Quando aperta 'Tab' dá 4 espaçoes
	TabInAdvancedEditor(){
		
		;Se for a janela do **Advanced Editor		
		If WinActive("Advanced Editor"){
			Send, {Space}{Space}{Space}{Space}
		}
		;Se for qualquer outra janela
		else{
			Send, {Tab}
		}
	}
	
	
	;Quando dar o alt + tab seleciona o txtfield do 'Advanced Editor'
	SelectAdvancedEditor(){
		
		if WinExist("Advanced Editor"){
			WinActivate
			
			;foca no txtfield
			ControlFocus, Internet Explorer_Server1, Advanced Editor
		}
		;verifica se o Excel está aberto
		else if WinExist("ahk_class XLMAIN"){
			WinActivate
		}
		;Se for uma janela qualquer
		else{
			Send, #{e}
		}
	}		
	
	;Mata todas as instancias de Excel
	KillExcelInstances(){
		
		stringKill := "TASKKILL /F /IM excel.exe"
		
		;Faz uma pergunta sobre matar todos os Excel
		MsgBox, 4, Kill Excel, Você gostaria de fechar todas as instancias de Excel?
		IfMsgBox, Yes
			Run, %stringKill%
	}	
	
}


;Todas as Hotkeys relacionadas ao Internet Explorer
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
	
	;Coloca a palavra 'javascript:' na barra de endereços
	ColocaJavascriptEmEnderecos(){
		
		;Se a janela do Internet Explorer existe
		If WinExist("ahk_class IEFrame"){
			WinActivate
			ControlClick, AddressDisplay Control1			
		}
	}
	
	;Get address bar
	GetAddresBar(){
		
		;Verifica se a janela existe
		If WinExist("ahk_class IEFrame"){
			
			ie := this.IEGet()
			MsgBox, % ie.LocationUrl
		}
	}
	
	;Preenche o formulário de login
	PreencheFrm(){
		ie := this.IEGet()
		ie.Navigate("outloo.com")
		
		;Espera o IE carregar a página
		While ie.busy{
			Sleep, 1000
		}
		
		;Após carregar a página, preenche os forms
		ie.Document.All.login := "fcvidoto@hotmail.com"
		
		;Clica no botão
		id.Document.All.SI.Click()
	}
	
	;Pega a instancia do IE aberta
	IEGet(name="") {
		IfEqual, Name,, WinGetTitle, Name, ahk_class IEFrame     ;// Get active window if no parameter
			Name := (Name="New Tab - Windows Internet Explorer")? "about:Tabs":RegExReplace(Name, " - (Windows|Microsoft) Internet Explorer")
		for wb in ComObjCreate("Shell.Application").Windows
			if wb.LocationName=Name and InStr(wb.FullName, "iexplore.exe")
				return wb
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
		
		;Se a janela do Spotify estiver ativa, manda pra trás
		if WinActive("ahk_class SpotifyMainWindow") {
			this.ocultaSpotify()
			
		;Se a janela não estiver ativa, ativa ela
		} else {			
			if WinExist("ahk_class SpotifyMainWindow") {
				WinActivate
			}	
		}
		return
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
	
	;Ctrl + Space - faz o simbolo da variável <> no sublime
	InsereVariavel() {
		
		;Só ativa na janela do Sublime
		;If WinActive("ahk_class PX_WINDOW_CLASS") {			
		
			;Verifica se a variável está vazia
		if (conta="") {
			conta=0
		}
		
		
		;-----------------------------------
		;Manda o primeiro '<'
		if (conta=0) {
			conta:=1 ;altera o valor da global
			send, <
			
			;Manda o segundo '>'
		}  else if (conta=1) {
			conta:=0 ;altera o valor da global			
			send, >
		}
		;}
	}
	
	
	
}

;Referente a HotKyes no Windows
Class HotKeysInWindows{
	
	;Cria um arquivo txt no windows explorer
	CriaNovoFile() {
		
		SetTitleMatchMode RegEx
		
		;#IfWinActive ahk_class ExploreWClass|CabinetWClass
		;NewTextFile()
		;return
		;#IfWinActive
		;
		;NewTextFile()
		;{
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
	
	;Maximiza janela atual
	MaximizaJanela() {
		
		WinGetActiveTitle, janelaAtiva
		WinGet, maximized, MinMax, %janelaAtiva%
		
		if (maximized) {			
			WinRestore, %janelaAtiva%
			
		} else {	
			WinMaximize, %janelaAtiva%
		}
		
	}
	
	;Altera as conexões de proxy
	ChangeProxy(){
		
		;Fecha a janela do 'Internet Properties' ou 'Local Area Network'
		If WinExist("Internet Properties"){
			WinClose
		}
		If WinExist("Local Area Network"){
			WinClose
		}
		;-----------------------------------------------
		
		;Trava os movimentos do teclado
		BlockInput, MouseMove
		BlockInput, Send
		
		;Verifica se a janela de Lan já está aberta
		Sleep, 80
		if WinExist("Local Area Network"){
			
			WinActivate
			;Clica na oção do proxy
			ControlClick, Button6
			return
		}
		
		;Verifica se a janela de 'Internet Properties' já existe
		If WinExist("Internet Properties"){
			
			WinActivate
		}
		;Se a janela não existir, então carrega uma nova
		else{
			
			Run, inetcpl.cpl
			
			;Espera a janela de 'Internet Properties' abrir
			WinWait, Internet Properties
		}
		
		;Se a janela de 'Internet Properties'
		If WinExist("Internet Properties"){
			
			WinActivate
			
			;Foca na aba correta
			Sleep, 80
			MouseClick, Left, 255, 45
			
			;Clica no controle do 'Proxy'
			Sleep, 80
			ControlClick, Button10, Internet Properties
			
			;Se não for carregada a nova janela, entra nela
			If not WinActive("Local Area Network"){
				Send, {Enter}
			}
			
			;CLica na opçao do proxy
			WinWait, Local Area Network
			if WinExist("Local Area Network"){
				
				WinActivate
				
				;Clica na opção do proxy
				ControlFocus, Button6
				Sleep, 80
				Send, {Space}
				
				Sleep, 80				
				
				;Pega o status do controle alterado
				ControlGet, statusAlterado, Checked,, Button6
				
				;Confirma as alterações
				ControlFocus, Button12
				Send, {Space}
				
				WinClose
			}
		}
		
		;Se a janela existir, fecha
		if WinExist("Internet Properties"){
			WinClose
		}
		
		;Destrava o bloqueio de inputs
		Sleep, 80
		BlockInput, Off
		BlockInput, MouseMoveOff		
		
		;Dá msg de alerta da alteração feita
		If (statusAlterado = true){
			
			MsgBox, 64, Proxy Alterado, Proxy Ativado
		}
		else{
			MsgBox, 64, Proxy Alterado, Proxy Desativado
		}
	}	
}

;Ctrl + Shift + Escape sai da aplicação
^+Escape::
ExitApp
return