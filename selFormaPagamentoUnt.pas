unit selFormaPagamentoUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, DmUnt, Vcl.StdCtrls,
  Vcl.Mask;

type
  TselFormaPagamentoFrm = class(TForm)
    formaPagamentoCb: TDBLookupComboBox;
    formaPagamentoLbl: TLabel;
    valorLbl: TLabel;
    okBtn: TButton;
    valorEdt: TEdit;
    procedure FormShow(Sender: TObject);
    procedure okBtnClick(Sender: TObject);
    procedure valorEdtKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  selFormaPagamentoFrm: TselFormaPagamentoFrm;

implementation

{$R *.dfm}

procedure TselFormaPagamentoFrm.FormShow(Sender: TObject);
begin
  formaPagamentoCb.KeyValue := 1;
end;

procedure TselFormaPagamentoFrm.okBtnClick(Sender: TObject);
  procedure AlertarUsuario;
  begin
    MessageDlg('Informe um valor v�lido.', mtWarning, [mbOk], 0);
    valorEdt.SetFocus;
  end;
begin
  try
    if StrToFloat(valorEdt.Text) > 0.01 then
      ModalResult := mrOk
    else
    begin
      AlertarUsuario;
    end;
  except
    AlertarUsuario;
  end;
end;

procedure TselFormaPagamentoFrm.valorEdtKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9', ',' ,#8]) then
    key :=#0;
end;

end.
