object FrmConfiguracao: TFrmConfiguracao
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o'
  ClientHeight = 530
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 530
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 72
    ExplicitTop = 176
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblTituloDaTela: TLabel
      Left = 0
      Top = 0
      Width = 534
      Height = 34
      Align = alTop
      Alignment = taCenter
      Caption = 'Configura'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 451
    end
    object pnBotao: TPanel
      Left = 0
      Top = 489
      Width = 534
      Height = 41
      Align = alBottom
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      ExplicitLeft = 208
      ExplicitTop = 392
      ExplicitWidth = 185
      object btnSair: TButton
        Left = 458
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Sair'
        TabOrder = 0
        OnClick = btnSairClick
        ExplicitLeft = 110
        ExplicitTop = 16
        ExplicitHeight = 25
      end
      object btnSalvar: TButton
        Left = 383
        Top = 1
        Width = 75
        Height = 39
        Align = alRight
        Caption = 'Salvar'
        TabOrder = 1
        OnClick = btnSalvarClick
        ExplicitLeft = 381
      end
    end
    object pnDadoTxt: TPanel
      Left = 0
      Top = 34
      Width = 534
      Height = 119
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object gboxDadosConversao: TGroupBox
        Left = 0
        Top = 0
        Width = 534
        Height = 119
        Align = alClient
        Caption = 'Convers'#227'o de Dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitHeight = 231
        object Label2: TLabel
          Left = 2
          Top = 73
          Width = 530
          Height = 16
          Align = alTop
          Caption = 'Arquivo'
          ExplicitLeft = 3
          ExplicitTop = 91
        end
        object Panel1: TPanel
          Left = 2
          Top = 89
          Width = 530
          Height = 24
          Align = alTop
          Caption = 'Panel1'
          TabOrder = 0
          object btnPastaTxt: TButton
            Left = 454
            Top = 1
            Width = 75
            Height = 22
            Align = alRight
            Caption = 'Pasta'
            TabOrder = 0
            OnClick = btnPastaTxtClick
            ExplicitLeft = 136
            ExplicitTop = 24
            ExplicitHeight = 25
          end
          object edtCaminhoTxt: TEdit
            Left = 1
            Top = 1
            Width = 453
            Height = 22
            Align = alClient
            TabOrder = 1
            ExplicitTop = 6
            ExplicitHeight = 34
          end
        end
        object gRadioTipoDados: TRadioGroup
          Left = 2
          Top = 18
          Width = 530
          Height = 55
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alTop
          Caption = 'Tipo de arquivo'
          Items.Strings = (
            'TXT ITENS')
          TabOrder = 1
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 183
        end
      end
    end
  end
  object FDQConfiguracao: TFDQuery
    Connection = DmPrincipal.FDC_Freeboard
    SQL.Strings = (
      'select * from configuracao')
    Left = 392
    Top = 184
  end
end
