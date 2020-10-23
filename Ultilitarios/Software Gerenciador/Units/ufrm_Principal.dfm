object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 495
  ClientWidth = 867
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
    Width = 867
    Height = 495
    Align = alClient
    Caption = 'pnPrincipal'
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 296
    ExplicitTop = 280
    ExplicitWidth = 185
    ExplicitHeight = 41
    object ToolBar: TPanel
      Left = 1
      Top = 1
      Width = 865
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 867
      object lblTituloDaTela: TLabel
        Left = 0
        Top = 0
        Width = 783
        Height = 41
        Align = alClient
        Alignment = taCenter
        BiDiMode = bdRightToLeftNoAlign
        Caption = 'Propaganda Visual Pro99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 178
        ExplicitHeight = 19
      end
      object Button1: TButton
        Left = 783
        Top = 0
        Width = 82
        Height = 41
        Align = alRight
        Caption = 'Configura'#231#227'o'
        TabOrder = 0
        OnClick = Button1Click
        ExplicitLeft = 784
        ExplicitTop = 1
        ExplicitHeight = 39
      end
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 94
      Width = 385
      Height = 371
      DataSource = DS_ListaProduto
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Button2: TButton
      Left = 399
      Top = 119
      Width = 113
      Height = 25
      Caption = 'Carrega Protudos'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Panel1: TPanel
      Left = 1
      Top = 42
      Width = 865
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object lblVerificandoArqui: TLabel
        Left = 97
        Top = 0
        Width = 768
        Height = 31
        Align = alClient
        Caption = 'Verificando o arquivo de carga em ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 103
        ExplicitTop = 6
      end
      object Button3: TButton
        Left = 0
        Top = 0
        Width = 97
        Height = 31
        Align = alLeft
        Caption = 'Carrega Arquivo'
        TabOrder = 0
      end
    end
  end
  object DS_ListaProduto: TDataSource
    DataSet = dmProduto.FDQProdutos
    Left = 56
    Top = 416
  end
  object tmCarregaArquivo: TTimer
    Interval = 10000
    Left = 793
    Top = 58
  end
end
