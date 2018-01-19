


>>>>>>>>>>>>>CONTADOR DE REGISTROS<<<<<

Insira uma caixa de texto e na fonte do controle digite.:


=[CurrentRecord] & " de " & Contar(*)


>>>>>>>>>>>>>FILTRO<<<<<<<<<<<<<<<<<<<<

Private Sub cbo_consulta_contatos_AfterUpdate()
DoCmd.ApplyFilter , "itvenda_devolvido = " & Me!sel_devolvido'.Column(0)
'Me!cont_endereco.SetFocus
'Me!cbo_consulta_contatos = Null

End Sub



>>>>>>>>>>>>>TITULO<<<<<<<<<<<<<<<<<<<<


=Substituir("Ordem de Compra |";"|";Nz([cont_codigo];" (Novo)"))


CONDICAO WHERE
="[serv_contato]=" & [cont_codigo]


#CB4205


="[ven_codigo]=" & [ven_codigo]


primeira letra em maiuscula

'cli_nom = StrConv(cli_nom, vbProperCase)



Private Sub RG_AfterUpdate()
Dim t As Recordset
Set t = CurrentDb.OpenRecordset("select * from consultas where rg ='" & Me.RG & "'")
If t.RecordCount > 0 Then
Me.PACIENTE = t!PACIENTE
Me.TEL = t!TEL
Me.ENDERECO_ATUAL = t![endereco atual]
Me.PREESCRIÇÃO = t!PREESCRIÇÃO
Me.ESPECIALIDADE.SetFocus
End If
End Sub






Private Sub C_Click()
For i = 1 To Form_FCondicaoPagamento.NumeroDeParcelas  'Insere as Parcela na tbl2
        Me.[NumeroDaParcela] = i
        Me.NumeroDeParcelas = Form_FCondicaoPagamento.NumeroDeParcelas
        Me.ValorDaParcela = Form_FCondicaoPagamento.TotalDoPedido / NumeroDeParcelas
        
        DoCmd.RunCommand acCmdSaveRecord
        DoCmd.RunCommand acCmdRecordsGoToNext
        
        DateAdd("m", i - 1, Me.data)
        
    Next
Refresh
End Sub

>>>>>>--------------------------------------------<<<<<<<

Vai para o primeiro registro
    DoCmd.GoToRecord , , acFirst

Vai para o registro anterior
    DoCmd.GoToRecord , , acPrevious
    
Vai para o próximo registro
    DoCmd.GoToRecord , , acNext

Vai para o último registro
    DoCmd.GoToRecord , , acLast

Vai para novo registro
    DoCmd.GoToRecord , , acNewRec


Private Sub txtPesquisa_Change()
Me.listaClientes.RowSource = "SELECT * FROM Cliente WHERE NomeCliente LIKE '" & Me.txtPesquisa.Text & "*' "

End Sub


="[CodigoCarne] = " & Str(Nz([Screen].[ActiveControl];0))
















