Private Sub Comando27_Click()
On Error GoTo Err_Comando27_Click

    Dim stDocName As String
    Dim stLinkCriteria As String

    stDocName = "Frm Data Pedido"
    DoCmd.OpenForm stDocName, , , stLinkCriteria

Exit_Comando27_Click:
    Exit Sub

Err_Comando27_Click:
    MsgBox Err.Description
    Resume Exit_Comando27_Click
    
End Sub
