procedure btnPesquisarClick(Sender: TObject);
Var
  ListItem: TListViewItem;
begin
  Try
    ListView1.BeginUpdate;
    ListView1.Items.Clear;

    qryRead.First;
    while not qryRead.Eof do
    Begin
      ListItem := ListView1.Items.Add;
      ListItem.Text               := qryRead.FieldByName('NOME').AsString;
      ListItem.Detail1.Text   := qryRead.FieldByName('TELEFONE').AsString; // NAO FUNCIONA
      ListItem.Detail2.Text   := qryRead.FieldByName('CIDADE').AsString;     // NAO FUNCIONA
      ListItem.Detail3.Text   := qryRead.FieldByName('BAIRRO').AsString;     // NAO FUNCIONA

      qryRead.Next;
    End;
  Finally
    ListView1.EndUpdate;
  End;
end;

procedure TForm1.btnExportarDadosClick(Sender: TObject);
begin
  SqliteQuery.Close;
  SqliteQuery.Open;
  SqliteQuery.first;
  while not SqliteQuery.Eof do
  begin
    if MysqlQueryCNPJ.Value <> 0 then
      begin
      try
        MysqlQuery.Insert;
        MysqlQueryCNPJ.value := SqliteQueryCNPJ.value;
        MysqlQueryNOME.value := SqliteQueryNOME.value;
        MysqlQueryENDERECO.value := SqliteQueryENDERECO.value;
        MysqlQueryTELEFONE.value := SqliteQueryTELEFONE.value;
        MysqlQuery.Post;
      except
        on E: Exception do
        begin
          showmessage (E.message);
          if MysqlQuery.State = dsinsert then
            MysqlQuery.Cancel;
          break;
        end;
      end;
    SqliteQuery.edit;
    SqliteQueryEXPORT.Value := 'S';
    SqliteQuery.post;
    SqliteQuery.next;
      end;
  end;
end;



CONEXAO DATASNAP

dmClient.SQLConnection1.Close;
dmClient.SQLConnection1.Params.Values['HostName'] := '10.0.0.1'; // Aqui você define o endereço ip do servidor DataSnap que deseja conectar.
dmClient.SQLConnection1.Open;