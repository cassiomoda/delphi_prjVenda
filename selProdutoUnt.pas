unit selProdutoUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, DmUnt;

type
  TselProdutoFrm = class(TForm)
    filtroPnl: TPanel;
    produtosDbGrid: TDBGrid;
    filtroEdt: TEdit;
    procedure FormShow(Sender: TObject);
    procedure produtosDbGridDblClick(Sender: TObject);
    procedure filtroEdtChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    codProduto: integer;
    descricaoProduto: string;
    valorProduto: double;
  end;

var
  selProdutoFrm: TselProdutoFrm;

implementation

{$R *.dfm}

procedure TselProdutoFrm.filtroEdtChange(Sender: TObject);
begin
  if filtroEdt.Text <> '' then
  begin
    dm.listaProdutosQry.Filtered := false;
    dm.listaProdutosQry.Filter := 'upper(DESCRICAO) like ' + QuotedStr('%' + filtroEdt.Text + '%');
    dm.listaProdutosQry.Filtered := true;
  end;
end;

procedure TselProdutoFrm.FormShow(Sender: TObject);
begin
  filtroEdt.Clear;
  dm.listaProdutosQry.Close;
  dm.listaProdutosQry.Open;
  codProduto := 0;
  descricaoProduto := '';
  valorProduto := 0.0;
end;

procedure TselProdutoFrm.produtosDbGridDblClick(Sender: TObject);
begin
  codProduto := dm.listaProdutosQryCODIGO.Value;
  descricaoProduto := dm.listaProdutosQryDESCRICAO.Value;
  valorProduto := dm.listaProdutosQryVALOR.Value;
  ModalResult := mrOk;
end;

end.
