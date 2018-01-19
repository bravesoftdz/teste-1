//Pesquisando por parte de uma string

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Query1.Close;
Query1.Sql.Clear;
Query1.Sql.Add(‘Select Teste1.Codigo,Teste1.Nome’);
Query1.Sql.Add(‘From Teste1 ‘);
Query1.Sql.Add(‘Where ‘);
Query1.Sql.Add(‘(Teste1.Codigo >= :Codigo1) and’);
Query1.Sql.Add(‘(Teste1.Codigo <= :Codigo2)’);
Query1.Params[0].AsString := Edit1.Text;
Query1.Params[1].AsString := Edit2.Text;
Query1.Open;	
end;

//com ADOQuery

procedure TFrmCadFuncionarios.edtPesquisaChange(Sender: TObject);
var Consulta:string;
begin
Consulta:= edtPesquisa.Text;
 with Dm.qryFuncionarios do
 begin
   Close;
   SQL.Clear;
   SQL.Add('SELECT * FROM tblFuncionarios WHERE NOME LIKE' + QuotedStr('%' + Consulta + '%'));
   Open;
 end;

end;