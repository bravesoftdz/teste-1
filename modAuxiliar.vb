Attribute VB_Name = "modAuxiliar"
Option Compare Database
Option Explicit

Public Function DataAtulizacaoCadastro(argForm As Form)
Dim retorno As Date

    retorno = Date
    

End Function

'Código Padrão para Tratamento de Exceção


Sub DesabilitaBotoes(argForm As Form)
Dim ctl As Control
    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                ctl.Enabled = False
                
            Case acTextBox, acCheckBox
               
        End Select
    Next ctl

End Sub

Sub HabilitaBotoes(argForm As Form)
Dim ctl As Control
    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                ctl.Enabled = True
                
            Case acTextBox, acCheckBox
               
        End Select
        
    Next ctl

End Sub

Sub PintaControles(argForm As Form)
Dim ctl As Control

    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                
                
            Case acTextBox, acComboBox
                
                ctl.BackColor = 16443110
                
               
        End Select
    Next ctl

End Sub

Sub converteLetrasParaMaiusculas(argForm As Form)
On Error Resume Next
Dim ctl As Control
    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                
                
            Case acTextBox, acListBox, acComboBox
                ctl = StrConv(ctl, vbUpperCase)
               
        End Select
        
    Next ctl

End Sub

Sub DesabilitaCampos(argForm As Form)
Dim ctl As Control
    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                     
                
            Case acTextBox, acComboBox, acCheckBox
                ctl.Locked = True
               
        End Select
    Next ctl

End Sub

Sub HabilitaCampos(argForm As Form)
Dim ctl As Control
    For Each ctl In argForm.Controls
        Select Case ctl.ControlType
            Case acCommandButton
                
                
            Case acTextBox, acComboBox, acCheckBox
                ctl.Locked = False
               
        End Select
    Next ctl

End Sub

Sub ExcluirRegistro(argForm As Form)
On Error Resume Next
Dim msg As String
    msg = MsgBox("Deseja realmente excluir este registro?", vbYesNo, "CUIDADO")
    
    If msg = vbYes Then
    
        DoCmd.RunCommand acCmdDeleteRecord
        
    Else
    
    End If



End Sub

Public Sub limpaTabelas()
 
    
    
    DoCmd.RunSQL "DELETE * FROM tblMovimentos"
    DoCmd.RunSQL "DELETE * FROM tblVendas"
    DoCmd.RunSQL "DELETE * FROM tblDetalhesVenda"
    DoCmd.RunSQL "DELETE * FROM tblDetalhesCompra"
    DoCmd.RunSQL "DELETE * FROM tblCompras"
    DoCmd.RunSQL "DELETE * FROM tblProdutos"
    DoCmd.RunSQL "DELETE * FROM tblClientes"
    DoCmd.RunSQL "DELETE * FROM tblTransacoesDeEstoque"
    
     
End Sub
























