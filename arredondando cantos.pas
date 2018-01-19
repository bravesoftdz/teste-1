unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Panel1: TPanel;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure DrawRounded(Control: TWinControl) ;
var
R: TRect;
Rgn: HRGN;
begin
with Control do
begin
  R := ClientRect;
  rgn := CreateRoundRectRgn(R.Left,
  R.Top, R.Right, R.Bottom, 20, 20);
  Perform(EM_GETRECT, 0, lParam(@r)) ;
  InflateRect(r, - 4, - 4) ;
  Perform(EM_SETRECTNP, 0, lParam(@r)) ;
  SetWindowRgn(Handle, rgn, True) ;
  Invalidate;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

// arredondando o Panel1
DrawRounded(Panel1) ;
// arredondando o Memo1
Memo1.BorderStyle := bsNone;
DrawRounded(Memo1) ;
// arredondando o Edit1
Edit1.BorderStyle := bsNone;

DrawRounded(Edit1) ;

end;

end.