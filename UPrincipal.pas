unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  TypeEdit, IniFiles, System.JSON, Vcl.ComCtrls, rest.types,
  System.Net.HttpClient, IdHTTP;

type
  TFrmPrincipal = class(TForm)
    Footer: TPanel;
    SpeedButtonImpCli: TSpeedButton;
    SpeedButtonExpProdutos: TSpeedButton;
    SpeedButtonImpConsumos: TSpeedButton;
    SpeedButtonCFG: TSpeedButton;
    LeftBar: TPanel;
    Header: TPanel;
    Label1: TLabel;
    SpeedButtonOnOff: TSpeedButton;
    Timer: TTimer;
    PanelCFG: TPanel;
    Label2: TLabel;
    EditTime: TEdit;
    SpeedButtonSave: TSpeedButton;
    procedure SpeedButtonOnOffClick(Sender: TObject);
    procedure SpeedButtonCFGClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure SpeedButtonImpCliClick(Sender: TObject);
    procedure SpeedButtonExpProdutosClick(Sender: TObject);
    procedure SpeedButtonImpConsumosClick(Sender: TObject);
  private
    { Private declarations }
  public
    urlBaseMytapp, tokenMytapp, urlBaseAlsti, portAlsti: string;
  end;

var
  FrmPrincipal: TFrmPrincipal;
  on_off: integer = 0;
  cont: integer = 0;

implementation

uses UDM, RESTRequest4D;

{$R *.dfm}

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  ArquivoINI: TIniFile;
  n: double;
begin
  // Informações do INI
  Timer.Enabled := False;
  Timer.Interval := 0;
  if FileExists(ExtractFilePath(ParamStr(0)) + 'FDConnectionDefs.INI') then
  begin
    ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) +
      'FDConnectionDefs.INI');

    // Temporizador
    Timer.Interval := ArquivoINI.ReadString('ApoioLogico', 'Temporizador',
      'Erro').ToInteger;
    n := ArquivoINI.ReadString('ApoioLogico', 'Temporizador', 'Erro').ToInteger;
    n := n / 1000;
    EditTime.Text := n.ToString;

    // Parâmetros de conexão "API - Mytapp"
    urlBaseMytapp := ArquivoINI.ReadString('Mytapp', 'Url', 'Erro');
    tokenMytapp := ArquivoINI.ReadString('Mytapp', 'Token', 'Erro');

    // Parâmetros de conexão "API - Mytapp"
    urlBaseAlsti := ArquivoINI.ReadString('Alsti', 'Url', 'Erro');
    portAlsti := ArquivoINI.ReadString('Alsti', 'Porta', 'Erro');
  end;
end;

procedure TFrmPrincipal.SpeedButtonCFGClick(Sender: TObject);
begin
  // Exibir e ocultar menu de configuração
  if PanelCFG.Visible = False then
  begin
    PanelCFG.Visible := True;
  end
  else
  begin
    PanelCFG.Visible := False;
  end;
end;

procedure TFrmPrincipal.SpeedButtonExpProdutosClick(Sender: TObject);
var
  xRequestBody: TStringList;
  objHTTP: TIdHTTP;
  LResponse: IResponse;
  LJSONValue, jsValue, JSonValue: TJSONValue;
  jsonRaiz, jsonObject: TJSONObject;
  LJSONArray, jsArray: TJSONArray;
  i: integer;
  jsonRegistros, jsonCategoria, response: string;
  retornoApiAlsti, descricao, preco, sku, visivel, cervejaria, tipo, estilo,
    origem, teor, ibu, categoria, codCat, infoCat, retorno, id, idProdutoMytapp,
    referencia: string;
begin

  { ==================================================
    Procedure realizada para a exportação de produtos!
    ================================================== }

  try
    // Busca produtos cadastrados na base do cliente
    LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
      '/v1/produtos').Accept('application/json').Get;
    retornoApiAlsti := LResponse.Content;

    // Validação para conferir existencia de produtos
    if retornoApiAlsti <> 'Produto não encontrado ou não existe' then
    begin
      // Pegar retorno do produto caso ele exista
      LJSONArray := TJSONObject.ParseJSONValue(retornoApiAlsti) as TJSONArray;
      try
        for LJSONValue in LJSONArray do
        begin
          // Dados cadastrados
          descricao := LJSONValue.GetValue<string>('descricao');
          referencia := LJSONValue.GetValue<string>('referencia');
          preco := LJSONValue.GetValue<string>('preco1');
          sku := LJSONValue.GetValue<string>('codigo');
          tipo := LJSONValue.GetValue<string>('tipoProdutoMytapp');
          if tipo = '0' then
            tipo := 'product';
          if tipo = '1' then
            tipo := 'beer';
          visivel := LJSONValue.GetValue<string>('situacao');
          if visivel = 'S' then
            visivel := 'True';
          if visivel = 'N' then
            visivel := 'False';
          codCat := LJSONValue.GetValue<string>('grupo');
          categoria := LJSONValue.GetValue<string>('descricao1');
          cervejaria := LJSONValue.GetValue<string>('cervejariaMytapp');
          estilo := LJSONValue.GetValue<string>('estiloMytapp');
          origem := LJSONValue.GetValue<string>('origemMytapp');
          teor := LJSONValue.GetValue<string>('teorAlcoolicoMytapp');
          ibu := LJSONValue.GetValue<string>('ibuMytapp');

          // Valida a existência da categoria utilizada pelo produto na mytapp
          LResponse := TRequest.New.BaseURL
            (urlBaseMytapp + '/api/v1/getProductByCategoryId')
            .AddHeader('token', tokenMytapp).AddHeader('category_id', codCat)
            .Accept('application/json').Get;

          jsArray := TJSONObject.ParseJSONValue('[' + LResponse.Content + ']')
            as TJSONArray;
          begin
            for jsValue in jsArray do
            begin
              jsonObject := jsArray.Items[i] as TJSONObject;
              infoCat := jsonObject.GetValue<string>('info');

              // Caso não exista, ele cria
              if infoCat = 'Faltando dados sobre a categoria' then
              begin
                // Informações para cadastro de categoria
                jsonCategoria := '{"name": "' + categoria + '",' +
                  '"category_id":' + codCat + '}';

                // Inserir categoria
                TRequest.New.BaseURL(urlBaseMytapp + '/api/v1/createCategory')
                  .AddHeader('token', tokenMytapp)
                  .ContentType('application/json').AddBody(jsonCategoria).Post;
              end;
            end;
          end;

          // Exportar registros de produtos da base do cliente para a base da mytapp
          objHTTP := TIdHTTP.Create;

          with objHTTP.Request do
          begin
            Clear;
            ContentType := 'application/x-www-form-urlencoded';
            CustomHeaders.AddValue('token',
              '23921923-fafa-4496-9961-e491631a7ea9');
          end;

          xRequestBody := TStringList.Create;
          try
            xRequestBody.Add('name=' + descricao);
            xRequestBody.Add('price=' + preco);
            xRequestBody.Add('description=' + descricao);
            xRequestBody.Add('sku=' + sku);
            xRequestBody.Add('type=' + tipo);
            xRequestBody.Add('visible=' + visivel);
            xRequestBody.Add('category=' + '[{"category_id":' + codCat +
              ', "name":"' + categoria + '"}]');
            if cervejaria <> '' then
              xRequestBody.Add('brewery=' + cervejaria);
            if estilo <> '' then
              xRequestBody.Add('style=' + estilo);
            if origem <> '' then
              xRequestBody.Add('origin=' + origem);
            if teor <> '' then
              xRequestBody.Add('alcohol=' + teor);
            if ibu <> '' then
              xRequestBody.Add('ibu=' + ibu);

            // Grava registo no mytapp
            response :=
              objHTTP.Post
              ('https://homolog.mytapp.com.br/api/v1/newItemProduct',
              xRequestBody);

            // Valida se é produto ou cerveja
            JSonValue := TJSONObject.ParseJSONValue(response);
            if tipo = 'product' then
            begin
              // Caso seja produto => product_sales_id
              idProdutoMytapp := JSonValue.GetValue<string>
                ('item.product_sales_id');
              JSonValue.Free;
            end
            else if tipo = 'beer' then
            begin
              // Caso seja cerveja => product_id
              idProdutoMytapp := JSonValue.GetValue<string>('item.product_id');
              JSonValue.Free;
            end;

            // Atualiza idProdutoMytapp na base
            LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
              '/v1/mytapp').ContentType('application/json')
              .AddBody('{"codigo": "' + sku + '","idProdutoMytapp": "' +
              idProdutoMytapp + '"}').Put;
          finally
            xRequestBody.Free;
          end;
        end;
      finally
        LJSONArray.Free;
      end;

      // Valida se os mesmos registros existem nas duas bases
      LResponse := TRequest.New.BaseURL
        (urlBaseMytapp + '/v1/getAllProductAndBeers')
        .AddHeader('token', tokenMytapp).Accept('application/json').Get;
      retorno := LResponse.Content;

      jsonRaiz := TJSONObject.ParseJSONValue(retorno) as TJSONObject;
      if (jsonRaiz <> nil) then
      begin
        jsArray := jsonRaiz.GetValue<TJSONArray>('data') as TJSONArray;
        for i := 0 to jsArray.Count - 1 do
        begin
          jsonObject := jsArray.Items[i] as TJSONObject;
          id := jsonObject.GetValue<string>('person_id');

          // Valida a existência do registro da mytapp na base do cliente
          LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
            '/v1/produtos/' + id).Get;

          // Desabilita o produto na mytapp caso não seja encontrado na base do cliente
          if LResponse.Content = 'Produto não encontrado ou não existe' then
          begin
            // Json a ser enviado
            jsonRegistros := '{"product_sales_id" =' + id +
              ', "visible" = False}';

            // Request para desabilitar
            LResponse := TRequest.New.BaseURL
              (urlBaseMytapp + '/api/v1/deleteProduct')
              .AddHeader('token', tokenMytapp).ContentType('application/json')
              .AddBody(jsonRegistros).Post;
          end;
        end;
      end;
      if Timer.Enabled = False then
        ShowMessage('Produtos exportados com sucesso!');
    end
  except
    on E: Exception do
      if Timer.Enabled = False then
      begin
        ShowMessage('Erro:' + E.Message);
      end
      else
      begin
        exit;
      end;
  end;
end;

procedure TFrmPrincipal.SpeedButtonImpCliClick(Sender: TObject);
var
  LResponse: IResponse;
  jsonRaiz, jsonObject: TJSONObject;
  LJSONValue: TJSONValue;
  LJSONArray, jsArray: TJSONArray;
  i, n: integer;
  retorno, jsonEnvio, id, nome, sobrenome, liberado, telefone, email, genero,
    nascimento, cpf, estrangeiro, sincronizacaoData, sincronizadoAtualizado,
    sincronizado, numeroCartao, convData, jsonSync, jsonMytapp: string;
begin

  { ==================================================
    Procedure realizada para a importação de clientes!
    ================================================== }

  try
    // Buscar todos os clientes cadastrados na mytapp
    LResponse := TRequest.New.BaseURL(urlBaseMytapp + '/api/v1/getAllCustomers')
      .AddHeader('token', tokenMytapp).Accept('application/json').Get;
    retorno := LResponse.Content;

    // Pegar valores de retorno
    jsonRaiz := TJSONObject.ParseJSONValue(retorno) as TJSONObject;
    if (jsonRaiz <> nil) then
    begin
      jsArray := jsonRaiz.GetValue<TJSONArray>('data') as TJSONArray;
      for i := 0 to jsArray.Count - 1 do
      begin
        jsonObject := jsArray.Items[i] as TJSONObject;

        // Dados contidos no retorno
        id := jsonObject.GetValue<string>('person_id');
        nome := jsonObject.GetValue<string>('name');
        sobrenome := jsonObject.GetValue<string>('surname');
        telefone := jsonObject.GetValue<string>('phone');
        email := jsonObject.GetValue<string>('email');
        genero := jsonObject.GetValue<string>('gender');
        nascimento := jsonObject.GetValue<string>('birthdate');
        cpf := jsonObject.GetValue<string>('document');
        estrangeiro := jsonObject.GetValue<string>('is_foreign');
        sincronizacaoData := jsonObject.GetValue<string>('date_sync');
        sincronizadoAtualizado := jsonObject.GetValue<string>('sync_update');
        sincronizado := jsonObject.GetValue<string>('sync');
        numeroCartao := jsonObject.GetValue('visits.device_id').Value;

        // Tratar data para o formato adequado (yyyy/mm/aa)
        n := Length(nascimento);
        if n > 10 then
          delete(nascimento, 11, 19);
        if nascimento = '' then
          nascimento := '01/01/2022';
        convData := FormatDateTime('yyyy/mm/dd', StrToDate(nascimento));

        // Validação para pegar somente os não sincronizados
        if (sincronizado = '') or (sincronizado.ToInteger <> 1) then
        begin
          // Monta o json para o envio
          jsonEnvio := '{"codigo":' + id + ',' + '"nome": "' + nome + ' ' +
            sobrenome + '",' + '"nomeFantasia": "' + nome + ' ' + sobrenome +
            '",' + '"endereco": "string",' + '"enderecoNumero": "string",' +
            '"uf": 42,' + '"codigoCidade": 4213203,' + '"bairro": "teste",' +
            '"cpf": "' + cpf + '",' + '"celular": "' + telefone + '",' +
            '"ufCobranca": 42,' + '"codigoCidadeCobranca": 4213203,' +
            '"email": "' + email + '",' + '"codigoPais": 1058,' + '"ativo": 1,'
            + '"dataNascimento": "' + convData + '",' + '"deviceIdMyTapp": "' +
            numeroCartao + '"}';

          // Busca se o parceiro já se encontra cadastrado
          LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
            '/v1/parceiros/' + id).Accept('application/json').Get;

          if LResponse.Content = 'Parceiro não encontrado ou não existe' then
          begin
            // Caso não esteja cadastrado, ele manda post
            LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
              '/v1/parceiros').ContentType('application/json')
              .AddBody(jsonEnvio).Post;
          end
          else if True then
          begin
            // Caso esteja cadastrado, ele manda update
            LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
              '/v1/parceiros').ContentType('application/json')
              .AddBody(jsonEnvio).Put;
          end;

          // Retornar sincronizado para 1 na mytapp
          jsonSync := '{"person_id":"' + id + '"}';

          TRequest.New.BaseURL(urlBaseMytapp + '/api/v1/setCustomerSync')
            .AddHeader('token', tokenMytapp).ContentType('application/json')
            .AddBody(jsonSync).Post;
        end;
      end;

      if Timer.Enabled = False then
        ShowMessage('Lista atualizada com sucesso!');
    end;
  except
    on E: Exception do
      if Timer.Enabled = False then
      begin
        ShowMessage('Erro:' + E.Message);
      end
      else
      begin
        exit;
      end;
  end;

end;

procedure TFrmPrincipal.SpeedButtonImpConsumosClick(Sender: TObject);
var
  LResponse: IResponse;
  retorno, contaClienteRetorno, info, success: string;
  LJSONValue, JSonValue, valor: TJSONValue;
  jsonRaiz, jsonObject, objeto: TJSONObject;
  LJSONArray, jsArray: TJSONArray;
  jsonObj, jSubObj: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
  par: TJSONPair;
  i, j, n, nItem, counter: integer;
  som: double;
  cpf, name, foreign, rfid, dataHoraAtual, JsonAbrirCC, dataAbertura,
    vlrTotalConsumido, idCliente, codCli, dadosMytapp, ml, price, total,
    discount, sku, barId, saleDate, consumptionStart, consumptionEnd,
    nameProduct, sync, salesId, jsonProdutos, jsonCervejas, retornoNome,
    jsonSyncProducts, saleDateFormated, consumptionStartFormated,
    consumptionEndFormated, idProduto, d, m, a, h, quantity, vlTotalArmazenado,
    jsonCC, situacao, idContaCliente: string;

begin

  { ==================================================
    Procedure realizada para a importação de consumos!
    ================================================== }

  try
    // Buscar todos os consumos não sincronizados
    LResponse := TRequest.New.BaseURL(urlBaseMytapp +
      '/api/v1/getAllConsumption').AddHeader('token', tokenMytapp)
      .Accept('application/json').Get;
    retorno := LResponse.Content;

    // Pegar retorno e validar existência de erro
    LJSONArray := TJSONObject.ParseJSONValue('[' + retorno + ']') as TJSONArray;
    try
      for LJSONValue in LJSONArray do
      begin
        try
          info := LJSONValue.GetValue<string>('info');
        except
          info := '0';
        end;

        try
          success := LJSONValue.GetValue<string>('success');
        except
          success := '0';
        end;
      end;
    finally
      LJSONArray.Free;
    end;

    // Caso todos os consumos já estejam sincronizados, ele não fará nada
    if (info = 'Todos os consumos sincronizados') or (info <> '0') then
    begin
      if Timer.Enabled = False then
      begin
        ShowMessage('Consumos importados com sucesso!');
      end;
      exit;
    end
    else
    begin
      // Pegar consumo não sincronizado
      jsonObject := TJSONObject.ParseJSONValue(retorno) as TJSONObject;
      try
        JSonValue := jsonObject.Get('data').JSonValue;
        retorno := JSonValue.ToString;
      finally
        jsonObject.Free;
      end;

      // Percorrer dados do json pelo cpf
      try
        while i < 100000 do
        begin
          // Pegar número de cpf da lista
          valor := TJSONObject.ParseJSONValue(retorno);
          objeto := valor as TJSONObject;
          par := objeto.Get(j);
          cpf := par.JsonString.Value;
          j := j + 1;

          try
            // Busca cpf (conta cliente) para validação
            LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
              '/v1/contaCliente?cpf=' + cpf).Accept('application/json').Get;
            contaClienteRetorno := LResponse.Content;

            // Converter string para json object
            JSonValue := TJSONObject.ParseJSONValue(retorno);

            // Valida se o cliente já possui alguma conta cliente cadastrada
            if (contaClienteRetorno <>
              'Conta Cliente não encontrado ou não existe') then
            begin
              // Caso tenha, irá pegar a data da abertura da conta
              LJSONArray := TJSONObject.ParseJSONValue(contaClienteRetorno)
                as TJSONArray;
              try
                for LJSONValue in LJSONArray do
                begin
                  dataAbertura :=
                    Copy(LJSONValue.GetValue<string>('dthrAbertura'), 1, 10);
                  situacao := LJSONValue.GetValue<string>('situacao');
                end;
              finally
                LJSONArray.Free;
              end;
            end
            else
            begin
              // Caso não tenha, irá passar como 0000-00-00
              dataAbertura := '0000-00-00'
            end;

            // Valida se existe consumo no dia em aberto para o cliente
            if (dataAbertura <> FormatDateTime('yyyy-mm-dd', Now)) or
              (situacao = 'F') then
            begin
              // Dados do cliente
              name := JSonValue.GetValue<string>(cpf + '.name');
              foreign := JSonValue.GetValue<string>(cpf + '.foreign');
              rfid := JSonValue.GetValue<string>(cpf + '.rfid');
              dataHoraAtual := FormatDateTime('yyyy/mm/dd hh:MM:ss', Now);
              vlrTotalConsumido := JSonValue.GetValue<string>
                (cpf + '.totalConsumed');

              // Pegar id cadastrado para o cliente
              LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
                '/v1/parceiros?cpf=' + cpf).Accept('application/json').Get;
              dadosMytapp := LResponse.Content;

              // Executa novamente a procedure de importar clientes caso não encontre
              if dadosMytapp = 'Parceiro não encontrado ou não existe' then
              begin
                SpeedButtonImpCli.Click;

                LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti
                  + '/v1/parceiros?cpf=' + cpf).Accept('application/json').Get;
                dadosMytapp := LResponse.Content;
              end;

              // Pegar o código cadastrado para o cliente
              LJSONArray := TJSONObject.ParseJSONValue(dadosMytapp)
                as TJSONArray;
              try
                for LJSONValue in LJSONArray do
                begin
                  idCliente := LJSONValue.GetValue<string>('codigo');
                end;
              finally
                LJSONArray.Free;
              end;

              // Monta o json para abertura do conta cliente
              JsonAbrirCC := '{"idContaCliente": 0' + ',"cnpj": "9999999",' +
                '"dtHrAbertura": "' + dataHoraAtual + '",' + '"situacao": "A",'
                + '"vlTotal":' + vlrTotalConsumido + ',' + '"apelido": "' + name
                + '","idCliente":' + idCliente + ',"dataHoraUltAlteracao": "' +
                dataHoraAtual + '",' + '"cpf": "' + cpf + '", "rfid": "' +
                rfid + '"}';

              // Abrir conta cliente para o cliente
              TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
                '/v1/contaCliente').ContentType('application/json')
                .AddBody(JsonAbrirCC).Post;

              // Pegar id cadastrado para a conta cliente
              LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
                '/v1/contaCliente?cpf=' + cpf).Accept('application/json').Get;

              LJSONArray := TJSONObject.ParseJSONValue(LResponse.Content)
                as TJSONArray;
              try
                for LJSONValue in LJSONArray do
                begin
                  idCliente := LJSONValue.GetValue<string>('idContacliente');
                end;
              finally
                LJSONArray.Free;
              end;
            end
            else
            begin
              // Pegar dados referentes a conta cliente
              LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
                '/v1/contaCliente?cpf=' + cpf).Accept('application/json').Get;
              dadosMytapp := LResponse.Content;

              LJSONArray := TJSONObject.ParseJSONValue(dadosMytapp)
                as TJSONArray;
              try
                for LJSONValue in LJSONArray do
                begin
                  idCliente := LJSONValue.GetValue<string>('idContacliente');
                  vlTotalArmazenado := LJSONValue.GetValue<string>('vlTotal');
                  dataHoraAtual := LJSONValue.GetValue<string>('dthrAbertura');
                  name := LJSONValue.GetValue<string>('apelido');
                end;
              finally
                LJSONArray.Free;
              end;

              a := Copy(dataHoraAtual, 1, 4);
              m := Copy(dataHoraAtual, 6, 2);
              d := Copy(dataHoraAtual, 9, 2);
              h := Copy(dataHoraAtual, 12, 8);
              dataHoraAtual := a + '/' + m + '/' + d + ' ' + h;

              vlrTotalConsumido := JSonValue.GetValue<string>
                (cpf + '.totalConsumed');
              rfid := JSonValue.GetValue<string>(cpf + '.rfid');

              vlrTotalConsumido := StringReplace(vlrTotalConsumido,
                '.', ',', []);
              vlTotalArmazenado := StringReplace(vlTotalArmazenado,
                '.', ',', []);
              som := vlrTotalConsumido.ToDouble + vlTotalArmazenado.ToDouble;

              // Json put conta cliente
              jsonCC := '{"idContaCliente":' + idCliente + ',"cnpj": "9999999",'
                + '"dtHrAbertura": "' + dataHoraAtual + '",' +
                '"situacao": "A",' + '"vlTotal":' + StringReplace(som.ToString,
                ',', '.', []) + ',' + '"apelido": "' + name + '","idCliente":' +
                idCliente + ',"dataHoraUltAlteracao": "' +
                FormatDateTime('yyyy/mm/dd hh:MM:ss', Now) + '",' + '"cpf": "' +
                cpf + '", "rfid": "' + rfid + '"}';

              // Atualizar o valor total do conta cliente em aberto
              LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti +
                '/v1/contaCliente').ContentType('application/json')
                .AddBody(jsonCC).Put;
            end;
          except
            on E: Exception do
              if Timer.Enabled = False then
              begin
                ShowMessage('Erro:' + E.Message);
              end
              else
              begin
                exit;
              end;
          end;

          // Gravar Cervejas
          try
            jsonRaiz := TJSONObject.ParseJSONValue(retorno) as TJSONObject;
            if (jsonRaiz <> nil) then
            begin
              jsArray := jsonRaiz.GetValue<TJSONArray>(cpf + '.beer')
                as TJSONArray;
              for i := 0 to jsArray.Count - 1 do
              begin
                // Dados retornados
                jsonObject := jsArray.Items[i] as TJSONObject;
                ml := jsonObject.GetValue<string>('ml');
                price := jsonObject.GetValue<string>('price');
                total := jsonObject.GetValue<string>('total');
                discount := jsonObject.GetValue<string>('discount');
                sku := jsonObject.GetValue<string>('sku');
                sync := jsonObject.GetValue<string>('sync');
                barId := jsonObject.GetValue<string>('bar_id');
                nameProduct := jsonObject.GetValue<string>('keg.product.name');
                salesId := jsonObject.GetValue<string>('sales_id');
                dataHoraAtual := FormatDateTime('yyyy/mm/dd hh:MM:ss', Now);

                // Formatar datas
                saleDate := jsonObject.GetValue<string>('sale_date');
                a := Copy(saleDate, 1, 4);
                m := Copy(saleDate, 6, 2);
                d := Copy(saleDate, 9, 2);
                h := Copy(saleDate, 12, 8);
                saleDateFormated := a + '/' + m + '/' + d + ' ' + h;

                // Pegar id cadastrado para o produto
                LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti
                  + '/v1/produtos?descricao=' + nameProduct)
                  .Accept('application/json').Get;
                retornoNome := LResponse.Content;

                LJSONArray := TJSONObject.ParseJSONValue(retornoNome)
                  as TJSONArray;
                try
                  for LJSONValue in LJSONArray do
                  begin
                    idProduto := LJSONValue.GetValue<string>('codigo');
                  end;
                finally
                  LJSONArray.Free;
                end;

                // Pegar número do item
                LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti
                  + '/v1/contaClienteItens?idContaCliente=' + idCliente)
                  .Accept('application/json').Get;
                nItem := 0;

                if LResponse.Content = 'Conta cliente item não encontrada ou não existe'
                then
                begin
                  nItem := 1;
                end
                else
                begin
                  LJSONArray := TJSONObject.ParseJSONValue(LResponse.Content)
                    as TJSONArray;
                  try
                    for LJSONValue in LJSONArray do
                    begin
                      counter := LJSONValue.GetValue<string>('idItem')
                        .ToInteger;

                      if counter > nItem then
                        nItem := LJSONValue.GetValue<string>('idItem')
                          .ToInteger;
                      nItem := nItem + 1;
                    end;
                  finally
                    LJSONArray.Free;
                  end;
                end;

                // Validação Sync
                if (sync = '') or (sync <> '1') then
                begin
                  // Post
                  jsonCervejas := '{"idContaCliente":' + idCliente + ',' +
                    '"idItem":' + nItem.ToString + ',"idProduto":' + idProduto +
                    ',' + '"descrProduto": "' + nameProduct + '","quantidade":'
                    + ml + ',"vlUnitario":' + price +
                    ',"vlDesconto": 0,"vlAcrescimo": 0' + ',"vlTotal":' + total
                    + ',' + '"dataHoraUltAlteracao": "' + dataHoraAtual +
                    '","idVenda":' + salesId + ',"barId":' + barId +
                    ',"dataVenda": "' + saleDateFormated + '"}';

                  // Gravar cervejas
                  LResponse := TRequest.New.BaseURL
                    (urlBaseAlsti + ':' + portAlsti + '/v1/contaClienteItens')
                    .ContentType('application/json').AddBody(jsonCervejas).Post;

                  // Sincronizar registro de cerveja se for gravado com sucesso
                  if LResponse.Content = 'Conta cliente item adicionado com sucesso!'
                  then
                  begin
                    jsonSyncProducts := '{"beer":["' + salesId + '"]}';

                    TRequest.New.BaseURL(urlBaseMytapp + '/api/v1/syncBeerById')
                      .AddHeader('token', tokenMytapp)
                      .ContentType('application/json')
                      .AddBody(jsonSyncProducts).Post;
                  end;
                end;
              end;
            end;
          except
            on E: Exception do
              if Timer.Enabled = False then
              begin
                ShowMessage('Erro:' + E.Message);
              end
              else
              begin
                exit;
              end;
          end;

          // Gravar Produtos
          try
            jsonRaiz := TJSONObject.ParseJSONValue(retorno) as TJSONObject;
            if (jsonRaiz <> nil) then
            begin
              jsArray := jsonRaiz.GetValue<TJSONArray>(cpf + '.products')
                as TJSONArray;
              for i := 0 to jsArray.Count - 1 do
              begin
                // Dados
                jsonObject := jsArray.Items[i] as TJSONObject;
                salesId := jsonObject.GetValue<string>('sales_id');
                quantity := jsonObject.GetValue<string>('quantity');
                price := jsonObject.GetValue<string>('price');
                total := jsonObject.GetValue<string>('total');
                discount := jsonObject.GetValue<string>('discount');
                sku := jsonObject.GetValue<string>('sku');
                barId := jsonObject.GetValue<string>('bar_id');
                nameProduct := jsonObject.GetValue<string>('productsale.name');
                sync := jsonObject.GetValue<string>('sync');

                // Formatar data
                saleDate := jsonObject.GetValue<string>('sale_date');
                a := Copy(saleDate, 1, 4);
                m := Copy(saleDate, 6, 2);
                d := Copy(saleDate, 9, 2);
                h := Copy(saleDate, 12, 8);
                saleDateFormated := a + '/' + m + '/' + d + ' ' + h;

                // Pegar id cadastrado para o produto
                LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti
                  + '/v1/produtos?descricao=' + nameProduct)
                  .Accept('application/json').Get;
                retornoNome := LResponse.Content;

                LJSONArray := TJSONObject.ParseJSONValue(retornoNome)
                  as TJSONArray;
                try
                  for LJSONValue in LJSONArray do
                  begin
                    idProduto := LJSONValue.GetValue<string>('codigo');
                  end;
                finally
                  LJSONArray.Free;
                end;

                // Pegar número do item
                LResponse := TRequest.New.BaseURL(urlBaseAlsti + ':' + portAlsti
                  + '/v1/contaClienteItens?idContaCliente=' + idCliente)
                  .Accept('application/json').Get;
                nItem := 0;

                if LResponse.Content = 'Conta cliente item não encontrada ou não existe'
                then
                begin
                  nItem := 1;
                end
                else
                begin
                  LJSONArray := TJSONObject.ParseJSONValue(LResponse.Content)
                    as TJSONArray;
                  try
                    for LJSONValue in LJSONArray do
                    begin
                      counter := LJSONValue.GetValue<string>('idItem')
                        .ToInteger;

                      if counter > nItem then
                        nItem := LJSONValue.GetValue<string>('idItem')
                          .ToInteger;
                      nItem := nItem + 1;
                    end;
                  finally
                    LJSONArray.Free;
                  end;
                end;

                // Validação Sync
                if (sync = '') or (sync <> '1') then
                begin
                  // Post
                  jsonProdutos := '{"idContaCliente":' + idCliente + ',' +
                    '"idItem":' + nItem.ToString + ',"idProduto":' + idProduto +
                    ',' + '"descrProduto": "' + nameProduct + '","quantidade":'
                    + quantity + ',"vlUnitario":' + price +
                    ',"vlDesconto": 0,"vlAcrescimo": 0' + ',"vlTotal":' + total
                    + ',' + '"dataHoraUltAlteracao": "' + dataHoraAtual +
                    '","idVenda":' + salesId + ',"dataVenda": "' +
                    saleDateFormated + '"}';

                  // Gravar produtos
                  LResponse := TRequest.New.BaseURL
                    (urlBaseAlsti + ':' + portAlsti + '/v1/contaClienteItens')
                    .ContentType('application/json').AddBody(jsonProdutos).Post;

                  // Sincronizar registro de produto
                  if LResponse.Content = 'Conta cliente item adicionado com sucesso!'
                  then
                  begin
                    jsonSyncProducts := '{"document":["' + cpf + '"]}';

                    TRequest.New.BaseURL(urlBaseMytapp + '/api/v1/confirmSync')
                      .AddHeader('token', tokenMytapp)
                      .ContentType('application/json')
                      .AddBody(jsonSyncProducts).Post;
                  end;
                end;
              end;
            end;
          except
            on E: Exception do
              if Timer.Enabled = False then
              begin
                ShowMessage('Erro:' + E.Message);
              end
              else
              begin
                exit;
              end;
          end;
        end;
      finally
        if Timer.Enabled = False then
        begin
          ShowMessage('Consumos importados com sucesso!');
        end;
        JSonValue.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      exit;
    end;
  end;
end;

procedure TFrmPrincipal.SpeedButtonOnOffClick(Sender: TObject);
begin
  // Ligar ou desligar sistema automático
  if SpeedButtonOnOff.Caption = 'Desligado' then
  begin
    SpeedButtonOnOff.Caption := 'Ligado';

    Timer.Enabled := True;
  end
  else if SpeedButtonOnOff.Caption = 'Ligado' then
  begin
    SpeedButtonOnOff.Caption := 'Desligado';

    Timer.Enabled := False;
  end;
end;

procedure TFrmPrincipal.SpeedButtonSaveClick(Sender: TObject);
var
  ArquivoINI: TIniFile;
  tempo: string;
  converter: integer;
begin
  // Guardar informações referentes ao temporizador
  try
    tempo := EditTime.Text;
    converter := (tempo.ToInteger * 1000);

    if Application.MessageBox('Confirma configuração?', 'Confirmação',
      MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin
      { FDConnectionDefs.ini }
      ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) +
        'FDConnectionDefs.INI');
      ArquivoINI.WriteString('ApoioLogico', 'Temporizador', converter.ToString);
      ArquivoINI.Free;
    end;

    Timer.Interval := converter;
  except
    ShowMessage('Ocorreu um erro ao configurar!');
  end;
end;

procedure TFrmPrincipal.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;

  // Importar clientes
  SpeedButtonImpCliClick(Sender);

  // Exportar produtos
  SpeedButtonExpProdutosClick(Sender);

  // Importar consumos
  SpeedButtonImpConsumosClick(Sender);

  Timer.Enabled := True;
end;

end.
