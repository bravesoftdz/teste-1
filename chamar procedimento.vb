Então devemos criar um procedimento genérico que faça o trabalho independente do formulário a ser liberado, 
em um módulo qualquer, onde todo o projeto tenha acesso:
Sub editaFormulario(argForm As Form)

  'Definindo a cor da seção detalhe para amarelo
  argForm.Section(acDetail).BackColor = vbYellow
  'Definindo a propriedade permitir edição = true
  argForm.AllowEdits = True
  'Atribuindo uma legenda informando que o formulário
  'está liberado para edição
  argForm.Caption = "Atenção: Edição Liberada"

End Sub

Depois basta chamar o procedimento em qualquer formulário que necessite ser liberado para edição, 
passando o formulário como parâmetro para o código:

Sub btnLiberaEdicao_Click()
  
  'Chamando o procedimento que libera
  'formulários e passando como argumento
  'o próprio formulário
  Call editaFormulario(Me)
  
End Sub