'Código Padrão para Tratamento de Exceção

Sub CódigoPadrão()
    Const sRotina = "CódigoPadrão"
    
    On Error GoTo Erro
    
    Dim l As Long
    
    l = 1 / 0
    '
    'código que pula se erro acontecer
    '

Fim:
    '
    'código de finalização, limpeza de memória, etc.
    '
    
    Exit Sub

Erro:
    MsgBox "Erro " & Err.Number & " na rotina '" & sRotina & "'." & vbCrLf & _
      "Descrição do erro: " & Err.Description, vbCritical, "Erro!"
    GoTo Fim
End Sub