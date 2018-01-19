Option Compare Database


'variavel que guardara o código gerado no método GerarCodigo,
'e que sera usado para Cadastrar Claro
Public NumCod As Integer


Private Sub CmdAleatorio_Click()
    'para realizar o medodo aleatório temos que saber quantos resgistro tem na tabela
    Comando = "Select count(*) as quantidade from TabCadLivro" ' conta quantos registro há na memória e cria um campo virtualmente chamado quantidades
    valida_selecao
    Dim qtd As Integer
    qtd = dataset("quantidade")
    Randomize (Second(Time))
    Dim codigo As Integer
    codigo = Int(Rnd * qtd) + 1
    Comando = "select * from TabCadLivro where Codigo=" & codigo
    valida_selecao 'preenche o dataser
    TxtCodigo = dataset("Codigo")
    TxtLivro = dataset("Livro")
    TxtAutor = dataset("Autor")
    TxtEditora = dataset("Editora")
    TxtDescricao = dataset("Descricao")
    TxtAno = dataset("Ano")
End Sub

Private Sub CmdAlterar_Click()
    'vamos criar o comando do update
    Comando = "update TabCadLivro set Livro='" & TxtLivro & "', Autor='" & TxtAutor & "', Editora='" & TxtEditora & "',Descricao='" & TxtDescricao & "',Ano=" & TxtAno & " where Codigo=" & TxtCodigo 'atualiza as informações do codigo informado
    'regras do Update
    '1º Update TabelaASerAtualizada set Campo1=Valor1,Campo2=Valor2 where Codigo=Registro que era mudado
    'lembrando se não ultilizar o where , serão atualizado todos os registros da tabela
    banco.Execute (Comando)
    MsgBox ("Atualização Efetuada com Sucesso!"), vbInformation + vbOKOnly, "Sucesso ao Atualizar"
    'temos que voltar os botões para enable = true e limpar as txts
    Limpar 'chama metodo limpar
    CmdCadastrar.Enabled = True
    CmdConsultar.Enabled = True
    CmdAlterar.Enabled = False
    CmdExcluir.Enabled = False
    TxtCodigo.Enabled = True
End Sub

Private Sub CmdCadastrar_Click()
'Ah, jah estav esquecendo. Só irá efetuar o cadastro se as Txts estiverem preenchidas!
    If TxtLivro <> "" And TxtAutor <> "" And TxtEditora <> "" And TxtAno <> "" Then
    
        'chama o metodo que haviamos criado
        GerarCodigo
        
        'regras do insert
        '1º Insert Into TabelaNaQualSerãoInseridoOsDados(Campo1,Campo2,Campo3)
        'values (AspaDuplaSeForNumero,AspasSimples+AspasDuplasSeForTexto)
        Comando = "Insert into TabCadLivro(Codigo, Livro, Autor,Editora,Descricao,Ano) values (" & TxtCodigo & ",'" & TxtLivro & "','" & TxtAutor & "','" & TxtEditora & "','" & TxtDescricao & "'," & TxtAno & ")"
        
        
        ' executa o nosso comando Insert com os dados que foram colocados no formulário
        banco.Execute (Comando)
        MsgBox ("Os dados foram cadastrados com sucesso!"), vbInformation + vbOKOnly, "Cadastro"
        'agora temos que limpar todas as caixas de texto, então vamos criar um metodo chamado Limpar
        Limpar 'chamamos o metodo aki!
    Else
        MsgBox ("Necessário informar os dados para efetuar o cadastro!"), vbInformation + vbOKOnly, "Dados Necessários"
    End If
End Sub

Private Sub CmdConsultar_Click()
    If TxtCodigo <> "" Then
        Comando = "Select * from TabCadLivro where Codigo=" & TxtCodigo 'seleciona todos os dados pertencentes ao código informado
        valida_selecao
        If dataset.RecordCount <> 0 Then ' se houver ao menos 1 registro, que dizer, recordcount<>0 significa que foi achado, se não, não!
            'ai vc começa a preencher as txts com os valores que estõ na memória
            TxtLivro = dataset("Livro")
            TxtAutor = dataset("Autor")
            TxtEditora = dataset("Editora")
            TxtDescricao = dataset("Descricao")
            TxtAno = dataset("Ano")
            CmdAlterar.Enabled = True
            CmdExcluir.Enabled = True
            CmdCadastrar.Enabled = False
            CmdConsultar.Enabled = False
            TxtCodigo.Enabled = False ' o código não poderá ser alterado pelo usuário
        Else 'caso não tenha sido achado nenhum registro
            MsgBox ("Não foi achado nenhum registro com o código informado!"), vbInformation + vbOKOnly, "Nenhum Registro"
        End If
    Else
        MsgBox ("Necessário informar um código para efetuar a consulta!"), vbInformation + vbOKOnly, "Codigo Necessário!"
    End If
End Sub

Private Sub CmdExcluir_Click()
    'agora se o usuário clicar em deletar temos que deletar os dados da Tabela
    Dim resp
    resp = MsgBox("Deseja realmente excluir os dados?!", vbQuestion + vbYesNo, "Exclusão")
    If resp = vbYes Then
        Comando = "delete * from TabCadLivro where Codigo=" & TxtCodigo
        banco.Execute (Comando) 'executa o comando delete acima
        MsgBox ("Exclusão realizada com sucesso!"), vbInformation + vbOKOnly, "Sucesso ao Excluir!"
    End If
    Limpar 'chama metodo limpar
    CmdCadastrar.Enabled = True
    CmdConsultar.Enabled = True
    CmdAlterar.Enabled = False
    CmdExcluir.Enabled = False
    TxtCodigo.Enabled = True ' eu havia colado o de consultar, ai os botões não voltaram =9
    
End Sub

Private Sub CmdRelatorio_Click()
    Dim resp
    resp = MsgBox("Deseja abri o relatório para impressão dos dados?", vbQuestion + vbYesNo, "Relatório")
    If resp = vbYes Then
        DoCmd.OpenReport "LivrosCadastrados", acViewPreview 'abre no modo que permite o usuário imprimir os dados do relatório
    Else
        DoCmd.OpenReport "LivrosCadastrados", acViewReport
    End If
End Sub

Private Sub Comando18_Click()
    Limpar
End Sub

Private Sub Form_Load()
    Conecta 'chama a função de conexão que a gente havia criado no moduloConexao! ps : isso ao inicializar o Form
End Sub

Sub GerarCodigo()
    Comando = "select * from TabCadLivro order by Codigo Desc" 'seleciona todos os campos em ordem decrescente
    valida_selecao 'chama a função que criamos que irá executar o comando Sql acima
    If dataset.BOF = True Then ' isso que dizer, se não existirem resgistro na tabela Begin(inicio) sera igual a true
        NumCod = 1 ' e o numero de código irá ser = 1, pq é o primeiro registro
    Else
        NumCod = dataset("Codigo") + 1 'se não ele pega o ultimo codigo e adiciona 1 que sera o proximo
    End If
End Sub

Sub Limpar()
    TxtCodigo = Empty
    TxtLivro = Empty
    TxtAutor = Empty
    TxtEditora = Empty
    TxtAno = Empty
    TxtDescricao = Empty
End Sub
