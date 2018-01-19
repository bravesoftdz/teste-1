Dim rs As Object

Set rs = Me.Recordset.Clone
rs.FindFirst "[DescricaoDoProduto] = '" & Me![lista9] & "'"
If Not rs.EOF Then Me.Bookmark = rs.Bookmark

