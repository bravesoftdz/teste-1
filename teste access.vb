Private Sub txtPesquisa_Change()
On Error Resume Next

    Dim mysql As String
        mysql = "Select * FROM Cliente "
        mysql = mysql & "WHERE NomeCliente LIKE '" & Me!txtPesquisa.Text & "*' ORDER BY NomeCliente;"
        Me!lstClientes.RowSource = mysql

End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
    
        Case vbKeyF2
            Me.lstClientes.SetFocus
            
        Case vbKeyF3
            Me.txtPesquisa.SetFocus
        
        Case Else
    
    End Select
    
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
'Select Case KeyCode
'Case vbKeyF8
'Reexibe
'Case vbKeyF2
''DoCmd.Close
'DoCmd.OpenForm "VENDAS"
'Case vbKeyF3
''DoCmd.Close
'DoCmd.OpenForm "COMPRAS"
'Case vbKeyF4
''DoCmd.Close
'DoCmd.OpenForm "CADASTROS"
'Case vbKeyF5
''DoCmd.Close
'DoCmd.OpenForm "CLIENTES"
'Case vbKeyF7
'Dim Calculadora As Double
'Calculadora = Shell("calc.exe", vbNormalFocus)
'Case vbKeyF6
'Pagamento_Parcelas
'Case vbKeyF11
'AdicionarProduto
'Case vbKeyF10
'Novo
'Case Else
'End Select
End Sub