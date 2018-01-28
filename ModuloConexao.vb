Attribute VB_Name = "ModuloConexao"
Option Compare Database

'variavel ondem ser�o colocados os comandos SQL, como Insert, Update e Select
Public Comando As String

'variavel que ir� fazer a conexao entre a aplica��o e o banco de dados,
'atraves dele poderemo fazer a execu��o de comandos sql como o insert e update
Public banco As Database

'variavel ondem ser�o passados comandos SQl do tipo select que v�o preenche-lo
'e colocar�o os dados em uma especia de tabela virtual na mem�ria RAM
Public dataset As Recordset

Function Conecta()
    
    'incializa a variavel banco com o valor de CurrentDB, oq seria currentDB?!
    'CurrentDB significa que o banco a ser usado � o banco local
    Set banco = CurrentDb

End Function

Function valida_selecao()

    'inicializa o dataset, executa o comando sql passado atrav�s da variav�l Comando
    'e preenche o dataset na mem�ria
    Set dataset = banco.OpenRecordset(Comando, dbOpenDynaset)

End Function
