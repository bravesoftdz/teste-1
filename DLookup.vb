

If (Not IsNull(DLookup("[CodigoPedido]", "DetalhePedido", _
        "[CodigoProduto] ='" & Me!Me!txtCodigoProduto & "'"))) Then
        MsgBox "O produto j� est� cadastrado na tabela Vendas.", _
            vbInformation, "Produtos"
        Cancel = True 'cancela o evento.
        'Me!IDDoDetalheDaVenda.Undo  'desfaz a digita��o.
        DoCmd.RunCommand acCmdUndo
        
    End If


If (Not IsNull(DLookup("[IDDoDetalheDaVenda]", "DetalhesDaVenda", _
        "[IDDoDetalheDaVenda] ='" & Me!txtCodigoProduto & "'"))) Then
        MsgBox "O produto j� est� cadastrado na tabela Vendas.", _
            vbInformation, "Produtos"
        Cancel = True 'cancela o evento.
        'Me!IDDoDetalheDaVenda.Undo  'desfaz a digita��o.
        DoCmd.RunCommand acCmdUndo
        
    End If