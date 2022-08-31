program VendasPrj;

uses
  Vcl.Forms,
  PrincipalUnt in 'PrincipalUnt.pas' {PrincipalFrm},
  DmUnt in 'DmUnt.pas' {DM: TDataModule},
  VendaUnt in 'VendaUnt.pas' {VendaFrm},
  selProdutoUnt in 'selProdutoUnt.pas' {selProdutoFrm},
  selDescontoUnt in 'selDescontoUnt.pas' {selDescontoFrm},
  selFormaPagamentoUnt in 'selFormaPagamentoUnt.pas' {selFormaPagamentoFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.Run;
end.
