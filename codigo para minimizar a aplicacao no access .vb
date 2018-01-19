


'<<<---------------FUNCAO PARA MINIMIZAR A APLICACAO EM ACCESS--------------------->>>

Option Compare Database
Option Explicit
Global Const SW_HIDE = 0
Global Const SW_SHOWMINIMIZED = 2
Global Const SW_SHOWMAXIMIZED = 3

'<<<-----OBS.: PARA DAR CERTO O CODIGO USAR o "PtrSafe" ANTES DO Function---------->>>

Private Declare PtrSafe Function apiShowWindow Lib "user32" Alias "ShowWindow" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long

Public Function AUTOEXEWALDO()
DoCmd.OpenForm "frmServicos", acNormal

End Function


Function fSetAccessWindow(nCmdShow As Long)
Dim loX As Long
Dim loForm As Form
loX = apiShowWindow(hWndAccessApp, nCmdShow)
End Function




'<<<---------------FUNCAO MAIUSCULAS------------------------------------------------>>>



function Maiusculas (cTexto As String)As String
	
    Dim cRetorno As String

    cRetorno = Ucase(cTexto)
    Maiusculas = cRetorno

end function

PtrSafe