codeunit 50104 RequestManagement
{

    procedure PostEcoCervedAuth() oToken: Text
    var
        lUrl, lClientId, lClientSecret : Text;
        lFormBody: Dictionary of [Text, Text];
        lResponse: Text;
    begin
        lUrl := 'https://identity.ecocerved.it/connect/token';
        lFormBody.Add('grant_type', 'client_credentials');
        lFormBody.Add('client_id', '16B8E595-5E58-4E8E-837C-679B0F02271D@ecocamere');
        lFormBody.Add('client_secret', 'TEd0ZFNyR01SRXF4SlcydS9NL0MxYndCcmcxNEZaWHdvUFRXSGEzRDF4TT0');

        if not PostRestForm(lUrl, lFormBody, lResponse) then
            Error('PostEcoCervedAuth\' + lResponse);

        oToken := ParseOAuthToken(lResponse);
    end;

    procedure GetEcoCervedDeleghe(iBearerToken: Text) oResponse: Text
    var
        lAPIBaseUrl: Text;
    begin
        lAPIBaseUrl := 'https://demovivifir.ecocamere.it/api';
        //lAPIBaseUrl := 'https://vivifir.ecocamere.it/api';

        if not MakeBearerRequestGET(lAPIBaseUrl + '/utenti/procureDeleghe', iBearerToken, oResponse) then
            Error('GetEcoCervedDeleghe\' + oResponse);
    end;

    Local procedure AddBearerAuthentication(vHttpClient: HttpClient; iAccessToken: Text)
    var
        lAuthstr: text;
    begin
        lAuthstr := 'Bearer ' + iAccessToken;
        vHttpClient.DefaultRequestHeaders.Add('Authorization', lAuthstr);
    end;

    local procedure GetFormData(iFormBody: Dictionary of [Text, Text]) Result: Text
    var
        lTypeHelper: Codeunit "Type Helper";
        lTxtBld: TextBuilder;
        lValue: Text;
        lKey: Text;
        lFirstPass: Boolean;
    begin
        foreach lKey in iFormBody.Keys do begin
            if lFirstPass then
                lTxtBld.Append('&')
            else
                lFirstPass := true;

            lTxtBld.Append(lKey);
            lTxtBld.Append('=');
            lValue := iFormBody.Get(lKey);
            lTypeHelper.UrlEncode(lValue);
            lTxtBld.Append(lValue);
        end;

        Result := lTxtBld.ToText();
    end;

    local procedure MakeBearerRequestGET(iUri: Text; iAccessToken: text; var vResponseText: Text) Result: Boolean;
    var
        lHttpClient: HttpClient;
        lRequest: HttpRequestMessage;
        lResponse: HttpResponseMessage;
    begin
        lHttpClient.Timeout(-1);
        AddBearerAuthentication(lHttpClient, iAccessToken);

        lHttpClient.Get(iUri, lResponse);
        if not lResponse.IsSuccessStatusCode then begin
            vresponseText := 'Error Message: ' + Format(lResponse.ReasonPhrase);
            exit(false);
        end;

        lResponse.Content().ReadAs(vresponseText);
        Result := true;
    end;

    local procedure ParseOAuthToken(pJsonText: Text) Result: text
    var
        lJToken: JsonToken;
        lJsonToken1: JsonToken;
        lJToken1: JsonToken;
    begin
        lJToken.ReadFrom(pJsonText);
        lJToken.SelectToken('access_token', lJsonToken1);
        Result := lJsonToken1.AsValue().AsText();
    end;

    local procedure PostRestForm(iUri: Text; iFormBody: Dictionary of [Text, Text]; var vResponseText: Text) Result: Boolean
    var
        lHttpClient: HttpClient;
        lResponse: HttpResponseMessage;
        lContHdr: HttpHeaders;
        lContent: HttpContent;
    begin
        lHttpClient.Timeout(-1);
        lContent.WriteFrom(GetFormData(iFormBody));
        lContent.GetHeaders(lContHdr);
        lContHdr.Clear();
        lContHdr.Add('Content-Type', 'application/x-www-form-urlencoded');
        lHttpClient.Post(iUri, lContent, lResponse);

        if not lResponse.IsSuccessStatusCode then begin
            vresponseText := 'Error Message: ' + Format(lResponse.ReasonPhrase);
            exit(false);
        end;

        lResponse.Content().ReadAs(vResponseText);
        Result := true;
    end;
}
