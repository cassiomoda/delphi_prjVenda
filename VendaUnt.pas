unit VendaUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DmUnt, selProdutoUnt,
  selDescontoUnt, selFormaPagamentoUnt;

type
  TVendaFrm = class(TForm)
    tituloPnl: TPanel;
    codigoVendaLbl: TLabel;
    vendaPC: TPageControl;
    itensTS: TTabSheet;
    totaisTS: TTabSheet;
    dataVendaEdt: TDBEdit;
    dataLbl: TLabel;
    produtoLbl: TLabel;
    produtoEdt: TDBEdit;
    quantidadeEdt: TDBEdit;
    quantidadeLbl: TLabel;
    valorEdt: TDBEdit;
    valorLbl: TLabel;
    descricaoProdutolbl: TLabel;
    itensDbGrid: TDBGrid;
    novoItemBtn: TButton;
    buscarProdutoBtn: TButton;
    descontosGB: TGroupBox;
    descontosDbGrid: TDBGrid;
    novoDescontoBtn: TButton;
    pagamentosGB: TGroupBox;
    pagamentosDbGrid: TDBGrid;
    novoPagamento: TButton;
    okItemBtn: TButton;
    cancelarItemBtn: TButton;
    rodapePnl: TPanel;
    cancelarBtn: TButton;
    gravarBtn: TButton;
    editarItemBtn: TButton;
    totaisPnl: TPanel;
    txtSubtotalLbl: TLabel;
    txtDescontosLbl: TLabel;
    txtTotalLbl: TLabel;
    subtotalLbl: TLabel;
    descontosLbl: TLabel;
    totalLbl: TLabel;
    valorPagoLbl: TLabel;
    txtValorPagoLbl: TLabel;
    resumoItensListBox: TListBox;
    procedure novoItemBtnClick(Sender: TObject);
    procedure buscarProdutoBtnClick(Sender: TObject);
    procedure okItemBtnClick(Sender: TObject);
    procedure cancelarItemBtnClick(Sender: TObject);
    procedure cancelarBtnClick(Sender: TObject);
    procedure gravarBtnClick(Sender: TObject);
    procedure editarItemBtnClick(Sender: TObject);
    procedure novoDescontoBtnClick(Sender: TObject);
    procedure novoPagamentoClick(Sender: TObject);
    procedure itensDbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure itensDbGridCellClick(Column: TColumn);
    procedure descontosDbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure descontosDbGridCellClick(Column: TColumn);
    procedure pagamentosDbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pagamentosDbGridCellClick(Column: TColumn);
    procedure vendaPCChange(Sender: TObject);
    procedure produtoEdtExit(Sender: TObject);
    procedure valorEdtKeyPress(Sender: TObject; var Key: Char);
    procedure quantidadeEdtKeyPress(Sender: TObject; var Key: Char);
    procedure produtoEdtKeyPress(Sender: TObject; var Key: Char);
    procedure dataVendaEdtExit(Sender: TObject);
  private
    { Private declarations }
    codVenda: Integer;
    totalVenda: double;
    totalDescontos: double;
    totalPago: double;

    procedure LimparForm();
    procedure AbrirQrys();
    procedure AbilitarCamposItem();
    procedure TotalizarVenda();
    procedure AtualizarTela();
  public
    { Public declarations }

    procedure NovaVenda();
    procedure EditarVenda(codigo: Integer);
  end;

var
  VendaFrm: TVendaFrm;

implementation

{$R *.dfm}

procedure TVendaFrm.LimparForm();
begin
  codigoVendaLbl.Caption := '';
  descricaoProdutolbl.Caption := '';

  produtoEdt.Enabled := false;
  quantidadeEdt.Enabled := false;
  valorEdt.Enabled := false;

  dm.itemVendaQry.Close;
  dm.descontoVendaQry.Close;
  dm.receitaVendaQry.Close;
  dm.vendaQry.Close;
end;

procedure TVendaFrm.AbrirQrys();
begin
  dm.vendaQry.ParamByName('codVenda').AsInteger := codVenda;
  dm.vendaQry.Open;

  dm.itemVendaQry.ParamByName('codVenda').AsInteger := codVenda;
  dm.itemVendaQry.Open;

  dm.descontoVendaQry.ParamByName('codVenda').AsInteger := codVenda;
  dm.descontoVendaQry.Open;

  dm.receitaVendaQry.ParamByName('codVenda').AsInteger := codVenda;
  dm.receitaVendaQry.Open;
end;

procedure TVendaFrm.AbilitarCamposItem();
begin
  produtoEdt.Enabled := true;
  quantidadeEdt.Enabled := true;
  valorEdt.Enabled := true;
  novoItemBtn.Enabled := false;
  editarItemBtn.Enabled := false;
  buscarProdutoBtn.Enabled := true;
  okItemBtn.Enabled := true;
  cancelarItemBtn.Enabled := true;
end;

procedure TVendaFrm.TotalizarVenda();
begin
  try
    resumoItensListBox.Items.Clear;
    totalVenda := 0;
    dm.itemVendaQry.First;

    while not dm.itemVendaQry.Eof do
    begin
      totalVenda := totalVenda + dm.itemVendaQryVALOR_SUBTOTAL.Value;
      resumoItensListBox.Items.Add(
        dm.itemVendaQryDESCRICAO.AsString + ' - ' +
        dm.itemVendaQryQTDE.AsString + 'x' +
        ' R$ ' + FormatFloat('0.00', dm.itemVendaQryVALOR_SUBTOTAL.Value)
      );

      dm.itemVendaQry.Next;
    end;

    subtotalLbl.Caption := 'R$ ' + FormatFloat('0.00', totalVenda);
    totalDescontos := 0;
    dm.descontoVendaQry.First;

    while not dm.descontoVendaQry.Eof do
    begin
      totalDescontos := totalDescontos + (totalVenda * (dm.descontoVendaQryVALOR_PERCENTUAL.Value / 100));

      dm.descontoVendaQry.Next;
    end;

    descontosLbl.Caption := 'R$ ' + FormatFloat('0.00', totalDescontos);
    totalVenda := totalVenda - totalDescontos;

    if totalVenda < 0 then
      totalVenda := 0;

    totalPago := 0;
    dm.receitaVendaQry.First;

    while not dm.receitaVendaQry.Eof do
    begin
      totalPago := totalPago + dm.receitaVendaQryVALOR.Value;

      dm.receitaVendaQry.Next;
    end;

    valorPagoLbl.Caption := 'R$ ' + FormatFloat('0.00', totalPago);
  finally
    totalLbl.Caption := 'R$ ' + FormatFloat('0.00', totalVenda);
  end;
end;

procedure TVendaFrm.valorEdtKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', ',' ,#8]) then
    key :=#0;
end;

procedure TVendaFrm.vendaPCChange(Sender: TObject);
begin
  AtualizarTela();
  TotalizarVenda();
end;

procedure TVendaFrm.NovaVenda();
begin
  LimparForm();
  codVenda := -1;
  AbrirQrys();
  dm.vendaQry.Insert;
  codVenda := dm.GerarCodVenda();
  dm.vendaQryCODIGO.Value := codVenda;
  dm.vendaQryDATA.AsDateTime := Date();
  codigoVendaLbl.Caption := 'Venda: ' + IntToStr(codVenda);
  AtualizarTela();
  novoItemBtn.Click;
  ShowModal;
end;

procedure TVendaFrm.novoDescontoBtnClick(Sender: TObject);
begin
  if dm.descontoVendaQry.RecordCount = 0 then
  begin
    if selDescontoFrm = nil then
      Application.CreateForm(TselDescontoFrm, selDescontoFrm);

    selDescontoFrm.ShowModal;

    if selDescontoFrm.ModalResult = mrOk then
    begin
      dm.descontoVendaQry.First;

      while not dm.descontoVendaQry.Eof do
      begin
        if dm.descontoVendaQryCODIGO_DESCONTO.Value = selDescontoFrm.codigo then
        begin
          MessageDlg('Desconto j� aplicado.', mtInformation, [mbOk], 0);
          Abort;
        end;

        dm.descontoVendaQry.Next;
      end;

      dm.descontoVendaQry.Insert;
      dm.descontoVendaQryCODIGO_SEQUENCIAL.Value := dm.GerarSeqDescontoVenda();
      dm.descontoVendaQryCODIGO_VENDA.Value := codVenda;
      dm.descontoVendaQryCODIGO_DESCONTO.Value := selDescontoFrm.codigo;
      dm.descontoVendaQryDESCRICAO_DESCONTO.Value := selDescontoFrm.descricao;
      dm.descontoVendaQryVALOR_PERCENTUAL.Value := selDescontoFrm.percentual;
      dm.descontoVendaQry.Post;
      TotalizarVenda();
    end;
  end
  else
    MessageDlg('S� pode ser adicionado um unico desconto para cada Venda.', mtInformation, [mbOk], 0);
end;

procedure TVendaFrm.novoItemBtnClick(Sender: TObject);
var
  codSeq: integer;
begin
  codSeq := dm.GerarSeqItemVenda;

  if codSeq > 0 then
  begin
    cancelarItemBtn.Click;
    itensDbGrid.Enabled := false;
    dm.itemVendaQry.Insert;
    dm.itemVendaQryCODIGO_VENDA.Value := codVenda;
    dm.itemVendaQryCODIGO_SEQUENCIAL.Value := codSeq;
    dm.itemVendaQryCODIGO_PRODUTO.Clear;
    dm.itemVendaQryVALOR.Value := 0.0;
    dm.itemVendaQryQTDE.Value := 0;
    dm.itemVendaQryVALOR_SUBTOTAL.Value := 0.0;
    AbilitarCamposItem();
  end
  else
    MessageDlg('N�o foi poss�vel gerar a sequencia do novo item.', mtWarning, [mbOk], 0);
end;

procedure TVendaFrm.novoPagamentoClick(Sender: TObject);
begin
  if dm.receitaVendaQry.RecordCount = 0 then
  begin
    if (totalVenda - totalPago) > 0 then
    begin
      if selFormaPagamentoFrm = nil then
        Application.CreateForm(TselFormaPagamentoFrm, selFormaPagamentoFrm);

      selFormaPagamentoFrm.valorEdt.Text := FormatFloat('0.00', totalVenda - totalPago);
      selFormaPagamentoFrm.ShowModal;

      if selFormaPagamentoFrm.ModalResult = mrOk then
      begin
        dm.receitaVendaQry.Insert;
        dm.receitaVendaQryCODIGO_SEQUENCIAL.Value := dm.GerarSeqReceitaVenda();
        dm.receitaVendaQryCODIGO_VENDA.Value := codVenda;
        dm.receitaVendaQryCODIGO_RECEITA.Value := selFormaPagamentoFrm.formaPagamentoCb.KeyValue;
        dm.receitaVendaQryDESCRICAO_RECEITA.Value := selFormaPagamentoFrm.formaPagamentoCb.Text;
        dm.receitaVendaQryVALOR.Value := StrToFloat(selFormaPagamentoFrm.valorEdt.Text);
        dm.receitaVendaQry.Post;
        TotalizarVenda();
      end;
    end;
  end
  else
    MessageDlg('S� pode ser adicionada uma unica Forma de Pagamento para cada Venda.', mtInformation, [mbOk], 0);
end;

procedure TVendaFrm.okItemBtnClick(Sender: TObject);
begin
  if (dm.itemVendaQryCODIGO_PRODUTO.Value > 0) and
     (dm.itemVendaQryVALOR.Value > 0) and
     (dm.itemVendaQryQTDE.Value > 0) then
  begin
    dm.itemVendaQryVALOR_SUBTOTAL.Value := dm.itemVendaQryVALOR.Value *
      dm.itemVendaQryQTDE.Value;
    dm.itemVendaQry.Post;
    novoItemBtn.Click;
  end
  else
  begin
    MessageDlg('Por favor, informe o Produto, a quantidade e o valor.', mtWarning, [mbOk], 0);
    produtoEdt.SetFocus;
  end;
end;

procedure TVendaFrm.pagamentosDbGridCellClick(Column: TColumn);
begin
  if (Column.FieldName = 'BtnExcluir') and
     (dm.receitaVendaQry.RecordCount > 0) then
  begin
    if MessageDlg('Deseja excluir a Forma de Pagamento selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      dm.receitaVendaQry.Delete;
      TotalizarVenda();
    end;
  end;
end;

procedure TVendaFrm.pagamentosDbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  btn: integer;
  r: TRect;
  cor: TColor;
begin
  if Column.FieldName = 'BtnExcluir' then
  begin
    pagamentosDbGrid.Canvas.FillRect(Rect);
    btn := 0;
    r := Rect;
    DrawFrameControl(pagamentosDbGrid.Canvas.Handle, r, btn, btn or btn);
    cor := pagamentosDbGrid.Canvas.Brush.Color;
    pagamentosDbGrid.Canvas.Brush.Color := clBtnFace;
    DrawText(pagamentosDbGrid.Canvas.Handle, 'Excluir', 7, r, DT_VCENTER or DT_CENTER);
    pagamentosDbGrid.Canvas.Brush.Color := cor;
  end;
end;

procedure TVendaFrm.produtoEdtExit(Sender: TObject);
begin
  dm.itemVendaQryDESCRICAO.Clear;
  dm.itemVendaQryVALOR.Value := 0;
  descricaoProdutolbl.Caption := '';

  if produtoEdt.Text <> '' then
  begin
    if not dm.listaProdutosQry.Active then
      dm.listaProdutosQry.Open;

    try
      dm.listaProdutosQry.Filter := 'CODIGO = ' + produtoEdt.Text;
      dm.listaProdutosQry.Filtered := true;

      if not dm.listaProdutosQry.Eof then
      begin
        dm.itemVendaQryCODIGO_PRODUTO.Value := dm.listaProdutosQryCODIGO.Value;
        dm.itemVendaQryVALOR.Value := dm.listaProdutosQryVALOR.Value;
        dm.itemVendaQryDESCRICAO.Value := dm.listaProdutosQryDESCRICAO.Value;
        descricaoProdutolbl.Caption := dm.itemVendaQryDESCRICAO.Value;
      end
      else
      begin
        MessageDlg('Produto n�o localizado.', mtWarning, [mbOk], 0);
        produtoEdt.SetFocus;
      end;
    finally
      dm.listaProdutosQry.Filtered := false;
      dm.listaProdutosQry.Filter := '';
    end;
  end;
end;

procedure TVendaFrm.produtoEdtKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9' ,#8]) then
    key :=#0;
end;

procedure TVendaFrm.quantidadeEdtKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9' ,#8]) then
    key :=#0;
end;

procedure TVendaFrm.buscarProdutoBtnClick(Sender: TObject);
begin
  if selProdutoFrm = nil then
    Application.CreateForm(TselProdutoFrm, selProdutoFrm);

  selProdutoFrm.ShowModal;

  if selProdutoFrm.ModalResult = mrOk then
  begin
    dm.itemVendaQryCODIGO_PRODUTO.Value := selProdutoFrm.codProduto;
    dm.itemVendaQryDESCRICAO.Value := selProdutoFrm.descricaoProduto;
    dm.itemVendaQryVALOR.Value := selProdutoFrm.valorProduto;
    descricaoProdutolbl.Caption := dm.itemVendaQryDESCRICAO.Value;
    quantidadeEdt.SetFocus;
  end;
end;

procedure TVendaFrm.cancelarBtnClick(Sender: TObject);
begin
  dm.descontoVendaQry.Cancel;
  dm.receitaVendaQry.Cancel;
  dm.itemVendaQry.Cancel;
  dm.vendaQry.Cancel;

  if dm.vendaTR.Active then
    dm.vendaTR.Rollback;

  Close;
end;

procedure TVendaFrm.cancelarItemBtnClick(Sender: TObject);
begin
  dm.itemVendaQry.Cancel;
  produtoEdt.Enabled := false;
  buscarProdutoBtn.Enabled := false;
  descricaoProdutoLbl.Caption := '';
  quantidadeEdt.Enabled := false;
  valorEdt.Enabled := false;
  okItemBtn.Enabled := false;
  cancelarItemBtn.Enabled := false;
  itensDbGrid.Enabled := true;
  novoItemBtn.Enabled := true;
  editarItemBtn.Enabled := true;
end;

procedure TVendaFrm.dataVendaEdtExit(Sender: TObject);
begin
  if dm.vendaQryDATA.AsDateTime > Date then
  begin
    MessageDlg('A data da Venda n�o pode ser maior que a data atual.', mtWarning, [mbOk], 0);
    dataVendaEdt.SetFocus;
  end;
end;

procedure TVendaFrm.descontosDbGridCellClick(Column: TColumn);
begin
  if (Column.FieldName = 'BtnExcluir') and
     (dm.descontoVendaQry.RecordCount > 0) then
  begin
    if MessageDlg('Deseja excluir o desconto selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      dm.descontoVendaQry.Delete;
      TotalizarVenda();
    end;
  end;
end;

procedure TVendaFrm.descontosDbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  btn: integer;
  r: TRect;
  cor: TColor;
begin
  if Column.FieldName = 'BtnExcluir' then
  begin
    descontosDbGrid.Canvas.FillRect(Rect);
    btn := 0;
    r := Rect;
    DrawFrameControl(descontosDbGrid.Canvas.Handle, r, btn, btn or btn);
    cor := descontosDbGrid.Canvas.Brush.Color;
    descontosDbGrid.Canvas.Brush.Color := clBtnFace;
    DrawText(descontosDbGrid.Canvas.Handle, 'Excluir', 7, r, DT_VCENTER or DT_CENTER);
    descontosDbGrid.Canvas.Brush.Color := cor;
  end;
end;

procedure TVendaFrm.editarItemBtnClick(Sender: TObject);
begin
  if dm.itemVendaQry.RecordCount > 0 then
  begin
    cancelarItemBtn.Click;
    AbilitarCamposItem();
  end;
end;

procedure TVendaFrm.EditarVenda(codigo: Integer);
begin
  LimparForm();
  codVenda := codigo;
  AbrirQrys();
  dm.vendaQry.Edit;
  AtualizarTela();
  ShowModal();
end;

procedure TVendaFrm.AtualizarTela();
begin
  if vendaPC.ActivePage = totaisTS then
  begin
    gravarBtn.Caption := 'Gravar';
    cancelarItemBtn.Click;
    vendaPC.ActivePage := totaisTS;
  end
  else if vendaPC.ActivePage = itensTS then
  begin
    cancelarItemBtn.Click;
    gravarBtn.Caption := 'Pr�ximo';
    TotalizarVenda();
  end;
end;

procedure TVendaFrm.gravarBtnClick(Sender: TObject);
begin
  if vendaPC.ActivePage = itensTS then
  begin
    vendaPC.ActivePage := totaisTS;
    AtualizarTela();
    TotalizarVenda();
  end
  else
  begin
    if (FormatFloat('0.00', totalVenda) <> FormatFloat('0.00', totalPago)) then
      MessageDlg('Total recebido pelas Formas de Pagamento � diferente do total da Venda.', mtWarning, [mbOk], 0)
    else
    begin
      try
        dm.vendaTR.StartTransaction;

        dm.vendaQryVALOR_BRUTO.Value := totalVenda + totalDescontos;
        dm.vendaQryVALOR_DESCONTO.Value := totalDescontos;
        dm.vendaQryVALOR_LIQUIDO.Value := totalVenda;
        dm.vendaQry.Post;
        dm.vendaQry.ApplyUpdates(0);

        dm.itemVendaQry.ApplyUpdates(0);
        dm.descontoVendaQry.ApplyUpdates(0);
        dm.receitaVendaQry.ApplyUpdates(0);

        dm.vendaTR.Commit;

        Close;
      except
        dm.vendaTR.Rollback;
      end;
    end;
  end;
end;

procedure TVendaFrm.itensDbGridCellClick(Column: TColumn);
begin
  if (Column.FieldName  ='BtnExcluir') and
     (dm.itemVendaQry.RecordCount > 0) then
  begin
    if MessageDlg('Deseja excluir o item selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      dm.itemVendaQry.Delete;
  end;
end;

procedure TVendaFrm.itensDbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  btn: integer;
  r: TRect;
  cor: TColor;
begin
  if Column.FieldName = 'BtnExcluir' then
  begin
    itensDbGrid.Canvas.FillRect(Rect);
    btn := 0;
    r := Rect;
    DrawFrameControl(itensDbGrid.Canvas.Handle, r, btn, btn or btn);
    cor := itensDbGrid.Canvas.Brush.Color;
    itensDbGrid.Canvas.Brush.Color := clBtnFace;
    DrawText(itensDbGrid.Canvas.Handle, 'Excluir', 7, r, DT_VCENTER or DT_CENTER);
    itensDbGrid.Canvas.Brush.Color := cor;
  end;
end;

end.
