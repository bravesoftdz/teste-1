If Me.txtValor.Text = 0 Then

    Form_frmFuncionarios.Caption = "ID"
    
ElseIf Me.txtValor.Text = 1 Then

    Form_frmFuncionarios.Caption = "Nome"
    
ElseIf Me.txtValor.Text = 2 Then

   Form_frmFuncionarios.Caption = "funcao"
   
End If


Dim objeto As Integer
objeto = Me.txtValor.Value

Select Case objeto

Case 0
Form_frmFuncionarios.Caption = "0"

Case 1
Form_frmFuncionarios.Caption = "1"

Case 2
Form_frmFuncionarios.Caption = "2"

End Select

private void btNumero(object sender, EventArgs e)
        {

            if (ultimoNumero == 0)
            {
                txtResultado.Text = (sender as Button).Text;

            }







