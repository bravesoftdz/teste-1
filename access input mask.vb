Private Sub CNPJ_BeforeUpdate(Cancel As Integer)
   DVCNPJ (CStr(Me![CNPJ]))
End Sub
Private Sub CNPJ_Enter()
    Me![CNPJ].InputMask = "00\.000\.000\/0000\-00"
End Sub

Private Sub Crédito_Click()
On Error GoTo Err_CRÉDITO_DblClick

    Dim stDocName As String
    Dim stLinkCriteria As String
    stDocName = "ACCRED02"
    stLinkCriteria = "[Cód_Rec]=" & Me![CÓD_REC]
    'FECHAR
    DoCmd.OpenForm stDocName, , , stLinkCriteria

Exit_CRÉDITO_DblClick:
    Exit Sub

Err_CRÉDITO_DblClick:
    MsgBox Err.Description
    Resume Exit_CRÉDITO_DblClick
End Sub