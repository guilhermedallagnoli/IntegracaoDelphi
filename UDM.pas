unit UDM;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter;

type
  TApiResultEnvioJson = record
    Codigo: integer;
    TextoRetorno, MeusPedidosID: string;
    QuantidadeRequisicoes: integer;
    TempoEspera: integer;
    Retorno: TJSONValue;
  end;

type
  Tdm = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    RESTClientes: TRESTClient;
    RequestClientes: TRESTRequest;
    ResponseClientes: TRESTResponse;
    RESTApiAlsti: TRESTClient;
    RequestApiAlsti: TRESTRequest;
    ResponseApiAlsti: TRESTResponse;
    RESTApiMyTapp: TRESTClient;
    RequestApiMyTapp: TRESTRequest;
    ResponseApiMyTapp: TRESTResponse;
  private
    { Private declarations }
  public
    // GET
    function Get(BaseUrl, PortaServico, Endpoint: string): TApiResultEnvioJson;
    function GetWithFilter(BaseUrl, PortaServico, Endpoint, Filtro: string)
      : TApiResultEnvioJson;
    // POST
    function Post(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
      : TApiResultEnvioJson;
    function PostAlstiApi(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
      : TApiResultEnvioJson;
    // UPDATE
    function Put(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
      : TApiResultEnvioJson;
    function Patch(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
      : TApiResultEnvioJson;
    // DELETE
    function Delete(BaseUrl, PortaServico, Endpoint: string)
      : TApiResultEnvioJson;
  end;

var
  dm: Tdm;

implementation

uses RESTRequest4D;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

function Tdm.Get(BaseUrl, PortaServico, Endpoint: string): TApiResultEnvioJson;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTRequest1.Response.StatusCode = 404 then
  begin
    Result.Codigo := 404;
    Exit;
  end;

  if RESTRequest1.Response.JSONValue = nil then
  begin
    Exit;
  end;

  Result.Retorno := RESTRequest1.Response.JSONValue;
  Result.Codigo := RESTResponse1.StatusCode;
  Result.TextoRetorno := RESTResponse1.Content;
  Result.TempoEspera := 0;
end;

function Tdm.GetWithFilter(BaseUrl, PortaServico, Endpoint, Filtro: string)
  : TApiResultEnvioJson;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico + Filtro;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTRequest1.Response.StatusCode = 404 then
  begin
    Result.Codigo := 404;
    Exit;
  end;

  if RESTRequest1.Response.JSONValue = nil then
  begin
    Exit;
  end;

  Result.Retorno := RESTRequest1.Response.JSONValue;
  Result.Codigo := RESTResponse1.StatusCode;
  Result.TextoRetorno := RESTResponse1.Content;
  Result.TempoEspera := 0;
end;

function Tdm.Delete(BaseUrl, PortaServico, Endpoint: string)
  : TApiResultEnvioJson;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmDELETE;
  RESTRequest1.Execute;
end;

function Tdm.Post(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
  : TApiResultEnvioJson;
var
  oRetorno: TJSONObject;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmPOST;

  RESTRequest1.AddBody(AJsonEnviar, ctAPPLICATION_JSON);
  RESTRequest1.Execute;

  Result.Codigo := RESTResponse1.StatusCode;
  Result.TextoRetorno := RESTResponse1.Content;
  Result.TempoEspera := 0;
end;

function Tdm.PostAlstiApi(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
  : TApiResultEnvioJson;
var
  oRetorno: TJSONObject;
begin
  RESTApiAlsti.BaseUrl := BaseUrl + PortaServico;
  RequestApiAlsti.Params.Clear;
  RequestApiAlsti.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RequestApiAlsti.resource := Endpoint;
  RequestApiAlsti.Method := rmPOST;

  RequestApiAlsti.AddBody(AJsonEnviar, ctAPPLICATION_JSON);
  RequestApiAlsti.Execute;

  Result.Codigo := ResponseApiAlsti.StatusCode;
  Result.TextoRetorno := ResponseApiAlsti.Content;
  Result.TempoEspera := 0;
end;

function Tdm.Put(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
  : TApiResultEnvioJson;
var
  oRetorno: TJSONObject;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmPUT;

  RESTRequest1.AddBody(AJsonEnviar, ctAPPLICATION_JSON);
  RESTRequest1.Execute;
  Result.Codigo := RESTResponse1.StatusCode;
  Result.TextoRetorno := RESTResponse1.Content;

  Result.TempoEspera := 0;
end;

function Tdm.Patch(BaseUrl, PortaServico, Endpoint, AJsonEnviar: String)
  : TApiResultEnvioJson;
var
  oRetorno: TJSONObject;
begin
  OAuth2Authenticator1.AccessToken := '23921923-fafa-4496-9961-e491631a7ea9';
  OAuth2Authenticator1.AccessTokenParamName := 'token';
  RESTClient1.BaseUrl := BaseUrl + PortaServico;
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('x-paginate', 'true', pkHTTPHEADER);
  RESTRequest1.resource := Endpoint;
  RESTRequest1.Method := rmPATCH;

  RESTRequest1.AddBody(AJsonEnviar, ctAPPLICATION_JSON);
  RESTRequest1.Execute;
  Result.Codigo := RESTResponse1.StatusCode;
  Result.TextoRetorno := RESTResponse1.Content;

  Result.TempoEspera := 0;
end;

end.
