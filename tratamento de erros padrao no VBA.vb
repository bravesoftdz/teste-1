'C�digo Padr�o para Tratamento de Exce��o

Sub C�digoPadr�o()
    Const sRotina = "C�digoPadr�o"
    
    On Error GoTo Erro
    
    Dim l As Long
    
    l = 1 / 0
    '
    'c�digo que pula se erro acontecer
    '

Fim:
    '
    'c�digo de finaliza��o, limpeza de mem�ria, etc.
    '
    
    Exit Sub

Erro:
    MsgBox "Erro " & Err.Number & " na rotina '" & sRotina & "'." & vbCrLf & _
      "Descri��o do erro: " & Err.Description, vbCritical, "Erro!"
    GoTo Fim
End Sub