Private Sub Command1_Click()
Dim X As Integer
On Error GoTo TrataErro
'Poder� lan�ar um erro se Text1 tiver vazio ou contiver letras:
X = CInt(Text1.Text)
MsgBox "Passou por aqui ?!"
Exit Sub
TrataErro:
    If Err.Number = 13 Then
        MsgBox "Erro de Convers�o de Letra para N�mero ! "
        MsgBox "Adoraremos X = 0"
        Text1.Text = "0"
        Resume
    End If
End Sub