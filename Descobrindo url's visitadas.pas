//Descobrindo url's visitadas
//Saiba todos os endereços da internet que você visitou:

uses Registry;

procedure ShowTypedUrls(Urls: TStrings); 
var 
	Reg: TRegistry; 
	S: TStringList; 
	i: Integer; 
begin 
	Reg := TRegistry.Create;
	try 
		Reg.RootKey := HKEY_CURRENT_USER; 
		if Reg.OpenKey('SoftwareMicrosoftInternet ExplorerTypedURLs', False) then 
		begin 
			S := TStringList.Create; 
			try 
			reg.GetValueNames(S); 
				for i := 0 to S.Count - 1 do 
				begin 
					Urls.Add(reg.ReadString(S.Strings[i])); 
				end; 
			finally 
			S.Free; 
		end; 
		Reg.CloseKey; 
		end; 
	finally 
	Reg.Free; 
	end; 
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
ShowTypedUrls(ListBox1.Items);
end;