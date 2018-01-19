//Criar um documento no word.
Uses ComObj

procedure TForm1.Button1Click(Sender: TObject);
var
MSWord: Variant;
begin
MSWord:= CreateOleObject ('Word.Basic');
MSWord.AppShow;//mostra o word
MSWord.FileNew;//inicia um novo documento
MSWord.insert('Contrato de Locação'); //Escreve algo
MSWord.insert(#13+'Contrato de Locação');//Pula uma linha e escreve
MSWord.FontSize(24);//muda o tamanho da fonte
MSWord.italic;//coloca italico
MSWord.bold;//coloca negrito
MSWord.underline;//sublina
MSWord.insert(#13+'Contrato de Locação');//pula a linha e escreve novamente
MSWord.FontSize(12);//muda o tamanho da fonte
MSWord.Font('Arial');//muda a fonte usada
MSWord.underline(false);//retira o sublinhado
MSWord.italic(false);//retira o italico
MSWord.bold(false);//retira o bold
MSWord.insert(#13 +'teste');
MSWord.insert(#13+#9 +'teste');//nova linha e um TAB
MSWord.insert(#13+Table1Razao_Social.Value);//insere algo de uma tabela
MSWord.LineUp(2, 1); //seleciona uma parte do texto
MSWord.TextToTable(ConvertFrom := 2, NumColumns := 1);// monta uma tabela com o texto selecionado
MSWord.FileSaveAs('c:temptest.txt', 3); //Salva o arquivo
end;

{Obs: 

MSWord.JustifyPara; // alinhamento justificado
MSWord.RightPara; // alinhamento a direita
MSWord.LeftPara; // alinhamento a esquerda
MSWord.InsertPageBreak; // quebrar página}