Public Sub fncOnAction(control As IRibbonControl)
On Error GoTo trataerro
Select Case control.id
    Case "btClientes"
        '--------------------------------------------------
        'Formul�rio de clientes aberto pela macro mcrRibbon
        'para voc� ter um exemplo de como usar a macro no
        'atributo onAction de um bot�o na XML
        '--------------------------------------------------
        'DoCmd.OpenForm "frmClientes"
    Case "btFornecedores"
        '--------------------------------
        'Acionado pela macro mcrRibbon
        '--------------------------------
        'DoCmd.OpenForm "frmFornecedores"
    Case "btInfo"
        DoCmd.OpenForm "frmInformativo"
    Case "btusuario"
        DoCmd.OpenForm "frmUsu�rios", , , , , , 1
    Case "btpermissao"
        DoCmd.OpenForm "frmPermiss�esUsu�rios", , , , , , 1
    Case "btSite"
        Call FollowHyperlink(control.Tag)
    Case "btCalculadora"
        Call Shell("calc.exe", vbNormalFocus)
    Case "btsair"
        Call fncFechaForms
    Case "btlogoff"
        Call fncLogoff
    Case "btbackup"
        DoCmd.OpenForm "frmBackup"
    Case "btvincular"
        DoCmd.ShowToolbar "ribbon", acToolbarNo
        DoCmd.OpenForm "frmBarraprogresso", , , , , , 1
    Case Else
        MsgBox "Voc� clicou no bot�o " & control.id, vbInformation, "Aviso"
End Select
sair:
    Exit Sub
trataerro:
    MsgBox "Erro: " & Err.Number & vbCrLf & Err.Description, vbCritical, "Aviso", Err.HelpFile, Err.HelpContext
    Resume sair:
End Sub


-------------------------------------------------------------------------------------------------------------------




Public Function fncMontaEventos(frm As Form)
Dim ctl As control
'-------------------------------------------------------------------------------------------------------
'Esta fun��o deve ser chamada no evento "ao carregar" do formul�rio.  Exemplo: call fncMontaEventos(me)
'-------------------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------
'Percorre todos os controles do Formul�rio informado no argumento frm da fun��o
'------------------------------------------------------------------------------
For Each ctl In frm.Controls
    Select Case ctl.ControlType
        '-----------------------------------------------------------------------------
        'Escrever as fun��es somente nos eventos dos controles tipo caixa de texto
        '-----------------------------------------------------------------------------
        Case acTextBox, acComboBox, acListBox 'caixa texto, combobox e listbox
            '----------------------------------------------------------------------------------------------------
            'Monta e escreve fun��o fncPintacampo nos evento "ao receber foco" da caixa de teexto
            'Lembrando que estamos dentro do fa�o FOR. Significa que todas as caixas de texto receber�o a fun��o
            '----------------------------------------------------------------------------------------------------
            If ctl.OnGotFocus = vbNullString Then ctl.OnGotFocus = "=fncPintaCampo([" & ctl.Name & "],1)"  'Cor Amarela
            '--------------------------------------------------------------------------------------
            'Monta e escreve a fun��o fncPintacampo() no evento "ao Perder Foco" da caixa de Texto
            '--------------------------------------------------------------------------------------
            If ctl.OnLostFocus = vbNullString Then ctl.OnLostFocus = "=fncPintaCampo([" & ctl.Name & "],0)" 'Cor Branca
        Case acCommandButton 'bot�es
            'If ctl.OnGotFocus = vbNullString Then ctl.OnGotFocus = "=fncPintaBotao([" & ctl.Name & "], 255)" 'cor vermelha
            'If ctl.OnLostFocus = vbNullString Then ctl.OnLostFocus = "=fncPintaBotao([" & ctl.Name & "], 0)" 'cor preta
    End Select
Next
End Function