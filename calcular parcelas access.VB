
If (DLookup("NumeroDaParcela", "Parcelas", "[CodigoPedido] = " & [CodigoPedido]) = 1) Then
    MsgBox "Você ja parcelou esta venda DELETE para reparcelar"
    Exit Sub
    
ElseIf (Me.TotalDoPedido > 0) And (Me.NumeroDeParcelas > 0) Then
    Dim db
    Dim rs
    Dim i As Integer
    Set db = CurrentDb
    Set rs = db.OpenRecordset("Parcelas")
    
    For i = 1 To Me.NumeroDeParcelas
        rs.AddNew
        rs("CodigoPedido") = Me.CodigoPedido
        rs("NumeroDaParcela") = i
        rs("ValorDaParcela") = Round(Me.TotalDoPedido / Me.NumeroDeParcelas, 2)
        rs("VEncimentoParcela") = DateAdd("m", i, Form_VENDAS.DataPedido)
        rs.Update
        
    Next
    rs.Close
    db.Close
    Refresh
    
 Else
 
 End If