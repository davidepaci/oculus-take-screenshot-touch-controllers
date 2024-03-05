; Made with <3 by biosignal

; EDIT THIS AT WILL
global OCULUS_FOLDER = "C:\Program Files\Oculus"
global SCREENSHOT_PARENT_FOLDER = A_MyDocuments ; So the screenshot folder will be My Documents\Oculus Screenshots\

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%

#include auto_oculus_touch.ahk

; Start the Oculus sdk.
InitOculus()

DllCall("auto_oculus_touch\poll")
ResetFacing(0)
ResetFacing(1)

; Open Oculus Mirror
;Run OculusMirror.exe, %OCULUS_FOLDER% . "\Support\oculus-diagnostics", max
;Run C:\Program Files\Oculus\Support\oculus-diagnostics\OculusMirror.exe, , max
Run %OCULUS_FOLDER%\Support\oculus-diagnostics\OculusMirror.exe
WinWait, Oculus Mirror
WinMaximize

; Create Oculus Screenshots folder in the specified folder if it doesn't exist
IfNotExist, %SCREENSHOT_PARENT_FOLDER%\Oculus Screenshots
	FileCreateDir, %SCREENSHOT_PARENT_FOLDER%\Oculus Screenshots

; Set window as active, move mouse away then take a screenshot
TakeScreenshot()
{
	If WinExist("Oculus Mirror") {
		winActivate
		WinMaximize
	} else {
		Run %OCULUS_FOLDER%\Support\oculus-diagnostics\OculusMirror.exe
		WinWait, Oculus Mirror
		WinMaximize
	}
	Run, IrfanView\i_view32.exe /capture=3 /convert=%SCREENSHOT_PARENT_FOLDER%\Oculus Screenshots\capture_$U(`%Y-`%m-`%d_`%H`%M`%S).png
}

Loop {
	Poll()

	leftIndexTrigger  := GetTrigger(LeftHand,  IndexTrigger)
	rightIndexTrigger := GetTrigger(RightHand, IndexTrigger)
	down     := GetButtonsDown()
	pressed  := GetButtonsPressed()
	released := GetButtonsReleased()
	touchDown     := GetTouchDown()
	touchPressed  := GetTouchPressed()
	touchReleased := GetTouchReleased()

	if pressed & ovrLThumb
	if pressed & ovrRThumb
	if (leftIndexTrigger > 0.50)
	if (rightIndexTrigger > 0.50)
			TakeScreenshot()
}