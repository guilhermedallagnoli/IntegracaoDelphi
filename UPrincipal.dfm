object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Integrador myTapp'
  ClientHeight = 418
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LeftBar: TPanel
    Left = 0
    Top = 41
    Width = 425
    Height = 345
    Align = alClient
    Caption = 'LeftBar'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 528
    object SpeedButtonExpProdutos: TSpeedButton
      Left = 1
      Top = 51
      Width = 423
      Height = 52
      Align = alTop
      Caption = 'Exportar Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000000000000030000000D000000150000000E000000030000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000200000013030B1E68275BA6FF030B1F6C000000150000
        0003000000000000000000000000000000000000000000000000000000000000
        00000000000200000011040C1F663D7DBEFF6ACCFFFF3D7EBFFF040C1F6C0000
        0014000000030000000000000000000000000000000000000000000000000000
        00020000000F040C1D5D427EBDFF66CAFFFF53C3FFFF63C8FFFF4282C0FF060D
        206F100A08572214119C241611A50C0706390000000000000000000000020000
        000D050D1E594984BFFF70CFFFFF5CC6FFFF5BC6FFFF5AC5FFFF6BCDFFFF4986
        C2FF0A102176010100160C0706352C1B17C10D0806390000000000000007060D
        1C4E4E87BFFF7CD5FFFF65CBFFFF63CAFFFF62CBFFFF62CBFFFF62C9FFFF74D1
        FFFF4F8AC4FF060E226600000011100A08432F1E17BD000000000000000A3670
        B3FFB0E9FFFF6CCFFFFF6CCFFFFF6BCEFFFF6BCDFFFF6ACFFFFF6ACCFFFF68CE
        FFFF7CD5FFFF548CC4FF0C1E3B890302021B402920F300000000000000060E1C
        2C5282B2DAFFA4E5FFFF74D4FFFF74D4FFFF72D3FFFF71D1FFFF72D2FFFF70D2
        FFFF70D1FFFF82D5FCFF3E70A8FF0A132567462D25F300000000000000010000
        00080E1D2D5285B4DBFFAAE7FFFF79D6FFFF79D6FFFF78D5FFFF77D7FFFF94E0
        FFFFAEE9FFFF83CAEEFF72ABD3FF3C5F8EFF39271FBE00000000000000000000
        0001000000070F1E2D4F88B6DCFFB0E9FFFF80D9FFFF7FDAFFFF7EDAFFFF6EA6
        D3FF3169ABFF4F7FAFFF89B0C1FF584E53FF130D0B4500000000000000000000
        00000000000100000007101E2E4D8BB8DDFFB4EBFFFF86DDFFFF86DCFFFF3269
        A9FF000000245D453DFF766C68FF5E7EA5FF0000000D00000000000000000000
        0000000000000000000100000006101F2E4C8EBBDEFFBAEDFFFF8DE1FFFF599C
        CDFF295D9FFF7EB3D8FFD5F5FFFF6193C7FF0000000A00000000000000000000
        00000000000000000000000000010000000511202F4990BDDFFFDEF8FFFFDDF8
        FFFFDDF7FFFFDDF7FFFF769AC6FF040F224E0000000500000000000000000000
        0000000000000000000000000000000000000000000411212F474787C1FF4785
        C1FF4686C1FF4684C1FF0510234B000000060000000100000000000000000000
        0000000000000000000000000000000000000000000000000002000000040000
        0005000000050000000500000003000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      OnClick = SpeedButtonExpProdutosClick
      ExplicitTop = 45
      ExplicitWidth = 475
    end
    object SpeedButtonImpConsumos: TSpeedButton
      Left = 1
      Top = 103
      Width = 423
      Height = 50
      Align = alTop
      Caption = 'Importar Consumos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00030000000C0000001300000014000000150000001500000016000000160000
        001700000017000000170000000F000000040000000000000000000000000000
        000B1F467BC32B61AAFF2B60A9FF2A5EA9FF295EA8FF285DA7FF275CA7FF275A
        A6FF265AA5FF2558A5FF1A3E75C70000000F0000000000000000000000000000
        000F3067AEFF87CBF1FF60B9EDFF60B8ECFF5EB8ECFF5DB7EBFF5CB6ECFF5AB6
        EBFF5AB5EAFF59B4EBFF275BA7FF000000160000000000000000000000000000
        000F336BB1FF90D1F3FF337ABDFF3179BDFF3176BCFF3074BBFF3072BAFF2E70
        B9FF2D6FB8FF5CB7ECFF2A5FA9FF000000160000000000000000000000000000
        000E3770B3FF98D5F4FF367EC0FFFBF6F2FFF6EEE6FFF6EEE6FFF6EDE5FFF6ED
        E4FF2F73BAFF61BAECFF2D63ABFF000000140000000000000000000000000000
        000D3A75B6FFA1D9F5FF3882C2FFFBF8F4FFF7EFE8FFF6EFE6FFF6EEE6FFF5EE
        E5FF3278BDFF66BDEEFF3067AEFF000000130000000000000000000000000000
        000C3E7AB9FFA9DEF7FF3A87C5FFFCFAF7FFF7F0E9FFF7F0E8FFF7EFE7FFF6EF
        E7FF347CBFFF6AC1EFFF336CB1FF000000120000000000000000000000000000
        000A417FBCFFB1E2F7FF3D8CC8FFFDFBF9FFF7F2EAFFF8F1E9FFF6EFE8FFF4ED
        E5FF377FC0FF6FC4EDFF3771B3FF000000110000000000000000000000000000
        00094584BFFFB9E6F9FF3F8FCBFFFDFCFBFFF8F3ECFFF6EFE8FFF2EBE4FFF1EA
        E2FF3981BDFF74C4ECFF3B75B5FF000000100000000000000000000000000000
        0008498AC2FFBFE9FAFF4194CCFFFDFCFBFFF1EAE5FFE9E3DCFFE9E1DAFFE7DF
        D9FF3C81B8FF77C4E7FF3E7AB6FF0000000E0000000000000000000000000000
        00074C8EC6FFC5ECFBFF5BA6D3FFE8E6E4FFCBC7C0FFBDB7B2FFBBB4B0FFC5BE
        B9FF4E87AEFF7ABFDCFF427DB6FF0000000D0000000000000000000000000000
        00065093C9FFD6F3FCFF6EA4C2FFA1877DFF82594AFF754737FF7A5142FF8D72
        68FF577D96FF89B8CAFF4581BAFF0000000C0000000000000000000000000000
        00055298CCFFE0F6FDFF998178FFC0A396FFE3D3C9FFE8D5C4FFD6BEAFFFB395
        88FF755D56FFB8CCD4FF4888C0FF0000000A0000000000000000000000000000
        0003407499C082BBDEFFA88577FFA88071FFA57D6DFFF0E5DBFF8D6556FF9D73
        64FF997263FF78AED4FF396A92C3000000060000000000000000000000000000
        00010000000300000004000000050000000559453D87AA8373FF4B372F870000
        0007000000070000000700000005000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      OnClick = SpeedButtonImpConsumosClick
      ExplicitTop = 109
      ExplicitWidth = 475
    end
    object SpeedButtonImpCli: TSpeedButton
      Left = 1
      Top = 1
      Width = 423
      Height = 50
      Align = alTop
      Caption = 'Importar Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000100000004000000070000000A0000000B0000000D0000000D0000
        000D0000000C0000000A00000007000000020000000000000000000000000000
        0000000000040E38297E134F37B414593DD212583BDB126441FF105D3DFF0D49
        2FDC0A432AD4063521B804251689000000080000000000000000000000000000
        000000000006278A63FF4EBB98FF3CBB90FF2FB586FF2FBF8DFF2DBD8BFF27AE
        7DFF24A878FF209A6CFF0D5535FF0000000C0000000000000000000000000000
        000000000004267B5BD557C09FFF6CDBBCFF65DAB7FF45CBA0FF39C697FF37C4
        95FF3AC396FF36A47EFF0F5136DA000000090000000000000000010101090101
        010E0101011106120E301D5E45A7349875F868CEB1FF6AD1B4FF4BC59EFF42BD
        95FF237F5EFA114732AA040E0A3801010115010101100101010A194737942266
        4ED1286A54D9548F7AF471A392FF679988F93A8870FC40768EFF386E87FF327B
        63FB679988F770A391FF4D8A74F7205E47DB14523BD30D3627983A9275FD6EC6
        ABFF52B795FF46B08DFF47AF8CFF79B5A1FF487591FF7DA4CDFF588BC1FF315F
        81FF7EBAA6FF47AF8CFF3AA17EFF359875FF379878FF1A6B4EFD2F725CBE5EB5
        9AFF84D4BDFF65CBABFF80CFB5FF86BFADFF567EB0FFBDE0F5FF8BC2EBFF345E
        97FF84BAADFF79CBB1FF55BC9BFF5DB89CFF399173FF195540C1010101091838
        2D6339836BD687D0BBFFAEDDD0FF416992FF5C80B0FFCAE8F6FF94C6E9FF375D
        95FF4A6C8BFFACDACDFF78C7AFFF2D745ED7112E25670101010D000000010101
        01060A0C0C2B44708BF67D96B8FF255696FF4F7CB1FF517CAFFF2C5088FF325D
        98FF1E3F79FF7C95B5FF33617CF60A0B0B2E0101010700000001000000000303
        0308273242707097C3FFA7D2F4FF326BAEFF6C9ED1FF5C8CC1FF76A5D3FF5385
        BEFF214784FFA5CEF0FF4676B0FF1822336E0303030A00000000000000000404
        040C354F75C994B8D8FFB4DAF7FF79A2CEFF427BB8F63878BAF13174BBFC3C6D
        A6F885A2C3FFB6DAF6FF5C8FC5FF223A60C20505051100000000000000000404
        040D28528BFA85A7CAFF5D88B5FF7291B8FF6A83A8FC6262636F606060697890
        B5FCA7BFD7FF618BB7FF3A679EFF1F467CFB0606071600000000000000000202
        02072B5996F54778B2FE6197D0FF4E87C6FF275490FF06080B1A020202072B59
        96F54778B2FE6197D0FF4E87C6FF275490FF06080B1A00000000000000000101
        010213263E612C5A93D6326AABF729578DD81529447301010103010101021326
        3E612C5A93D6326AABF729578DD8152944730101010300000000000000000000
        0000000000000000000100000001000000010000000100000000000000000000
        0000000000010000000100000001000000010000000000000000}
      ParentFont = False
      OnClick = SpeedButtonImpCliClick
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 857
    end
    object PanelCFG: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 266
      Width = 417
      Height = 75
      Align = alBottom
      TabOrder = 0
      Visible = False
      ExplicitTop = 358
      ExplicitWidth = 803
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 415
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'Definir Limite de Tempo (Informe o Tempo em Segundos)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 333
      end
      object SpeedButtonSave: TSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 47
        Width = 415
        Height = 26
        Margins.Left = 0
        Margins.Right = 0
        Align = alTop
        Caption = 'Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonSaveClick
        ExplicitWidth = 454
      end
      object EditTime: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 20
        Width = 409
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = '0'
        ExplicitTop = 18
        ExplicitWidth = 795
      end
    end
  end
  object Footer: TPanel
    Left = 0
    Top = 386
    Width = 425
    Height = 32
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 478
    ExplicitWidth = 811
    object SpeedButtonCFG: TSpeedButton
      Left = 113
      Top = 1
      Width = 112
      Height = 30
      Align = alLeft
      Caption = 'Configurador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000900000012000000120000
        0009000000020000000000000000000000000000000000000000000000000000
        0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
        0F700000000C0000000B0000000C000000050000000100000000000000000000
        00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
        23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
        00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
        37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
        00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
        9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
        0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
        D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
        1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
        B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
        60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
        67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
        64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
        5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
        245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
        C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
        000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
        E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
        0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
        D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
        0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
        6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
        00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
        4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
        0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
        295F000000030000000300000003000000010000000000000000000000000000
        0000000000000000000000000000000000000000000100000002000000030000
        0001000000000000000000000000000000000000000000000000}
      ParentFont = False
      OnClick = SpeedButtonCFGClick
      ExplicitLeft = 97
    end
    object SpeedButtonOnOff: TSpeedButton
      Left = 1
      Top = 1
      Width = 112
      Height = 30
      Align = alLeft
      Caption = 'Desligado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000002000000090000000E0000000F0000000F00000010000000100000
        0010000000100000000F0000000A000000020000000000000000000000000000
        0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
        4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
        000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
        9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
        00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
        7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
        000000000000000000010000000200000002000000030B20176D0A1B136F0000
        0004000000030000000200000002000000000000000000000000000000000000
        000000000000000000000000000000000003040C092E21664AF41C583FF6030A
        072F000000030000000000000000000000000000000000000000000000000000
        00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
        2BCD0001010D0000000100000000000000000000000000000000000000000000
        000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
        6AFF0E291D8B0000000600000001000000000000000000000000000000000000
        00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
        9DFF256F53FD07140E4700000003000000000000000000000000000000000000
        00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
        A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
        0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
        BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
        0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
        DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
        000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
        E6FF3B9878FF0000000900000004000000010000000000000000000000000000
        000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
        F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
        0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
        8EFF2E8166B90000000200000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000200000002000000020000
        0002000000020000000000000000000000000000000000000000}
      ParentFont = False
      OnClick = SpeedButtonOnOffClick
    end
  end
  object Header: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 811
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 13
      Width = 417
      Height = 24
      Margins.Top = 12
      Align = alClient
      Alignment = taCenter
      Caption = 'Alsti - Integra'#231#227'o myTapp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 164
      ExplicitHeight = 16
    end
  end
  object Timer: TTimer
    Interval = 0
    OnTimer = TimerTimer
    Left = 344
    Top = 241
  end
end
