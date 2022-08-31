unit PrincipalUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, DmUnt, VendaUnt,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TPrincipalFrm = class(TForm)
    principalPgc: TPageControl;
    vendasTS: TTabSheet;
    vendasBtnsPnl: TPanel;
    novaVendaBtn: TButton;
    vendasDbGrid: TDBGrid;
    itensVendaDbGrid: TDBGrid;
    vendasSplit: TSplitter;
    Panel1: TPanel;
    editarBtn: TButton;
    cancelarBtn: TButton;
    procedure FormShow(Sender: TObject);
    procedure novaVendaBtnClick(Sender: TObject);
    procedure editarBtnClick(Sender: TObject);
    procedure vendasDbGridDblClick(Sender: TObject);
    procedure vendasDbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure vendasDbGridCellClick(Column: TColumn);
    procedure cancelarBtnClick(Sender: TObject);
  private
    { Private declarations }

    procedure AtualizarLista();
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

{$R *.dfm}

procedure TPrincipalFrm.AtualizarLista();
begin
  dm.listaVendasQry.Close;
  dm.listaVendasQry.Open;
end;

procedure TPrincipalFrm.cancelarBtnClick(Sender: TObject);
begin
  if (dm.listaVendasQry.RecordCount > 0) and
     (MessageDlg('Deseja cancelar a venda selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    try
      dm.vendaTR.StartTransaction;
      dm.vendaQry.Close;
      dm.vendaQry.ParamByName('codVenda').AsInteger := dm.listaVendasQryCODIGO.Value;
      dm.vendaQry.Open;
      dm.vendaQry.Edit;
      dm.vendaQryCANCELADA.Value := 'S';
      dm.vendaQry.Post;
      dm.vendaQry.ApplyUpdates(0);
      dm.vendaTR.Commit;

      AtualizarLista();
    except
      dm.vendaTR.Rollback;
      MessageDlg('N�o foi poss�vel cancelar a venda, tente novamente.', mtWarning, [mbOk], 0);
    end;
  end;
end;

procedure TPrincipalFrm.editarBtnClick(Sender: TObject);
begin
  if dm.listaVendasQry.RecordCount > 0 then
  begin
    if dm.listaVendasQryCANCELADA.AsString = 'S' then
      MessageDlg('N�o � possivel editar uma venda cancelada.', mtInformation, [mbOk], 0)
    else
    begin
      if VendaFrm = nil then
        Application.CreateForm(TVendaFrm, VendaFrm);

      VendaFrm.EditarVenda(dm.listaVendasQryCODIGO.Value);
      AtualizarLista();
      FreeAndNil(VendaFrm);
    end;
  end;
end;

procedure TPrincipalFrm.FormShow(Sender: TObject);
begin
  if DM = nil then
    Application.CreateForm(TDM, DM);

  if not DM.Conectar() then
  begin
    MessageDlg('N�o foi poss�vel conectar a base de dados. Verifique as configura��es.',
      mtWarning, [mbOk], 0);
    Close;
  end;

  AtualizarLista();
end;

procedure TPrincipalFrm.novaVendaBtnClick(Sender: TObject);
begin
  if VendaFrm = nil then
    Application.CreateForm(TVendaFrm, VendaFrm);

  VendaFrm.NovaVenda();
  AtualizarLista();
  FreeAndNil(VendaFrm);
end;

procedure TPrincipalFrm.vendasDbGridCellClick(Column: TColumn);
begin
  if (Column.FieldName = 'BtnExcluir') and
     (dm.listaVendasQry.RecordCount > 0) then
  begin
    if MessageDlg('Deseja excluir a Venda selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if dm.ExcluirVenda(dm.listaVendasQryCODIGO.Value) then
        MessageDlg('Venda eclu�da com sucesso!', mtInformation, [mbOk], 0)
      else
        MessageDlg('N�o foi poss�vel excluir a venda.', mtWarning, [mbOk], 0);

      AtualizarLista();
    end;
  end;
end;

procedure TPrincipalFrm.vendasDbGridDblClick(Sender: TObject);
begin
  editarBtn.Click;
end;

procedure TPrincipalFrm.vendasDbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  btn: integer;
  r: TRect;
  cor: TColor;
begin
  if Column.FieldName = 'BtnExcluir' then
  begin
    vendasDbGrid.Canvas.FillRect(Rect);
    btn := 0;
    r := Rect;
    DrawFrameControl(vendasDbGrid.Canvas.Handle, r, btn, btn or btn);
    cor := vendasDbGrid.Canvas.Brush.Color;
    vendasDbGrid.Canvas.Brush.Color := clBtnFace;
    DrawText(vendasDbGrid.Canvas.Handle, 'Excluir', 7, r, DT_VCENTER or DT_CENTER);
    vendasDbGrid.Canvas.Brush.Color := cor;
  end;
end;

end.
