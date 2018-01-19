Private Sub btnExcluir_Click()

    Call ExcluirRegistro(Me)

End Sub

Private Sub btnFechar_Click()

    Call fechaFormulario(Me)

End Sub

Private Sub btnNovo_Click()

    If btnNovo.Caption = "Novo" Then
	
        Call registroNovo(Me)
        Call DesabilitaBotoes(Me)
        Call HabilitaCampos(Me)
        btnNovo.Enabled = True
        btnNovo.Caption = "Salvar"
        
    Else
    
        btnNovo.Caption = "Novo"
        DoCmd.RunCommand acCmdSaveRecord
        Call HabilitaBotoes(Me)
        Call DesabilitaCampos(Me)
        
    End If

End Sub

Private Sub btnEditar_Click()

    If btnEditar.Caption = "Editar" Then
        Call HabilitaCampos(Me)
        Call DesabilitaBotoes(Me)
        btnEditar.Enabled = True
        btnEditar.Caption = "Finalizar"
        
    Else
        Call DesabilitaCampos(Me)
        Call HabilitaBotoes(Me)
        btnEditar.Caption = "Editar"
    
    End If

End Sub


Private Sub btnPrimeiro_Click()

    Call registroPrimeiro

End Sub


Private Sub btnUltimo_Click()

    Call registroUltimo

End Sub


Private Sub btnProximo_Click()

    Call registroProximo

End Sub


Private Sub btnAnterior_Click()

    Call registroAnterior

End Sub
