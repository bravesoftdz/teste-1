Private Sub Combina��o473_AfterUpdate()

    Dim rs As Object

    Set rs = Me.Recordset.Clone
    rs.FindFirst "[CodigoCliente] = " & Str(Nz(Me![Combina��o473], 0))
    If Not rs.EOF Then Me.Bookmark = rs.Bookmark

End Sub