Private Sub cboCargoDoContato_AfterUpdate()
    If cboCargoDoContato = "" Then
        Me.Filter = ""   ' Limpa o filtro do formulário
        cboCargoDoContato = ""
    Else
        DoCmd.ApplyFilter , "CargoDoContato = '" & cboCargoDoContato & "'"
    End If
End Sub




If Not IsMissing(nMessage) Then
If Msg <> "" Then
let Efemero = SysCmd(acSysCmdSetStatus, nMessage)
Else
let Efemero = SysCmd(acSysCmdClearStatus)
End If
Else
Efemero = SysCmd(acSysCmdClearStatus)
End If

End Sub