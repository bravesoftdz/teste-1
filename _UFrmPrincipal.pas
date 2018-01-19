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
  Datasnap.Provider, Data.Bind.Controls, FireDAC.Phys.SQLiteDef,
  FMX.Controls.Presentation,

  FMX.platform, fmx.helpers.android, androidapi.JNI.GraphicsContentViewText,
  androidapi.jni.JavaTypes, Androidapi.Helpers, MultiDetailAppearanceU;



type
  TfrmPrincipal = class(TForm)
    TabControl1: TTabControl;
    tabProdutos: TTabItem;
    DSPConnection: TDSProviderConnection;
    cdsProduto: TClientDataSet;
    conexao: TSQLConnection;
    ActionList1: TActionList;
    TAPrincipal: TChangeTabAction;
    tabPrincipal: TTabItem;
    TAProdutos: TChangeTabAction;
    TAClientes: TChangeTabAction;
    GridPanelLayout1: TGridPanelLayout;
    tabClientes: TTabItem;
    lstProdutos: TListView;
    cdsProdutoCODIGO: TStringField;
    cdsProdutoCODBARRA: TStringField;
    cdsProdutoPRODUTO: TStringField;
    cdsProdutoUNIDADE: TStringField;
    cdsProdutoDATA_CADASTRO: TSQLTimeStampField;
    cdsProdutoCODGRUPO: TStringField;
    cdsProdutoCODSUBGRUPO: TStringField;
    cdsProdutoCODFORNECEDOR: TStringField;
    cdsProdutoCODMARCA: TStringField;
    cdsProdutoDATA_ULTIMACOMPRA: TSQLTimeStampField;
    cdsProdutoNOTAFISCAL: TStringField;
    cdsProdutoPRECOCUSTO: TFloatField;
    cdsProdutoPRECOVENDA: TFloatField;
    cdsProdutoDATA_ULTIMAVENDA: TSQLTimeStampField;
    cdsProdutoESTOQUE: TFloatField;
    cdsProdutoESTOQUEMINIMO: TFloatField;
    cdsProdutoCODALIQUOTA: TStringField;
    cdsProdutoAPLICACAO: TMemoField;
    cdsProdutoLOCALICAZAO: TStringField;
    cdsProdutoPESO: TFloatField;
    cdsProdutoVALIDADE: TStringField;
    cdsProdutoCOMISSAO: TFloatField;
    cdsProdutoUSA_BALANCA: TIntegerField;
    cdsProdutoUSA_SERIAL: TIntegerField;
    cdsProdutoUSA_GRADE: TIntegerField;
    cdsProdutoCODRECEITA: TStringField;
    cdsProdutoFOTO: TStringField;
    cdsProdutoDATA_ULTIMACOMPRA_ANTERIOR: TSQLTimeStampField;
    cdsProdutoNOTAFISCAL_ANTERIOR: TStringField;
    cdsProdutoCODFORNECEDOR_ANTERIOR: TStringField;
    cdsProdutoPRECOCUSTO_ANTERIOR: TFloatField;
    cdsProdutoPRECOVENDA_ANTERIOR: TFloatField;
    cdsProdutoCUSTOMEDIO: TFloatField;
    cdsProdutoAUTO_APLICACAO: TStringField;
    cdsProdutoAUTO_COMPLEMENTO: TStringField;
    cdsProdutoDATA_REMARCACAO_CUSTO: TSQLTimeStampField;
    cdsProdutoDATA_REMARCACAO_VENDA: TSQLTimeStampField;
    cdsProdutoPRECO_PROMOCAO: TFloatField;
    cdsProdutoDATA_PROMOCAO: TSQLTimeStampField;
    cdsProdutoFIM_PROMOCAO: TSQLTimeStampField;
    cdsProdutoCST: TStringField;
    cdsProdutoCLASSIFICACAO_FISCAL: TStringField;
    cdsProdutoNBM: TStringField;
    cdsProdutoNCM: TStringField;
    cdsProdutoALIQUOTA: TFloatField;
    cdsProdutoIPI: TFloatField;
    cdsProdutoREDUCAO: TFloatField;
    cdsProdutoQTDE_EMBALAGEM: TFloatField;
    cdsProdutoTIPO: TStringField;
    cdsProdutoPESO_LIQUIDO: TFloatField;
    cdsProdutoFARMACIA_CONTROLADO: TStringField;
    cdsProdutoFARMACIA_APRESENTACAO: TIntegerField;
    cdsProdutoFARMACIA_REGISTRO_MEDICAMENTO: TStringField;
    cdsProdutoFARMACIA_PMC: TFloatField;
    cdsProdutoULTIMA_ALTERACAO: TSQLTimeStampField;
    cdsProdutoULTIMA_CARGA: TSQLTimeStampField;
    cdsProdutoDATA_INVENTARIO: TSQLTimeStampField;
    cdsProdutoCUSTO_INVENTARIO: TFloatField;
    cdsProdutoESTOQUE_INVENTARIO: TFloatField;
    cdsProdutoESTOQUE_ANTERIOR: TFloatField;
    cdsProdutoPRECOVENDA_NOVO: TFloatField;
    cdsProdutoUSA_RENTABILIDADE: TIntegerField;
    cdsProdutoQUANTIDADE_MINIMA_FAB: TFloatField;
    cdsProdutoAPRESENTACAO: TStringField;
    cdsProdutoSITUACAO: TIntegerField;
    cdsProdutoPRECOVENDA1: TFloatField;
    cdsProdutoPRECOVENDA2: TFloatField;
    cdsProdutoPRECOVENDA3: TFloatField;
    cdsProdutoPRECOVENDA4: TFloatField;
    cdsProdutoPRECOVENDA5: TFloatField;
    cdsProdutoDESCONTO_PRECOVENDA: TFloatField;
    cdsProdutoDATA_INVENTARIO_ATUAL: TSQLTimeStampField;
    cdsProdutoCUSTO_INVENTARIO_ATUAL: TFloatField;
    cdsProdutoESTOQUE_INVENTARIO_ATUAL: TFloatField;
    cdsProdutoMARGEM_MINIMA: TFloatField;
    cdsProdutoPISCOFINS: TStringField;
    cdsProdutoREFERENCIA_FORNECEDOR: TStringField;
    cdsProdutoCOMISSAO1: TFloatField;
    cdsProdutoMARGEM_DESCONTO: TFloatField;
    cdsProdutoTAMANHO: TStringField;
    cdsProdutoCOR: TStringField;
    cdsProdutoINCIDENCIA_PISCOFINS: TStringField;
    cdsProdutoVEIC_CHASSI: TStringField;
    cdsProdutoVEIC_SERIE: TStringField;
    cdsProdutoVEIC_POTENCIA: TStringField;
    cdsProdutoVEIC_PESO_LIQUIDO: TStringField;
    cdsProdutoVEIC_PESO_BRUTO: TStringField;
    cdsProdutoVEIC_TIPO_COMBUSTIVEL: TStringField;
    cdsProdutoVEIC_RENAVAM: TStringField;
    cdsProdutoVEIC_ANO_FABRICACAO: TIntegerField;
    cdsProdutoVEIC_ANO_MODELO: TIntegerField;
    cdsProdutoVEIC_TIPO: TStringField;
    cdsProdutoVEIC_TIPO_PINTURA: TStringField;
    cdsProdutoVEIC_COD_COR: TStringField;
    cdsProdutoVEIC_COR: TStringField;
    cdsProdutoVEIC_VIN: TStringField;
    cdsProdutoVEIC_NUMERO_MOTOR: TStringField;
    cdsProdutoVEIC_CMKG: TStringField;
    cdsProdutoVEIC_CM3: TStringField;
    cdsProdutoVEIC_DISTANCIA_EIXO: TStringField;
    cdsProdutoVEIC_COD_MARCA: TStringField;
    cdsProdutoVEIC_ESPECIE: TStringField;
    cdsProdutoVEIC_CONDICAO: TStringField;
    cdsProdutoLOTE_FABRICACAO: TStringField;
    cdsProdutoLOTE_VALIDADE: TSQLTimeStampField;
    cdsProdutoMARGEM_AGREGADA: TFloatField;
    cdsProdutoCODBARRA_NOVARTIS: TStringField;
    cdsProdutoFARMACIA_DCB: TStringField;
    cdsProdutoFARMACIA_ABCFARMA: TStringField;
    cdsProdutoFARMACIA_APRESENTACAO_CAIXA: TStringField;
    cdsProdutoFARMACIA_PRINCIPIOATIVO: TStringField;
    cdsProdutoULTIMA_COMPRA: TSQLTimeStampField;
    cdsProdutoFARMACIA_DATAVIGENCIA: TSQLTimeStampField;
    cdsProdutoFARMACIA_TIPO: TStringField;
    cdsProdutoUSA_COMBUSTIVEL: TStringField;
    cdsProdutoREFERENCIA: TStringField;
    cdsProdutoPERDA: TFloatField;
    cdsProdutoCOMPOSICAO1: TStringField;
    cdsProdutoCOMPOSICAO2: TStringField;
    cdsProdutoIAT: TStringField;
    cdsProdutoIPPT: TStringField;
    cdsProdutoSITUACAO_TRIBUTARIA: TStringField;
    cdsProdutoFLAG_SIS: TStringField;
    cdsProdutoFLAG_ACEITO: TStringField;
    cdsProdutoFLAG_EST: TStringField;
    cdsProdutoCSOSN: TStringField;
    cdsClientes: TClientDataSet;
    cdsClientesCODIGO: TStringField;
    cdsClientesNOME: TStringField;
    cdsClientesAPELIDO: TStringField;
    cdsClientesENDERECO: TStringField;
    cdsClientesBAIRRO: TStringField;
    cdsClientesCIDADE: TStringField;
    cdsClientesUF: TStringField;
    cdsClientesCEP: TStringField;
    cdsClientesCOMPLEMENTO: TStringField;
    cdsClientesMORADIA: TIntegerField;
    cdsClientesTIPO: TIntegerField;
    cdsClientesSITUACAO: TIntegerField;
    cdsClientesTELEFONE1: TStringField;
    cdsClientesTELEFONE2: TStringField;
    cdsClientesTELEFONE3: TStringField;
    cdsClientesCELULAR: TStringField;
    cdsClientesEMAIL: TStringField;
    cdsClientesRG: TStringField;
    cdsClientesCPF: TStringField;
    cdsClientesFILIACAO: TStringField;
    cdsClientesESTADOCIVIL: TStringField;
    cdsClientesCONJUGE: TStringField;
    cdsClientesPROFISSAO: TStringField;
    cdsClientesEMPRESA: TStringField;
    cdsClientesRENDA: TFloatField;
    cdsClientesLIMITE: TFloatField;
    cdsClientesREF1: TStringField;
    cdsClientesREF2: TStringField;
    cdsClientesCODVENDEDOR: TStringField;
    cdsClientesDATA_CADASTRO: TSQLTimeStampField;
    cdsClientesDATA_ULTIMACOMPRA: TSQLTimeStampField;
    cdsClientesOBS1: TStringField;
    cdsClientesOBS2: TStringField;
    cdsClientesOBS3: TStringField;
    cdsClientesOBS4: TStringField;
    cdsClientesOBS5: TStringField;
    cdsClientesOBS6: TStringField;
    cdsClientesNASCIMENTO: TStringField;
    cdsClientesCODREGIAO: TStringField;
    cdsClientesCODCONVENIO: TStringField;
    cdsClientesCODUSUARIO: TStringField;
    cdsClientesNUMERO: TStringField;
    cdsClientesRG_ORGAO: TStringField;
    cdsClientesRG_ESTADO: TStringField;
    cdsClientesRG_EMISSAO: TSQLTimeStampField;
    cdsClientesSEXO: TStringField;
    cdsClientesHISTORICO: TBlobField;
    cdsClientesPREVISAO: TSQLTimeStampField;
    cdsClientesCNAE: TStringField;
    cdsClientesCOD_MUNICIPIO_IBGE: TStringField;
    cdsClientesIBGE: TStringField;
    cdsClientesTAMANHO_CALCA: TStringField;
    cdsClientesTAMANHO_BLUSA: TStringField;
    cdsClientesTAMANHO_SAPATO: TStringField;
    cdsClientesCORRESP_ENDERECO: TStringField;
    cdsClientesCORRESP_BAIRRO: TStringField;
    cdsClientesCORRESP_CIDADE: TStringField;
    cdsClientesCORRESP_UF: TStringField;
    cdsClientesCORRESP_CEP: TStringField;
    cdsClientesCORRESP_COMPLEMENTO: TStringField;
    cdsClientesRG_PRODUTOR: TStringField;
    cdsClientesRESP1_NOME: TStringField;
    cdsClientesRESP1_CPF: TStringField;
    cdsClientesRESP1_RG: TStringField;
    cdsClientesRESP1_PROFISSAO: TStringField;
    cdsClientesRESP1_ESTADO_CIVIL: TStringField;
    cdsClientesRESP1_ENDERECO: TStringField;
    cdsClientesRESP1_BAIRRO: TStringField;
    cdsClientesRESP1_CIDADE: TStringField;
    cdsClientesRESP1_UF: TStringField;
    cdsClientesRESP1_CEP: TStringField;
    cdsClientesRESP2_NOME: TStringField;
    cdsClientesRESP2_CPF: TStringField;
    cdsClientesRESP2_RG: TStringField;
    cdsClientesRESP2_PROFISSAO: TStringField;
    cdsClientesRESP2_ESTADO_CIVIL: TStringField;
    cdsClientesRESP2_ENDERECO: TStringField;
    cdsClientesRESP2_BAIRRO: TStringField;
    cdsClientesRESP2_CIDADE: TStringField;
    cdsClientesRESP2_UF: TStringField;
    cdsClientesRESP2_CEP: TStringField;
    cdsClientesFOTO: TStringField;
    bsProdutos: TBindSourceDB;
    BindingsList1: TBindingsList;
    bsClientes: TBindSourceDB;
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
    conexaoIP: TFDConnection;
    link: TFDPhysSQLiteDriverLink;
    cursor: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    FDQuery1IP: TWideMemoField;
    BindSourceDB1: TBindSourceDB;
    Label2: TLabel;
    FDTable1: TFDTable;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    edtFiltraClientes: TEdit;
    btnFiltraCliente: TSpeedButton;
    edtFiltraProdutos: TEdit;
    btnFiltraProdutos: TSpeedButton;
    btnCamera: TSpeedButton;
    Timer1: TTimer;
    btnSincronizar: TButton;
    cdsProduto2: TClientDataSet;
    cdsClientes2: TClientDataSet;
    lbl1: TLabel;
    FDTable1IP: TWideMemoField;
    procedure Image1Click(Sender: TObject);
    procedure TASairExecute(Sender: TObject);
    procedure btnConectarConfigClick(Sender: TObject);
    procedure conexaoIPBeforeConnect(Sender: TObject);
    procedure conexaoIPAfterConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInserirIPClick(Sender: TObject);
    procedure btnFiltraClienteClick(Sender: TObject);
    procedure btnFiltraProdutosClick(Sender: TObject);
    procedure btnCameraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
   
  private
    { Private declarations }
    ClipService: IFMXClipboardService;
    Elapsed: integer;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}
uses System.IOUtils;

//--------------BOTAO DA CAMERA ----------------------//

procedure TfrmPrincipal.btnCameraClick(Sender: TObject);
var
 Intent : JIntent;
begin
  if assigned(ClipService) then
  begin
   clipservice.SetClipboard('nil');
   intent := tjintent.Create;
   intent.setAction(stringtojstring('com.google.zxing.client.android.SCAN'));
   SharedActivity.startActivityForResult(intent,0);
   Elapsed := 0;
   Timer1.Enabled := True;
  end;

end;

//--------------BOTAO CONECTAR ------------------------//

procedure TfrmPrincipal.btnConectarConfigClick(Sender: TObject);
begin

  try
    if btnConectarConfig.Text = 'Conectar' then
    begin
      FDTable1.Open;
      FDTable1.Edit;
      FDTable1.Post;
      conexao.Close;
      conexao.Params.Clear;
      conexao.Params.Add('DriverUnit=Data.DBXDataSnap');
      conexao.Params.Add('HostName='+ edtIPE.Text);
      conexao.Params.Add('Port=211');
      conexao.Params.Add('CommunicationProtocol=tcp/ip');
      conexao.Params.Add('DatasnapContext=datasnap/');
      conexao.Params.Add('DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=20.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
      conexao.Params.Add('Filters={}');
      conexao.Connected := True;
      cdsProduto.Open;
      cdsClientes.Open;
      lbl1.Text := 'Conectado com suscesso! Aguardando sincronização.';
      {if conexao.Connected then} btnConectarConfig.Text := 'Desconectar';

    end else
    begin
      conexao.Close;
      cdsProduto.Close;
      cdsClientes.Close;
      {if Not conexao.Connected then} btnConectarConfig.Text := 'Conectar';
    end;
  except
    ShowMessage('Porta ou IP incorreto, corrija e tente novamente!');
    TabControl1.ActiveTab := tabConfiguracoes;
  end;
end;

//--------------BOTAO FILTRAR CLIENTES ------------//

procedure TfrmPrincipal.btnFiltraClienteClick(Sender: TObject);
 Var
  ListItem: TListViewItem;
begin
  cdsClientes2.Filtered := false;

  cdsClientes2.Filter := 'UPPER(NOME) LIKE ''%' + AnsiUpperCase(edtFiltraClientes.Text) + '%''';

  cdsClientes2.Filtered := true;

  //--------------------------------------------------//

  Try
    lsvClientes.BeginUpdate;
    lsvClientes.Items.Clear;

    cdsClientes2.First;
    while not cdsClientes2.Eof do
    Begin
      ListItem      := lsvClientes.Items.Add;
      ListItem.Text := cdsClientes2.FieldByName('NOME').AsString;

      if cdsClientes2.FieldByName('CPF').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Doc: ' +
                            cdsClientes2.FieldByName('CPF').AsString
      else
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Sem Documentos cadastrados!';

      if cdsClientes2.FieldByName('TELEFONE1').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Fone: ' +
                            cdsClientes2.FieldByName('TELEFONE1').AsString
      else
      if cdsClientes2.FieldByName('CELULAR').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Cel: ' +
                            cdsClientes2.FieldByName('CELULAR').AsString
      else
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Sem Telefones cadastrados!';

      if cdsClientes2.FieldByName('SITUACAO').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail3]:= 'Situação: ' +
                            cdsClientes2.FieldByName('SITUACAO').AsString;

      cdsClientes2.Next;
    End;

  except
    ShowMessage('Você não está conectado ao servidor!');
    TabControl1.ActiveTab := tabConfiguracoes;
    lsvClientes.EndUpdate;
  end;

end;

//------------- BOTAO FILTRAR PRODUTOS ----------------//

procedure TfrmPrincipal.btnFiltraProdutosClick(Sender: TObject);
Var
  ListItem: TListViewItem;
begin
  //----------FILTRA PELO CODIGO DE BARRAS------------------//
  if edtFiltraProdutos.Text.Length = 13 then
  begin



      cdsProduto2.Filtered := false;

      cdsProduto2.Filter := 'UPPER(CODBARRA) LIKE ''%' + AnsiUpperCase(edtFiltraProdutos.Text) + '%''';

      cdsProduto2.Filtered := true;

      



  end
  //----------FILTRA PELO NOME DO PRODUTO------------------//

  else
  begin
    cdsProduto2.Filtered := false;

    cdsProduto2.Filter := 'UPPER(PRODUTO) LIKE ''%' + AnsiUpperCase(edtFiltraProdutos.Text) + '%''';

    cdsProduto2.Filtered := true;
  end;


  //--------------------------------------------------//

  Try

    lstProdutos.BeginUpdate;
    lstProdutos.Items.Clear;

    cdsProduto2.First;
    while not cdsProduto2.Eof do
    Begin

      ListItem                := lstProdutos.Items.Add;
      ListItem.Text           := cdsProduto2.FieldByName('PRODUTO').AsString;
      if cdsProduto2.FieldByName('CODIGO').AsString <> '' then
         ListItem.Data[TMultiDetailAppearanceNames.Detail1]:= 'Código: ' +
                            cdsProduto2.FieldByName('CODIGO').DisplayText;
      if cdsProduto2.FieldByName('ESTOQUE').AsInteger > 0 then
         ListItem.Data[TMultiDetailAppearanceNames.Detail2]:= 'Estoque: ' +
                            FormatFloat('###,###,##0.00', cdsProduto2.FieldByName('ESTOQUE').Asfloat) +
                            '   Preço: ' +
                            FormatFloat('###,###,##0.00', cdsProduto2.FieldByName('PRECOVENDA').AsFloat);

         ListItem.Data[TMultiDetailAppearanceNames.Detail3]:= 'Apl: ' +
                                                          cdsProduto2.FieldByName('APLICACAO').Asstring;

      cdsProduto2.Next;
    End;
  except
    ShowMessage('Você não está conectado ao servidor!');
    TabControl1.ActiveTab := tabConfiguracoes;
    lstProdutos.EndUpdate;

  End;

end;

//------------BOTAO INSERIR IP ------------------------//

procedure TfrmPrincipal.btnInserirIPClick(Sender: TObject);
begin
  FDTable1.Open;
  FDTable1.Append;
end;

procedure TfrmPrincipal.btnSincronizarClick(Sender: TObject);
begin
//-----------salva os arquivos em txt ------------------//
  if btnConectarConfig.Text = 'Conectar' then
  begin
    ShowMessage('Você precisa se conectar, clique em conectar e tente novamente!')
  end
  else
  begin
    lbl1.Text := 'Sincronizando... aguarde';
    cdsProduto.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'Produtos.txt'));
    cdsClientes.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'Clientes.txt'));
  //-----------carrega os arquivos no clientdataset ------//
    cdsProduto2.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'Produtos.txt'));
    cdsClientes2.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'Clientes.txt'));

    lbl1.Text := 'Sincronizado ' + DateTimeToStr(Now);
    ShowMessage('Sincronizados ' + IntToStr(cdsProduto2.RecordCount) + ' produtos.');
    ShowMessage('Sincronizados ' + IntToStr(cdsClientes2.RecordCount) + ' clientes.');
  end;
end;

//------------- DEPOIS DE CONECTAR -------------------//

procedure TfrmPrincipal.conexaoIPAfterConnect(Sender: TObject);
begin
  conexaoIP.ExecSQL('CREATE TABLE IF NOT EXISTS ACCESSO (IP  TEXT NOT NULL)');
end;

//------------- ANTES DA CONEXAO --------------------//

procedure TfrmPrincipal.conexaoIPBeforeConnect(Sender: TObject);
begin
    {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  conexaoIP.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'IP.s3db');
  {$ENDIF}
end;

//------------- AO ATIVAR O FORM -------------------//

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  edtFiltraProdutos.text := '';
  ClipService.SetClipboard('nil');
  lbl1.Text := 'Aguardando sincronização.';
end;

//------------- AO CRIAR O FORM -------------------//

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  if not TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    ClipService := nil;

  Elapsed := 0;

  //--------------carrega os cds a partir do banco local ----------//
  try
    FDTable1.Open;
    cdsProduto2.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'Produtos.txt'));
    cdsClientes2.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'Clientes.txt'));
  except
    ShowMessage('O banco local esta vazio Clique em Sincronizar!');

    TabControl1.ActiveTab := tabConfiguracoes;
  end;


end;

//------------- AO CLICAR NA IMAGEM DE PRODUTOS -------------------//

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin
  TAProdutos.ExecuteTarget(Self);
end;

//------------- PROCEDIMENTO PARA FECHAR O FORM -------------------//

procedure TfrmPrincipal.TASairExecute(Sender: TObject);
begin
  Close;
end;

//------------- NO TIMER PARA CAPTURAR CODIGO DE BARRAS -------------------//

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  if (ClipService.GetClipboard.ToString <> 'nil') then
  begin
    timer1.Enabled := false;
    Elapsed := 0;
    edtFiltraProdutos.Text := ClipService.GetClipboard.ToString;
  end
  else
    begin
      if Elapsed > 9 then
        begin
          timer1.Enabled := false;
          Elapsed := 0;
        end
      else
          Elapsed := Elapsed +1;
    end;
end;

end.
