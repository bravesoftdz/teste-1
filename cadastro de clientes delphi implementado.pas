unit U_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan;

type
  TfrmProdutos = class(TForm)
    StatusBar1: TStatusBar;
    pg_principal: TPageControl;
    tab_consulta: TTabSheet;
    tab_cadastro: TTabSheet;
    DBGrid1: TDBGrid;
    txt_busca: TEdit;
    Label1: TLabel;
    rg_pesquisa: TRadioGroup;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    ds_principal: TDataSource;
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
    act_principal: TActionManager;
    ac_novo: TDataSetInsert;
    ac_delete: TDataSetDelete;
    ac_editar: TDataSetEdit;
    ac_salvar: TDataSetPost;
    ac_cancelar: TDataSetCancel;
    btn_inserir: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_salvar: TSpeedButton;
    btn_cancelar: TSpeedButton;
    btl_delete: TSpeedButton;
    btn_editar_selecionado: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure txt_buscaKeyPress(Sender: TObject; var Key: Char);
    procedure btn_editar_selecionadoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

uses U_DM;

procedure TfrmProdutos.btn_editar_selecionadoClick(Sender: TObject);
begin
  //localiza um registro na tb_produtos
  DM.tb_produtos.Locate('pro_id',DM.sql_produtospro_id.Value,[]);
  pg_principal.ActivePage := tab_cadastro;

end;

procedure TfrmProdutos.DBGrid1DblClick(Sender: TObject);
begin
  btn_editar_selecionado.Click;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //elimina o form da memoria
  frmProdutos:= nil;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  //ativa a tb_produtos
  dm.tb_produtos.Active := True;
  //guia ativa sera a tab_consulta
  pg_principal.ActivePage := tab_consulta;
end;

procedure TfrmProdutos.txt_buscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
  if rg_pesquisa.ItemIndex = -1 then
  begin
    ShowMessage('Escolha um tipo de busca Por Nome/Por Barras');
    Exit;
  end;
    with DM.sql_produtos do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from produtos');

        case rg_pesquisa.ItemIndex of
          0:SQL.Add('where pro_nome like :nome');
          1:SQL.Add('where pro_barras like :nome');
        end;
      //passa o valor do campo txt_busca para o parametro nome
      ParamByName('nome').Value:= txt_busca.Text + '%';
      Open;

      if RecordCount = 0 then
      ShowMessage('Nenhum registro encontrado');


    end;

  end;

end;

end.