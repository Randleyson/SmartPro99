object frmPrincipal: TfrmPrincipal
  Left = 271
  Top = 114
  Caption = 'WebService '
  ClientHeight = 374
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 374
    Align = alClient
    Color = 2697513
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = -40
    ExplicitTop = -8
    ExplicitWidth = 552
    ExplicitHeight = 480
    object Label2: TLabel
      Left = 151
      Top = 8
      Width = 266
      Height = 81
      Align = alCustom
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Rest WebService Application'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Swis721 WGL4 BT'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label1: TLabel
      Left = 21
      Top = 326
      Width = 23
      Height = 14
      Caption = 'Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 21
      Top = 92
      Width = 77
      Height = 13
      Caption = 'Registro de logs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object menoLogs: TMemo
      Left = 21
      Top = 111
      Width = 433
      Height = 209
      Color = 1776411
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Ws iniciado com exito')
      ParentFont = False
      TabOrder = 0
    end
    object edtPorta: TEdit
      Left = 21
      Top = 346
      Width = 121
      Height = 19
      TabOrder = 1
      Text = '8080'
    end
    object ButtonOpenBrowser: TButton
      Left = 310
      Top = 343
      Width = 107
      Height = 25
      Caption = 'Open Browser'
      TabOrder = 2
      OnClick = ButtonOpenBrowserClick
    end
    object btnStop: TButton
      Left = 229
      Top = 343
      Width = 75
      Height = 25
      Caption = 'Parar WS'
      TabOrder = 3
      OnClick = btnStopClick
    end
    object btnStart: TButton
      Left = 148
      Top = 343
      Width = 75
      Height = 25
      Caption = 'Ativar WS'
      TabOrder = 4
      OnClick = btnStartClick
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 400
    Top = 96
  end
  object tmSincronizaTxt: TTimer
    Interval = 200000
    OnTimer = tmSincronizaTxtTimer
    Left = 392
    Top = 32
  end
end
