Public Sub fncOnAction(control As IRibbonControl)
On Error GoTo trataerro
Select Case control.id
    Case "btClientes"
        '--------------------------------------------------
        'Formulário de clientes aberto pela macro mcrRibbon
        'para você ter um exemplo de como usar a macro no
        'atributo onAction de um botão na XML
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
        DoCmd.OpenForm "frmUsuários", , , , , , 1
    Case "btpermissao"
        DoCmd.OpenForm "frmPermissõesUsuários", , , , , , 1
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
        MsgBox "Você clicou no botão " & control.id, vbInformation, "Aviso"
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
'Esta função deve ser chamada no evento "ao carregar" do formulário.  Exemplo: call fncMontaEventos(me)
'-------------------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------
'Percorre todos os controles do Formulário informado no argumento frm da função
'------------------------------------------------------------------------------
For Each ctl In frm.Controls
    Select Case ctl.ControlType
        '-----------------------------------------------------------------------------
        'Escrever as funções somente nos eventos dos controles tipo caixa de texto
        '-----------------------------------------------------------------------------
        Case acTextBox, acComboBox, acListBox 'caixa texto, combobox e listbox
            '----------------------------------------------------------------------------------------------------
            'Monta e escreve função fncPintacampo nos evento "ao receber foco" da caixa de teexto
            'Lembrando que estamos dentro do faço FOR. Significa que todas as caixas de texto receberão a função
            '----------------------------------------------------------------------------------------------------
            If ctl.OnGotFocus = vbNullString Then ctl.OnGotFocus = "=fncPintaCampo([" & ctl.Name & "],1)"  'Cor Amarela
            '--------------------------------------------------------------------------------------
            'Monta e escreve a função fncPintacampo() no evento "ao Perder Foco" da caixa de Texto
            '--------------------------------------------------------------------------------------
            If ctl.OnLostFocus = vbNullString Then ctl.OnLostFocus = "=fncPintaCampo([" & ctl.Name & "],0)" 'Cor Branca
        Case acCommandButton 'botões
            'If ctl.OnGotFocus = vbNullString Then ctl.OnGotFocus = "=fncPintaBotao([" & ctl.Name & "], 255)" 'cor vermelha
            'If ctl.OnLostFocus = vbNullString Then ctl.OnLostFocus = "=fncPintaBotao([" & ctl.Name & "], 0)" 'cor preta
    End Select
Next
End Function