
Private Sub cboPesquisa_AfterUpdate()

    Dim rs As Object

    Set rs = Me.Recordset.Clone
    rs.FindFirst "[cliID] = " & Str(Nz(Me![cboPesquisa], 0))
    If Not rs.EOF Then Me.Bookmark = rs.Bookmark

End Sub

Private Sub cmdAtualizar_Click()

   Dim mysql As String
    
    On Error Resume Next
    
    mysql = "Select * FROM tblClientes "
    Me.lstRegistros.RowSource = mysql
    
    Refresh

End Sub

Private Sub cmdFechar_Click()

    Call fechaFormulario(Me)

End Sub

Private Sub cmdNovo_Click()

    Call registroNovo(Me)
    Me.cliRazaoSocial.SetFocus

End Sub

Private Sub cliRazaoSocial_AfterUpdate()
    Dim contaLista As Integer
    Dim msg As String
    
    contaLista = Me.lstRegistros.ListCount
    'MsgBox contaLista
    If contaLista < 1 Then

        Me.cliRazaoSocial.SetFocus

    Else

        msg = "Este cliente já está cadastrado," & vbCrLf & "Digite outro nome ou atualize o cadastro"
        MsgBox msg
        DoCmd.RunCommand acCmdUndo
        Me.cliRazaoSocial.SetFocus

    End If

End Sub

Private Sub cliRazaoSocial_Change()

    Dim mysql As String
    
    On Error Resume Next
    
    mysql = "Select * FROM tblClientes "
    mysql = mysql & "WHERE cliRazaoSocial LIKE '" & Me!cliRazaoSocial.Text & "*' ORDER BY cliRazaoSocial;"
    Me.lstRegistros.RowSource = mysql

End Sub

Private Sub lstRegistros_AfterUpdate()
    Dim IdRegistro As Integer
    Dim rs As Object
    
    IdRegistro = Str(lstRegistros)
    Me.txtPesquisa = Empty
    
    Set rs = Me.Recordset.Clone
    rs.FindFirst "[cliID] = " & IdRegistro
    If Not rs.EOF Then Me.Bookmark = rs.Bookmark
    
    'Me.catDescricao.SetFocus


End Sub

Private Sub txtPesquisa_Change()
    
    Dim mysql As String
    
    On Error Resume Next
    
        mysql = "Select * FROM tblClientes "
        mysql = mysql & "WHERE cliRazaoSocial LIKE '" & Me!txtPesquisa.Text & "*' ORDER BY cliRazaoSocial;"
        Me.lstRegistros.RowSource = mysql
        
        
End Sub


