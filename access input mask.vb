Private Sub CNPJ_BeforeUpdate(Cancel As Integer)
   DVCNPJ (CStr(Me![CNPJ]))
End Sub
Private Sub CNPJ_Enter()
    Me![CNPJ].InputMask = "00\.000\.000\/0000\-00"
End Sub

Private Sub Cr�dito_Click()
On Error GoTo Err_CR�DITO_DblClick

    Dim stDocName As String
    Dim stLinkCriteria As String
    stDocName = "ACCRED02"
    stLinkCriteria = "[C�d_Rec]=" & Me![C�D_REC]
    'FECHAR
    DoCmd.OpenForm stDocName, , , stLinkCriteria

Exit_CR�DITO_DblClick:
    Exit Sub

Err_CR�DITO_DblClick:
    MsgBox Err.Description
    Resume Exit_CR�DITO_DblClick
End Sub