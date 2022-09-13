object dm: Tdm
  OldCreateOrder = False
  Height = 360
  Width = 592
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://sandbox.meuspedidos.com.br'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 47
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'ApplicationToken'
      end
      item
        Kind = pkHTTPHEADER
        Name = 'CompanyToken'
      end
      item
        Name = 'Content-Type'
        Value = 'application/json'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 47
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    Left = 47
    Top = 127
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = '23921923-fafa-4496-9961-e491631a7ea9'
    AccessTokenParamName = 'token'
    Left = 47
    Top = 184
  end
  object RESTClientes: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://homolog.mytapp.com.br/api/v1/getAllCustomers'
    Params = <>
    Left = 368
    Top = 16
  end
  object RequestClientes: TRESTRequest
    Client = RESTClientes
    Params = <>
    Response = ResponseClientes
    SynchronizedEvents = False
    Left = 368
    Top = 72
  end
  object ResponseClientes: TRESTResponse
    ContentType = 'application/json'
    Left = 368
    Top = 127
  end
  object RESTApiAlsti: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://sandbox.meuspedidos.com.br'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 255
    Top = 16
  end
  object RequestApiAlsti: TRESTRequest
    Client = RESTApiAlsti
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'ApplicationToken'
      end
      item
        Kind = pkHTTPHEADER
        Name = 'CompanyToken'
      end>
    Response = ResponseApiAlsti
    SynchronizedEvents = False
    Left = 255
    Top = 72
  end
  object ResponseApiAlsti: TRESTResponse
    Left = 255
    Top = 127
  end
  object RESTApiMyTapp: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://sandbox.meuspedidos.com.br'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 151
    Top = 16
  end
  object RequestApiMyTapp: TRESTRequest
    Client = RESTApiMyTapp
    Method = rmPOST
    Params = <>
    Response = ResponseApiMyTapp
    Timeout = 0
    SynchronizedEvents = False
    Left = 151
    Top = 72
  end
  object ResponseApiMyTapp: TRESTResponse
    Left = 151
    Top = 127
  end
end
