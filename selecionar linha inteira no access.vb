Private Sub Form_Current()
If Me.SelHeight = 0 Then
Me.SelLeft = 1
Me.SelHeight = 1
Me.SelWidth = 15
Me.Refresh
End If
End Sub

DoCmd.RunCommand acCmdSelectRecord