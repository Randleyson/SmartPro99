unit Controller.oConfiguracao;

interface

uses
  Controller.uConfiguracao;

type
  ToConfiguracao = class
  private
    uConfiguracao: TuConfiguracao;
    FDriverDB: String;
    FIpBD: String;
    FPortaDB: String;
    FBancoDB: String;
    FUsuarioDB: String;
    FSenhaDB: String;

    FPortaServer: String;
    FUsuarioServer: String;
    FSenhaServer: String;
    FPastaDB: String;
  public
    property DriverDB: String read FDriverDB write FDriverDB;
    property IpDB: string read FIpBD write FIpBD;
    property PortaDB: String read FPortaDB write FPortaDB;
    property BancoDB: String read FBancoDB write FBancoDB;
    property PastaDB: String read FPastaDB write FPastaDB;
    property UsuarioDB: string read FUsuarioDB write FUsuarioDB;
    property SenhaDB: string read FSenhaDB write FSenhaDB;
    property UsuarioServer: string read FUsuarioServer write FUsuarioServer;
    property SenhaServer: string read FSenhaServer write FSenhaServer;
    property PortaServer: String read FPortaServer write FPortaServer;
    procedure CarregaConfigIni;
    procedure SalvarConfigIni;
  end;

var
  oConfiguracao: ToConfiguracao;

implementation

uses
  System.SysUtils;

{ ToConfiguracao }

procedure ToConfiguracao.CarregaConfigIni;
begin
  uConfiguracao := TuConfiguracao.create;
  try
    try
      FDriverDB := uConfiguracao.GetConfig('BancoDados', 'DriverID');
      FPortaDB := uConfiguracao.GetConfig('BancoDados', 'Porta');
      FBancoDB := uConfiguracao.GetConfig('BancoDados', 'Banco');
      FPastaDB := uConfiguracao.GetConfig('BancoDados', 'Pasta');
      FIpBD := uConfiguracao.GetConfig('BancoDados', 'ip');
      FUsuarioDB := uConfiguracao.GetConfig('BancoDados', 'Usuario');
      FSenhaDB := uConfiguracao.GetConfig('BancoDados', 'Senha');

      FPortaServer := uConfiguracao.GetConfig('Server', 'Porta');
      FUsuarioServer := uConfiguracao.GetConfig('Server', 'Usuario');
      FSenhaServer := uConfiguracao.GetConfig('Server', 'Senha');

    except
      raise
    end;
  finally
    FreeAndNil(uConfiguracao);
  end;

end;

procedure ToConfiguracao.SalvarConfigIni;
begin

  uConfiguracao := TuConfiguracao.create;
  try
    try
      uConfiguracao.SetConfig('BancoDados', 'DriverID', FDriverDB);
      uConfiguracao.SetConfig('BancoDados', 'Porta', FPortaDB);
      uConfiguracao.SetConfig('BancoDados', 'Banco', FBancoDB);
      uConfiguracao.SetConfig('BancoDados', 'Pasta', FPastaDB);
      uConfiguracao.SetConfig('BancoDados', 'Usuario', FUsuarioDB);
      uConfiguracao.SetConfig('BancoDados', 'Senha', FSenhaDB);

      uConfiguracao.SetConfig('Server', 'DriverID', FPortaServer);
      uConfiguracao.SetConfig('Server', 'Usuario', FUsuarioServer);
      uConfiguracao.SetConfig('Server', 'Senha', FSenhaServer);
    except
      raise;

    end;

  finally
    FreeAndNil(uConfiguracao);
  end;

end;

end.
