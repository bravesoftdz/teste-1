Private Sub CNPJ_BeforeUpdate(Cancel As Integer)
   DVCNPJ (CStr(Me![CNPJ]))
End Sub
Private Sub CNPJ_Enter()
    Me![CNPJ].InputMask = "00\.000\.000\/0000\-00"
End Sub