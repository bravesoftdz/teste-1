Attribute VB_Name = "ModuloConexao"
Option Compare Database

'variavel ondem serão colocados os comandos SQL, como Insert, Update e Select
Public Comando As String

'variavel que irá fazer a conexao entre a aplicação e o banco de dados,
'atraves dele poderemo fazer a execução de comandos sql como o insert e update
Public banco As Database

'variavel ondem serão passados comandos SQl do tipo select que vão preenche-lo
'e colocarão os dados em uma especia de tabela virtual na memória RAM
Public dataset As Recordset

Function Conecta()
    
    'incializa a variavel banco com o valor de CurrentDB, oq seria currentDB?!
    'CurrentDB significa que o banco a ser usado é o banco local
    Set banco = CurrentDb

End Function

Function valida_selecao()

    'inicializa o dataset, executa o comando sql passado através da variavél Comando
    'e preenche o dataset na memória
    Set dataset = banco.OpenRecordset(Comando, dbOpenDynaset)

End Function
