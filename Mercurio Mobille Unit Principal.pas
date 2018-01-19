unit UFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  Data.SqlExpr, Datasnap.DBClient, Datasnap.DSConnect, FMX.Edit, FMX.Layouts,
  FMX.ListBox, FMX.TabControl, FMX.StdCtrls, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.Ani, FMX.ListView.Types, FMX.ListView, Fmx.Bind.Grid,
  Data.Bind.Grid, FMX.Grid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, Fmx.Bind.Navigator, Data.DbxSqlite, Data.FMTBcd,
  Datasnap.Provider, Data.Bind.Controls, FMX.platform, MultiDetailAppearanceU;


type
  TfrmPrincipal = class(TForm)
    TabControl1: TTabControl;
    tabProdutos: TTabItem;
    ActionList1: TActionList;
    TAPrincipal: TChangeTabAction;
    tabPrincipal: TTabItem;
    TAProdutos: TChangeTabAction;
    TAClientes: TChangeTabAction;
    GridPanelLayout1: TGridPanelLayout;
    tabClientes: TTabItem;
    lstProdutos: TListView;
    lsvClientes: TListView;
    imgSair: TImageControl;
    ToolBar1: TToolBar;
    Button1: TButton;
    ToolBar2: TToolBar;
    Button2: TButton;
    TASair: TAction;
    tabConfiguracoes: TTabItem;
    edtIPE: TEdit;
    Label1: TLabel;
    btnInserirIP: TButton;
    LiveBindingsBindNavigatePost1: TFMXBindNavigatePost;
    LiveBindingsBindNavigateInsert1: TFMXBindNavigateInsert;
    LiveBindingsBindNavigateEdit1: TFMXBindNavigateEdit;
    LiveBindingsBindNavigateApplyUpdates1: TFMXBindNavigateApplyUpdates;
    TAConfig: TChangeTabAction;
    tlb1: TToolBar;
    btnVoltar: TButton;
    imgAtualizar: TImageControl;
    btnConectarConfig: TButton;
    imgLogo: TImageControl;
    imgClientes: TImageControl;
    BitmapAnimation2: TBitmapAnimation;
    ImageControl2: TImageControl;
    BitmapAnimation3: TBitmapAnimation;
    LiveBindingsBindNavigateEdit2: TFMXBindNavigateEdit;
    Label2: TLabel;
    btnSincronizar: TButton;
    AniIndicator1: TAniIndicator;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    edtBarras: TEdit;
    btnCamera: TButton;
    lblStatus: TLabel;
    edtPesquisaCliente: TEdit;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure TASairExecute(Sender: TObject);
    procedure btnConectarConfigClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure edtBarrasChangeTracking(Sender: TObject);
    procedure edtPesquisaClienteChangeTracking(Sender: TObject);


   
  private
    { Private declarations }
    
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}




uses System.IOUtils, UDM;

procedure TfrmPrincipal.btnConectarConfigClick(Sender: TObject);
begin

  try
    if btnConectarConfig.Text = 'Conectar' then
    begin
      DM.tblAccesso.Open;
      DM.tblAccesso.Edit;
      DM.tblAccesso.Post;
      with DM.conexao do
      begin
        Close;
        with Params do
        begin
          Clear;
          Add('DriverUnit=Data.DBXDataSnap');
          Add('HostName='+ edtIPE.Text);
          Add('Port=211');
          Add('CommunicationProtocol=tcp/ip');
          Add('DatasnapContext=datasnap/');
          Add('DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,' +
                     'Borland.Data.DbxClientDriver,Version=20.0.0.0,Culture=neutral,' +
                     'PublicKeyToken=91d62ebb5b0d1b1b');
          Add('Filters={}');
        end;
        Connected := True;
      end;
      DM.cdsProduto.Open;
      DM.cdsClientes.Open;
      dm.conexaoLocal.Connected := True;
      DM.qryProdutos.Open;
      DM.qryClientes.Open;
      if DM.conexao.Connected then btnConectarConfig.Text := 'Desconectar';
        TabControl1.ActiveTab := tabPrincipal;
    end
    else
    begin
      DM.conexao.Close;
      DM.cdsProduto.Close;
      DM.cdsClientes.Close;
      if Not DM.conexao.Connected then btnConectarConfig.Text := 'Conectar';
    end;
  except
    ShowMessage('Porta ou IP incorreto, corrija e tente novamente!');
    TabControl1.ActiveTab := tabConfiguracoes;
  end;
end;


procedure TfrmPrincipal.btnSincronizarClick(Sender: TObject);

begin

  DM.cdsProduto.Open;
  DM.cdsClientes.Open;
  AniIndicator1.Visible:= True;
  AniIndicator1.Enabled:= True;
  Application.ProcessMessages;
  lblStatus.Visible := True;

//--------Exclui os produtos do banco local ---------///

  with DM.qry do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM PRODUTOS');
    ExecSQL;
  end;

//--------A Query passa a receber a tabela de produtos ------//

  with DM.qry do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM PRODUTOS');
    Open;
  end;
  DM.cdsProduto.First;

//-------Passa os valores para a tabela Produtos do Banco local -------//

  while not DM.cdsProduto.Eof do
  begin
    DM.qry.Append;
    DM.qry.FieldByName('CODIGO').Value := DM.cdsProduto.FieldByName('CODIGO').Value;
    DM.qry.FieldByName('PRODUTO').Value := DM.cdsProduto.FieldByName('PRODUTO').Value;
    DM.qry.FieldByName('CODBARRA').Value := DM.cdsProduto.FieldByName('CODBARRA').Value;
    DM.qry.FieldByName('PRECOVENDA').Value := DM.cdsProduto.FieldByName('PRECOVENDA').Value;
    DM.qry.FieldByName('ESTOQUE').Value := DM.cdsProduto.FieldByName('ESTOQUE').Value;
    DM.qry.FieldByName('APLICACAO').Value := DM.cdsProduto.FieldByName('APLICACAO').Value;
    DM.qry.Next;
    DM.cdsProduto.Next;
    Application.ProcessMessages;
  end;

  //--------Exclui os clientes do banco local ---------///

  with DM.qry do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM CLIENTES');
    ExecSQL;
  end;

//--------A Query passa a receber a tabela de clientes ------//

  with DM.qry do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CLIENTES');
    Open;
  end;
  DM.cdsClientes.First;

  //-------Passa os valores para a tabela Clientes do Banco local -------//

  while not DM.cdsClientes.Eof do
  begin
    DM.qry.Append;
    DM.qry.FieldByName('CODIGO').Value := DM.cdsClientes.FieldByName('CODIGO').Value;
    DM.qry.FieldByName('NOME').Value := DM.cdsClientes.FieldByName('NOME').Value;
    DM.qry.FieldByName('CPF').Value := DM.cdsClientes.FieldByName('CPF').Value;
    DM.qry.FieldByName('TELEFONE1').Value := DM.cdsClientes.FieldByName('TELEFONE1').Value;
    DM.qry.FieldByName('CELULAR').Value := DM.cdsClientes.FieldByName('CELULAR').Value;
    DM.qry.FieldByName('SITUACAO').Value := DM.cdsClientes.FieldByName('SITUACAO').Value;
    DM.qry.Next;
    DM.cdsClientes.Next;
    Application.ProcessMessages;
  end;

  AniIndicator1.Visible:= False;
  AniIndicator1.Enabled:= False;
  lblStatus.Visible := False;
end;

//------------Pesquisa de produtos ---------------//

procedure TfrmPrincipal.edtBarrasChangeTracking(Sender: TObject);
Var
 ListItem: TListViewItem;
begin
  with DM.qryProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM PRODUTOS');
    if Length(edtBarras.Text) = 13 then
    begin
      SQL.Add('WHERE CODBARRA LIKE :pbarras');
      ParamByName('pbarras').Value := edtBarras.Text;
    end
    else
    begin
      SQL.Add('WHERE PRODUTO LIKE :pnome');
      ParamByName('pnome').Value := edtBarras.Text + '%';
    end;
    Open;
  end;

  Try
    lstProdutos.BeginUpdate;
    lstProdutos.Items.Clear;
    DM.qryProdutos.First;
    while not DM.qryProdutos.Eof do
    Begin

      ListItem                := lstProdutos.Items.Add;
      ListItem.Text           := DM.qryProdutos.FieldByName('PRODUTO').AsString;
      if DM.qryProdutos.FieldByName('CODIGO').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Código: ' +
                            DM.qryProdutos.FieldByName('CODIGO').DisplayText;
      if DM.qryProdutos.FieldByName('ESTOQUE').AsInteger > 0 then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Estoque: ' +
                            DM.qryProdutos.FieldByName('ESTOQUE').AsString
      else
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Aguardando reposição!';

      if DM.qryProdutos.FieldByName('PRECOVENDA').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail3]:= 'Preço: ' +
                            DM.qryProdutos.FieldByName('PRECOVENDA').DisplayText;



      DM.qryProdutos.Next;
    End;
  except
    ShowMessage('Você não está conectado ao servidor!');
    TabControl1.ActiveTab := tabConfiguracoes;
    lstProdutos.EndUpdate;

  End;

end;

//------------Pesquisa de clientes ---------------//

procedure TfrmPrincipal.edtPesquisaClienteChangeTracking(Sender: TObject);
Var
 ListItem: TListViewItem;
begin
  with DM.qryClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CLIENTES');
    if Length(edtBarras.Text) = 13 then
    begin
      SQL.Add('WHERE CPF LIKE :pcpf');
      ParamByName('pcpf').Value := edtPesquisaCliente.Text;
    end
    else
    begin
      SQL.Add('WHERE NOME LIKE :pnome');
      ParamByName('pnome').Value := edtPesquisaCliente.Text + '%';
    end;
    Open;
  end;

  Try
    lsvClientes.BeginUpdate;
    lsvClientes.Items.Clear;
    DM.qryClientes.First;
    while not DM.qryClientes.Eof do
    Begin

      ListItem      := lsvClientes.Items.Add;
      ListItem.Text := DM.qryClientes.FieldByName('NOME').AsString;

      if DM.qryClientes.FieldByName('CPF').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Doc: ' +
                            DM.qryClientes.FieldByName('CPF').AsString
      else
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Sem Documentos cadastrados!';

      if DM.qryClientes.FieldByName('TELEFONE1').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Fone: ' +
                            DM.qryClientes.FieldByName('TELEFONE1').AsString
      else
      if DM.qryClientes.FieldByName('CELULAR').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Cel: ' +
                            DM.qryClientes.FieldByName('CELULAR').AsString
      else
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Sem Telefones cadastrados!';

      if DM.qryClientes.FieldByName('SITUACAO').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail3]:= 'Situação: ' +
                            DM.qryClientes.FieldByName('SITUACAO').AsString;

      DM.qryClientes.Next;
    End;
  except
    ShowMessage('Você não está conectado ao servidor!');
    TabControl1.ActiveTab := tabConfiguracoes;
    lsvClientes.EndUpdate;

  End;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    DM.conexaoLocal.Open;
    DM.tblAccesso.Open;
    edtIPE.Text := DM.tblAccesso.FieldByName('IP').AsString;
    DM.conexao.Close;
    with DM.conexao.Params do
    begin
      Clear;
      Add('DriverUnit=Data.DBXDataSnap');
      Add('HostName='+ edtIPE.Text);
      Add('Port=211');
      Add('CommunicationProtocol=tcp/ip');
      Add('DatasnapContext=datasnap/');
      Add('DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,' +
          'Borland.Data.DbxClientDriver,Version=20.0.0.0,Culture=neutral,' +
          'PublicKeyToken=91d62ebb5b0d1b1b');
      Add('Filters={}');
    end;
    DM.conexao.Connected := True;
    DM.cdsProduto.Open;
    DM.cdsClientes.Open;
    DM.conexaoLocal.Connected := True;
    DM.qryProdutos.Open;
    DM.qryClientes.Open;
    TabControl1.ActiveTab := tabPrincipal;

  except
    ShowMessage('Porta ou IP incorreto, corrija e tente novamente!');
    TabControl1.ActiveTab := tabConfiguracoes;
  end;

end;

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin
  TAProdutos.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.TASairExecute(Sender: TObject);
begin
  Close;
end;



end.