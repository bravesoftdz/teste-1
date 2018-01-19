
procedure TForm1.FormCreate(Sender: TObject); 
var 
  Ini: TIniFile; 
begin 
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); 
  try 
    Top     := Ini.ReadInteger( 'Form', 'Top', 100 ); 
    Left    := Ini.ReadInteger( 'Form', 'Left', 100 ); 
    Caption := Ini.ReadString( 'Form', 'Caption', 'New Form' ); 
    if Ini.ReadBool( 'Form', 'InitMax', false ) then 
      WindowState = wsMaximized 
    else 

      WindowState = wsNormal; 
  finally 
    TIniFile.Free; 
  end; 
end; 

procedure TForm1.FormClose(Sender: TObject; var Action TCloseAction) 
var 
  Ini: TIniFile; 
begin 
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); 
  try 
    Ini.WriteInteger( 'Form', 'Top', Top); 
    Ini.WriteInteger( 'Form', 'Left', Left); 
    Ini.WriteString( 'Form', 'Caption', Caption ); 
    Ini.WriteBool( 'Form', 'InitMax', WindowState = wsMaximized ); 

  finally 
    TIniFile.Free; 
  end; 
end;