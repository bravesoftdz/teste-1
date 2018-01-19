 Option Explicit
						
Digite a seguinte função: 
       Function ShowToolTip (ShowControl As String)
          Dim MyControl As Control
          Dim MyToolTip As Control
          Dim z as Integer
          Const Separator = 80
          On Error Resume Next

          Set MyControl = Screen.ActiveForm(ShowControl)
          Set MyToolTip = Screen.ActiveForm!ToolTip

          If MyToolTip.Visible = False Then
              MyToolTip = MyControl.Tag
              MyToolTip.Left = MyControl.Left + (Separator * 2)
              MyToolTip.Top = MyControl.Top + MyControl.Height + Separator
              MyToolTip.Visible = True

              ' Optional: Display ToolTip on the Status Bar.
              z = SysCmd(SYSCMD_SETSTATUS, MyToolTip.value)
          End If

       End Function



Private Sub tglFilter_Click()
    With tglFilter
        If .Value = True Then
            .Caption = "P/T"
            .StatusBarText = "only full-timers"
            DoCmd.ApplyFilter , "[Hours]=40"
        ElseIf .Value = False Then
            .Caption = "All"
            .StatusBarText = "only part-timers"
            DoCmd.ApplyFilter , "[Hours]<40"
        Else
            .Caption = "F/T"
            .StatusBarText = "all employees"
            DoCmd.ShowAllRecords
            .SetFocus 'to activate the button's statusbar-text
        End If
    End With
End Sub


Desconto

IdDetalhePedido































