Como "*"&[Digite o criterio da pesquisa]&"*"
As aplica��es do Like s�o in�meras, veja:

Na grade da consulta:

a) Like "*" & [Digite qualquer parte da palavra] & "*"
b) Like "*" & [Forms]![NomeDoForm]![NomeDoCampo] & "*"


No VBA:

a) DoCmd.ApplyFilter "", "[Cliente] like '*" & [Forms]![frmLocalizar]![Cliente] & "*'"
b) If Me!Palavra Like "A*" Then

No Select:

SELECT Tabela.Palavra
FROM Tabela
WHERE Tabela.Palavra LIKE "*ca*";