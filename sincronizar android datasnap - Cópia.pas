Servidor
Inicialmente vamos acessar nosso servidor DataSnap e criaremos a função responsável por enviar os dados de nosso banco de dados para o Cliente(Android). Portanto, crie a seguinte função:
 

Function Sincronizar(Tabela: String; var SQL: String): Boolean;
Var
  I: Integer;
  Aux, S: String;
  ListaSQL: TStringList;
begin
  Try
    Aux:= EmptyStr;
    S:= EmptyStr;
    ListaSQL:= TStringList.Create;
    Case AnsiIndexStr(Tabela,['PRODUTOS']) of
      0:Begin
          //Produtos
          cdsProdutos.Close;
          cdsProdutos.Open;
FormatSettings.DecimalSeparator:= '.';
          While not cdsProdutos.Eof do
          Begin
            Aux:= IntToStr(cdsProdutosID_PRODUTO.AsInteger) + ', ';
            if not (cdsProdutosPRODUTO.IsNull) then
              Aux:= Aux + QuotedStr(cdsProdutosPRODUTO.AsString) + ', '
            else
              Aux:= Aux + 'Null,';
            if not (cdsProdutosVALOR_UN.IsNull) then
              Aux:= Aux + FloatToStr(cdsProdutosVALOR_UN.AsFloat)
            else
              Aux:= Aux + 'Null';
              S:= 'INSERT INTO PRODUTOS (ID_PRODUTO,PRODUTO,VALOR_UN) VALUES ('+ Aux +');';
              Aux:= '';
              ListaSQL.Add(S);
              S:= '';
              cdsProdutos.Next;
          End;
          for I := 0 to ListaSQL.Count-1 do
          Begin
            SQL:= SQL + ListaSQL.Strings[I];
          End;
          Result:= True;
          cdsProdutos.Close;
         FormatSettings.DecimalSeparator:= ',';
      End;
    End;
  Except on E: Exception do
    Result:= False;
  end;
  ListaSQL.Free;
end;



Cliente
Após configurarmos o servidor vamos para nossa aplicação Cliente (Android). Adicione um botão na tela inicial e nomeie de ‘ btnSincronizar ’ adicione também um componente ‘ AniIndicator ’ e deixe a propriedade ‘ Visible ’ como False.

Imagem 1 – Tela Inicial.
               
Feito isso vamos ao evento ‘ OnClick ’ do botão Sincronizar e adicione o comando de sincronização, veja abaixo:
 

procedure btnSincronizarClick(Sender: TObject);
Var
  S, Tabela: String;
  Lista: TStringList;
  B: Boolean;
  I, J: Integer;
begin
  if MessageDlg('Deseja Sincronizar os Dados? Processo pode levar alguns Minutos!', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
  begin
    btnPedido.Visible:= False;
    AniIndicator1.Visible:= True;
    AniIndicator1.Enabled:= True;
    Application.ProcessMessages;
    Try
      Lista:= TStringList.Create;
      Lista.Add('PRODUTOS');
      for I := 0 to Lista.Count-1 do
      Begin
        Tabela:= Lista.Strings[I];
        DM.Metodos.ServerMethodName:= 'TServerMethods1.Sincronizar';
        DM.Metodos.ParamByName('Tabela').AsString:= Tabela;
        DM.Metodos.ExecuteMethod;
        B:= DM.Metodos.ParamByName('ReturnParameter').AsBoolean;
        if B = True then
        begin
          DM.sdsAuxiliar.close;
          DM.sdsAuxiliar.CommandText := 'DELETE FROM ' + Tabela;
          DM.sdsAuxiliar.ExecSQL;
          DM.sdsAuxiliar.close;
          DM.sdsAuxiliar.CommandText := 'SELECT * FROM ' + Tabela;
          DM.sdsAuxiliar.ExecSQL;
        if DM.sdsAuxiliar.RecordCount = 0 then
        Begin
          S:= DM.Metodos.ParamByName('SQL').AsString;
          for J := 0 to ContarCaracter(S) - 1 do
          Begin
            DM.sdsAuxiliar.Close;
            DM.sdsAuxiliar.CommandText:= LerSQL(S,J);
            DM.sdsAuxiliar.ExecSQL;
            Application.ProcessMessages;
          End;
        End;
      End
      else
        ShowMessage(' Falha na Tabela  ('+ Tabela +').');
    end;
      ShowMessage('Sincronização Finalizada com Sucesso!');
    Except on E: Exception do
      ShowMessage('Falha ao Sincronizar!'+E.Message);
    end;
    Lista.Free;
    btnPedido.Visible:= True;
    AniIndicator1.Enabled:= False;
    AniIndicator1.Visible:= False;
    Application.ProcessMessages;
  end;
end;
Listagem 2 – Botão Sincronizar.
 

Neste processo criamos uma variável ‘ Lista ’ do tipo TStringList para armazenarmos o nome das tabelas que desejamos sincronizar, lembre-se os nomes devem ser os mesmos que indicamos em nosso servidor, ou seja, nossa tabela de Produtos. Veja que antes de executar a inserção apagamos qualquer registro que esteja na base do dispositivo móvel para evitarmos dados duplicados. 
               
Para a execução deste processo utilizamos 2 funções para nos auxiliar, abaixo segue a sintaxe delas e suas respectivas funções.
 

function ContarCaracter(C: String): Integer;
Var
  I, Qtd: Integer;
begin
  Qtd:= 0;
  for I := 1 to Length(C) do
  Begin
    if C[I] = ';' then
      Qtd:= Qtd +1;
  End;
  Result:= Qtd;
end;
 
Listagem 3 – Função ContarCaracter.
               
Esta função foi utilizada para contar a quantidade de vezes que o caractere ‘ ; ’ aparece em nossa ‘ String ’, utilizaremos este valor para definirmos a quantidade de ‘ Inserts ’ que serão aplicados em nosso banco de dados. Nossa próxima função complementa a utilização da ’ContarCaracter’, ou seja, com o valor indicado em nosso ‘For’ vamos criar o laço de repetição até que todos os registros sejam inseridos.
 

function LerSQL(SQL: String; Linha: Integer): String;
Var
  S: string;
  I: Integer;
begin
  for I := 0 to Linha - 1 do
  begin
    Delete(SQL, 1, Pos(';', SQL));
  end;
  S := Copy(SQL, 1, Pos(';', SQL) - 1);
  Result := S;
end;
 
Listagem 4 – Função LerSQL.
