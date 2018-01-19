Public Function fncPermissões(NomeForm As Form)
Dim idFun As Long
On Error Resume Next
idFun = fncCapturaIdFuncao(NomeForm.Name, 102030)
If Nz(fncBloquear(idFun, login.id, mtBloquear), True) = True Or login.id = 0 Then
    MsgBox "Acesso bloqueado...", vbInformation, "Aviso"
    DoCmd.Close acForm, NomeForm.Name
    Exit Function
End If
NomeForm.AllowEdits = Nz(fncBloquear(idFun, login.id, mtAtualizar), False)
NomeForm.AllowDeletions = Nz(fncBloquear(idFun, login.id, mtExcluir), False)
NomeForm.AllowAdditions = Nz(fncBloquear(idFun, login.id, mtInserir), False)
End Function