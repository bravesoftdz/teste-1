procedure TSeuForm.DimensionarGrid(dbg: TDbGrid; var formulario);
   type
      TArray = Array of integer;
   procedure AjustarColumns(Swidth,TSize:integer;Asize:TArray);
     var
       idx:integer;
   begin
     if Tsize = 0 then
        begin
           Tsize:=dbg.Columns.Count;
             for idx:=0 to dbg.Columns.Count-1 do
               dbg.Columns[Idx].Width:=
                     (dbg.Width- dbg.Canvas.TextWidth('AAAAAA')) div Tsize
        end
     else
      for idx:=0 to dbg.Columns.Count-1 do
        dbg.Columns[Idx].Width:=dbg.Columns[Idx].Width + (Swidth*Asize[idx] div Tsize);
    end;
  var
   Idx,Twidth,Tsize,Swidth: Integer;
   AWidth:TArray;
   Asize:TArray;
   NomeColuna:String;
 begin
   SetLength(AWidth,dbg.Columns.Count);
   SetLength(ASize,dbg.Columns.Count);
   TWidth:=20;
   TSize:=0;
     for Idx := 0 to dbg.Columns.Count - 1  do
        begin
          NomeColuna:=Dbg.Columns[Idx].Title.Caption;
          dbg.Columns[Idx].Width :=
                   dbg.Canvas.TextWidth(Dbg.Columns[Idx].Title.Caption+'A');
          AWidth[idx]:=dbg.Columns[Idx].Width;
          TWidth:= TWidth + AWidth[idx];
          Asize[idx]:= dbg.Columns[idx].Field.Size;
          Tsize:= Tsize+Asize[idx];
       end;
if dgColLines in dbg.Options then
     TWidth:= TWidth+ Dbg.Columns.Count;
 
//adiciona a largura da coluna indicada do cursor
if dgIndicator in Dbg.Options then
    TWidth:=TWidth+IndicatorWidth;
 
Swidth:=dbg.ClientWidth - TWidth;
AjustarColumns(Swidth,TSize,Asize);
dbg.Width:=dbg.Width + dbg.Canvas.TextWidth('AAAAAA');
Dbg.Left:=(Tform(formulario).Width - dbg.Width) div 2 -
          (dbg.Canvas.TextWidth('AA') div 2);
 end;



//Para usar o c�digo acima no evento OnRezise do formul�rio ou do container escreva

procedure TSeuFormlarios.FormResize(Sender: TObject);
 begin
     DimensionarGrid(SeuDbGrid,self);
 end;