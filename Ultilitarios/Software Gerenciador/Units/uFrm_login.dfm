object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Login'
  ClientHeight = 159
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 32
    Width = 39
    Height = 19
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 83
    Width = 43
    Height = 19
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtLogin: TEdit
    Left = 32
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 32
    Top = 108
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btn_Entrar: TButton
    Left = 184
    Top = 106
    Width = 75
    Height = 25
    Caption = 'Entrar'
    TabOrder = 2
    OnClick = btn_EntrarClick
  end
  object FDQUsuario: TFDQuery
    Connection = DmPrincipal.FDC_Freeboard
    SQL.Strings = (
      'select * from usuario')
    Left = 240
    Top = 16
  end
end
