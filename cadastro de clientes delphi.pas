unit UCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadPadrao, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TFrmCadClientes = class(TFrmCadPadrao)
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    DBEdit11: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ValorCampoChange(Sender: TObject);
    procedure ValorCampoKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadClientes: TFrmCadClientes;

implementation

{$R *.dfm}

uses UDM, DB;

procedure TFrmCadClientes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Odd(dm.tab_Clientes.RecNo) and (dm.tab_Clientes.State <> dsInsert) then
  begin //Lembre-se de colocar a unit DB na cláusula uses na unit da tela.
      DBGrid1.Canvas.Brush.Color := clMoneyGreen; // muda a cor do pincel
      DBGrid1.Canvas.FillRect(Rect); // Preenche o fundo com a cor especificada
      DBGrid1.DefaultDrawDataCell(Rect,Column.Field,State);// desenha as células da grade
  end;

end;

procedure TFrmCadClientes.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  Ascendente:= not Ascendente ;
  If Ascendente then
    Dm.tab_Clientes.IndexFieldNames := Column.FieldName + '   ASC'
  else
    Dm.tab_Clientes.IndexFieldNames := Column.FieldName + '    DESC';
    
end;

procedure TFrmCadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DM.Tab_Clientes.Close; // fecha a tabela de clientes
end;

procedure TFrmCadClientes.FormShow(Sender: TObject);
begin
  inherited;
  DM.Tab_Clientes.Open; // abre a tabela de clientes
end;

procedure TFrmCadClientes.ValorCampoChange(Sender: TObject);
begin
  inherited;
  //DM.Tab_Clientes.Locate( 'CliNome',ValorCampo.Text, [loCaseInsensitive, loPartialKey] );
  DM.SQL_Clientes.Close;
  DM.SQL_Clientes.Parameters.ParamByName('pnome').Value:= ValorCampo.Text + '%';
  DM.SQL_Clientes.Open;

end;


procedure TFrmCadClientes.ValorCampoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if Key = #13 then
begin
  with DM.SQL_Clientes do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from clientes');
      SQL.Add('where cliNome like :nome');
      //passa o valor do campo txt_busca para o parametro nome
      Parameters.ParamByName('nome').Value:= ValorCampo.Text + '%';
      Open;

      if RecordCount = 0 then
      ShowMessage('Nenhum registro encontrado');

  end;
end;
end;

end.