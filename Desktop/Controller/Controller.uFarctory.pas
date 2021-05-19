unit Controller.uFarctory;

interface

uses
  View.FrmPrincipal, FMX.Forms, View.FrmConfiguracao, View.FrmProdutos,
  View.FrmTvs, Module.DmTvs, Module.DmProdutos, Module.DmUsuario,
  Module.DmConfiguracao;

type
  TFarctory = class
  private
    { View }
    FViewFrmPrincipal: TViewFrmPrincipal;
    FViewFrmConfiguracao: TViewFrmConfiguracao;
    FViewFrmProdutos: TViewFrmProdutos;
    FViewFrmTvs: TViewFrmTvs;
    { Module }
    FDmTvs: TDmTvs;
    FDmProduto: TDmProdutos;
    FDmUsuario: TDmUsuario;
    FDmConfiguracao: TDmConfiguracao;
    procedure DefineFormMain(FormAtivo: TForm);
  public
    function PrincipalView: TViewFrmPrincipal;
    function ConfiguracaoView: TViewFrmConfiguracao;
    function ProdutosView: TViewFrmProdutos;
    function TvsView: TViewFrmTvs;
    procedure ProdutosDestroyView;
    procedure TvsDestroyView;
    procedure ConfiguracaoDestroyView;
    function TvsDm: TDmTvs;
    function ProdutosDm: TDmProdutos;
    function UsuarioDm: TDmUsuario;
    function ConfiguracaoDm: TDmConfiguracao;
    procedure TvsDestroyDm;
    procedure ProdutosDestroyDm;
    procedure UsuarioDestroyDm;
    procedure ConfiguracaoDestroyDm;
  end;

var
  uFarctory: TFarctory;

implementation

uses
  System.SysUtils;

{ Farctory }

function TFarctory.ConfiguracaoDm: TDmConfiguracao;
begin
  if not Assigned(FDmConfiguracao) then
    FDmConfiguracao := TDmConfiguracao.Create(nil);
  Result := FDmConfiguracao;

end;

function TFarctory.ConfiguracaoView: TViewFrmConfiguracao;
begin
  if not Assigned(FViewFrmConfiguracao) then
    FViewFrmConfiguracao := TViewFrmConfiguracao.Create(nil);
  Result := FViewFrmConfiguracao;

end;

function TFarctory.PrincipalView: TViewFrmPrincipal;
begin

  if not Assigned(FViewFrmPrincipal) then
  begin
    FViewFrmPrincipal := TViewFrmPrincipal.Create(nil);
    DefineFormMain(FViewFrmPrincipal);
  end;
  Result := FViewFrmPrincipal;

end;

function TFarctory.ProdutosView: TViewFrmProdutos;
begin
  if not Assigned(FViewFrmProdutos) then
    FViewFrmProdutos := TViewFrmProdutos.Create(nil);
  Result := FViewFrmProdutos;

end;

function TFarctory.TvsView: TViewFrmTvs;
begin
  if not Assigned(FViewFrmTvs) then
    FViewFrmTvs := TViewFrmTvs.Create(Nil);

  FViewFrmTvs.Parent := FViewFrmPrincipal;
  Result := FViewFrmTvs;

end;

procedure TFarctory.UsuarioDestroyDm;
begin
  if Assigned(FDmUsuario) then
  begin
    FDmUsuario := Nil;
    FreeAndNil(FViewFrmConfiguracao);
  end;


end;

function TFarctory.UsuarioDm: TDmUsuario;
begin
  if not Assigned(FDmUsuario) then
    FDmUsuario := TDmUsuario.Create(nil);
  Result := FDmUsuario;

end;

procedure TFarctory.TvsDestroyDm;
begin
  if Assigned(FDmTvs) then
  begin
    FDmTvs := Nil;
    FreeAndNil(FDmTvs);
  end;
end;

procedure TFarctory.ConfiguracaoDestroyDm;
begin
  if Assigned(FDmConfiguracao) then
  begin
    FDmConfiguracao := Nil;
    FreeAndNil(FDmConfiguracao);
  end;

end;

procedure TFarctory.ConfiguracaoDestroyView;
begin
  if Assigned(FViewFrmConfiguracao) then
  begin
    FViewFrmConfiguracao.Release;
    FViewFrmConfiguracao := Nil;
    FreeAndNil(FViewFrmConfiguracao);
  end;

end;

procedure TFarctory.ProdutosDestroyDm;
begin
  if Assigned(FDmProduto) then
  begin
    FDmProduto := Nil;
    FreeAndNil(FDmProduto);
  end;


end;

procedure TFarctory.ProdutosDestroyView;
begin

  if Assigned(FViewFrmProdutos) then
  begin
    FViewFrmProdutos.Release;
    FViewFrmProdutos := Nil;
    FreeAndNil(FViewFrmProdutos);
  end;

end;

function TFarctory.ProdutosDm: TDmProdutos;
begin
  if not Assigned(FDmProduto) then
    FDmProduto := TDmProdutos.Create(nil);
  Result := FDmProduto;

end;

procedure TFarctory.TvsDestroyView;
begin
  if Assigned(FViewFrmTvs) then
  begin
    FViewFrmTvs.Release;
    FViewFrmTvs := Nil;
    FreeAndNil(FViewFrmTvs);
  end;

end;

function TFarctory.TvsDm: TDmTvs;
begin
  if not Assigned(FDmTvs) then
    FDmTvs := TDmTvs.Create(nil);
  Result := FDmTvs;

end;

procedure TFarctory.DefineFormMain(FormAtivo: TForm);
var
  TmpMain: ^TCustomForm;
begin
  TmpMain := @Application.Mainform;
  TmpMain^ := FormAtivo;

end;

end.
