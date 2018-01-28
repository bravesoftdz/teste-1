Ent�o devemos criar um procedimento gen�rico que fa�a o trabalho independente do formul�rio a ser liberado, 
em um m�dulo qualquer, onde todo o projeto tenha acesso:
Sub editaFormulario(argForm As Form)

  'Definindo a cor da se��o detalhe para amarelo
  argForm.Section(acDetail).BackColor = vbYellow
  'Definindo a propriedade permitir edi��o = true
  argForm.AllowEdits = True
  'Atribuindo uma legenda informando que o formul�rio
  'est� liberado para edi��o
  argForm.Caption = "Aten��o: Edi��o Liberada"

End Sub

Depois basta chamar o procedimento em qualquer formul�rio que necessite ser liberado para edi��o, 
passando o formul�rio como par�metro para o c�digo:

Sub btnLiberaEdicao_Click()
  
  'Chamando o procedimento que libera
  'formul�rios e passando como argumento
  'o pr�prio formul�rio
  Call editaFormulario(Me)
  
End Sub