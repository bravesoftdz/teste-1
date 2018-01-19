procedure TFrmPrincipal.btn2Click(Sender: TObject);
begin
  if dlgOpenPic1.Execute then
  begin
    img2.Picture.LoadFromFile(dlgOpenPic1.FileName);
  end;
end;

TOpenPictureDialog