Private Sub btnPGTO_Click()
    If PagamentoEfetuado = True Then
        MsgBox "Esta parcela já foi quitada", vbInformation, "AVISO"
        txtPesquisa = Empty
        DoCmd.GoToRecord , , acNext
        txtPesquisa.SetFocus
        Refresh
        Exit Sub
    Else
        If txtValorAbatido = 0 Or IsNull(txtValorAbatido) Then
            DataPagamento = Date
            'insere o valor na tabela movimentos
            DoCmd.RunSQL ("INSERT INTO Movimentos(Descricao,Data,Entrada)" & _
                                          "VALUES('REC PARCELA',DataPagamento,ParcelaCorrigida);")
            DoCmd.RunSQL ("INSERT INTO Entradas(DataEntrada,TipoEntrada,ValorEntrada,CodigoPedido,NomeCliente)" & _
                                        "VALUES(txtData,'Pag.Parcela',ParcelaCorrigida,CodigoPedido,NomeCliente);")
            PagamentoEfetuado = True
            ValorAbatido = ValorDaParcela
            txtPesquisa = Empty
            DoCmd.GoToRecord , , acNext
            Refresh
            MsgBox "Pagamento efetuado com suscesso", vbInformation, "AVISO"
            Exit Sub
        ElseIf txtValorAbatido > ValorDaParcela Then
            DataPagamento = Date
            'insere o valor na tabela movimentos
            DoCmd.RunSQL ("INSERT INTO Movimentos(Descricao,Data,Entrada)" & _
                                          "VALUES('REC PARCELA',DataPagamento,ParcelaCorrigida);")
            DoCmd.RunSQL ("INSERT INTO Entradas(DataEntrada,TipoEntrada,ValorEntrada,CodigoPedido,NomeCliente)" & _
                                        "VALUES(txtData,'Pag.Parcela',ParcelaCorrigida,CodigoPedido,NomeCliente);")
            txtValorAbatido = txtValorAbatido - ParcelaCorrigida
            PagamentoEfetuado = True
            ValorAbatido = ValorDaParcela
            txtPesquisa = Empty
            DoCmd.GoToRecord , , acNext
            Refresh
            MsgBox "Pagamento efetuado com suscesso", vbInformation, "AVISO"
            MsgBox "opt 1"
            Exit Sub
        Else
            If txtValorAbatido > Me.ParcelaCorrigida Then
                DataPagamento = Date
                'insere o valor na tabela movimentos
                DoCmd.RunSQL ("INSERT INTO Movimentos(Descricao,Data,Entrada)" & _
                                              "VALUES('REC PARCELA',DataPagamento,ParcelaCorrigida);")
                DoCmd.RunSQL ("INSERT INTO Entradas(DataEntrada,TipoEntrada,ValorEntrada,CodigoPedido,NomeCliente)" & _
                                            "VALUES(txtData,'Pag.Parcela',ParcelaCorrigida,CodigoPedido,NomeCliente);")
                txtValorAbatido = txtValorAbatido - ParcelaCorrigida
                PagamentoEfetuado = True
                ValorAbatido = ValorDaParcela
                txtPesquisa = Empty
                DoCmd.GoToRecord , , acNext
                Refresh
                MsgBox "Pagamento efetuado com suscesso", vbInformation, "AVISO"
                MsgBox "opt 2"
                Exit Sub
            Else
                DataPagamento = Date
                'insere o valor na tabela movimentos
                DoCmd.RunSQL ("INSERT INTO Movimentos(Descricao,Data,Entrada)" & _
                                              "VALUES('REC PARCELA',DataPagamento,txtValorAbatido);")
                DoCmd.RunSQL ("INSERT INTO Entradas(DataEntrada,TipoEntrada,ValorEntrada,CodigoPedido,NomeCliente)" & _
                                            "VALUES(txtData,'Pag.Parcela',txtValorAbatido,CodigoPedido,NomeCliente);")
                ValorAbatido = Nz(ValorAbatido, 0) + txtValorAbatido
                txtValorAbatido = 0
                txtPesquisa = Empty
                Me.Recalc
                MsgBox "Pagamento parcial efetuado com suscesso", vbInformation, "AVISO"
                MsgBox "opt 3"
                Exit Sub
                If Me.ParcelaCorrigida = 0 Then
                    Me.PagamentoEfetuado = True
                    Me.Recalc
                    MsgBox "opt 4"
                    Exit Sub
                End If
                
            End If
            
        End If
        
    End If
    
End Sub
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>=<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Private Sub btnAtualizar_Click()

    If FilterOn = False Then
        
        MsgBox "Você precisa selecionar um cliente na caixa de seleção", vbInformation, "AVISO"
        
    Else
        DoCmd.GoToRecord , , acFirst
        For i = 1 To txtNumeroParcelas
        
            Multa = txtMulta
            JurosDia = txtJurosMes / 30
            Me.DiasAtraso = DateDiff("d", VencimentoParcela, Date)
            
            If Me.DiasAtraso > 3 Then
                Me.ValorRestante = Me.ValorDaParcela - Nz(Me.ValorAbatido, 0)
                Me.ParcelaCorrigida = ((Me.ValorRestante * Me.JurosDia) * Me.DiasAtraso / 100) + Me.ValorRestante + Me.Multa
                
            Else
                'Me.ValorRestante
            End If
            
            
            If PagamentoEfetuado = True Then
                ValorAbatido = ValorDaParcela
            Else
                'ValorAbatido = 0
            End If
            
            DoCmd.GoToRecord , , acNext
        
        Next i
        
    Refresh
    End If
    Me.btnPGTO.Enabled = True
    DoCmd.GoToRecord , , acFirst
End Sub
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>=<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Public Sub OpenRecorset()
Dim i As Integer
Dim db As Database
Dim rs As Recordset

Set db = CurrentDb
Set rs = db.OpenRecordset("tblCategorias")
For i = 0 To rs.RecordCount - 1
    Debug.Print StrConv(rs.Fields("Descricao"), vbUpperCase)
    rs.MoveNext
Next i
'    If Not rs.EOF Then Me.Bookmark = rs.Bookmark
rs.Close
Set rs = Nothing
db.Close
'MsgBox "linha 1" & vbNewLine & "linha 2" & vbNewLine & "linha 3"
End Sub