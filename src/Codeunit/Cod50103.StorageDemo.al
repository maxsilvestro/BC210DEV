codeunit 50103 StorageDemo
{

    procedure CallAzureFuncDemo()
    var
        Auth: Codeunit "Azure Functions Authentication";
        Func: Codeunit "Azure Functions";
        IAuth: Interface "Azure Functions Authentication";
        Response: Codeunit "Azure Functions Response";
        Body: JsonObject;
        Bodytext: Text;
        RespText: Text;
    begin
        Body.Add('name', 'pippo');
        Body.Add('ciao', 'sto cazzo');
        Body.WriteTo(Bodytext);

        IAuth := Auth.CreateCodeAuth('https://prove4c01.azurewebsites.net/api/HttpTrigger1', 'gMsraxJrCIzhcmKQ_QfbO_ls86exCkbdvu-71tUJlaT6AzFuE9wdNQ==');
        Response := Func.SendPostRequest(IAuth, Bodytext, 'application/json');

        if Response.IsSuccessful() then
            Response.GetResultAsText(RespText)
        else
            Error(Response.GetError());

        Message(RespText);
    end;

    procedure CallAzureFuncXMLStyle()
    var
        Func: Codeunit "Azure Functions";
        Auth: Codeunit "Azure Functions Authentication";
        Response: Codeunit "Azure Functions Response";
        InStrFile, ResInstr : InStream;
        IAuth: Interface "Azure Functions Authentication";
        Body: JsonObject;
        Bodytext: Text;
        FromFile: text;
        RespText: Text;
    begin
        if not UploadIntoStream('Style Sheet', '', 'All Files (*.*)|*.*', FromFile, InStrFile) then
            exit;
        Body.Add('XMLStyleSheet', StreamToText(InStrFile, TextEncoding::UTF8));

        clear(InStrFile);
        if not UploadIntoStream('XML', '', 'All Files (*.*)|*.*', FromFile, InStrFile) then
            exit;
        Body.Add('XMLFile', StreamToText(InStrFile, TextEncoding::UTF8));
        Body.WriteTo(Bodytext);

        IAuth := Auth.CreateCodeAuth('https://prove4c01.azurewebsites.net/api/XMLApplySheet', '8PWjBz0ETwGJVaHX7nHx8Mh0DxGkT06cdBj1l8lKO7bhAzFuzC8hdw==');
        Response := Func.SendPostRequest(IAuth, Bodytext, 'application/json');

        if Response.IsSuccessful() then begin
            FromFile := 'Invoice.htm';

            Response.GetResultAsStream(ResInstr);

            DownloadFromStream(ResInstr, 'Download', '', 'All Files (*.*)|*.*', FromFile);
        end else
            Error(Response.GetError());
    end;

    procedure Demostorage()
    var
        //Per lavorare col blob storage ci sono le codeunit 'ABS *'
        ContainerClient: Codeunit "ABS Container Client";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        StorageAccountName: Text;
        Authorization: Interface "Storage Service Authorization";
        Response: Codeunit "ABS Operation Response";
        Containers: Record "ABS Container";
        BlobClient: Codeunit "ABS Blob Client";
        ContainerContent: Record "ABS Container Content";
        TextFileContent: Text;
        ContainerName: Text;
        Filename: text;
        BlobInStream: InStream;
        ZipInStream: InStream;
        ZipOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        DataCompression: Codeunit "Data Compression";
        DialogTitle: Label 'Save ZIP file..', comment = 'ITA="Salvataggio file ZIP.."';
    begin
        StorageAccountName := 'blobstorage4c';
        ContainerName := 'provemamo';
        //Connessione
        Authorization := StorageServiceAuthorization.CreateSharedKey('Di5ORwCQ5zp0Wxl0flD36qhRPsDDGC9mJswHJ+nHN1BBlHkz7D24WziTtk4kqSsOAzyebT/Y9EFu+ASttn7K1w==');
        ContainerClient.Initialize(StorageAccountName, Authorization);//A questo punto sono autenticato

        //Azioni

        //Lista dei container
        Response := ContainerClient.ListContainers(Containers);
        if not Response.IsSuccessful() then
            error(Response.GetError());

        if Containers.Get(ContainerName) then
            Message('Container %1 già presente', Containers.Name)
        else begin
            //Creazione container
            Response := ContainerClient.CreateContainer(ContainerName);
            if not Response.IsSuccessful() then
                error(Response.GetError());
        end;

        //Inizializza Blob
        BlobClient.Initialize(StorageAccountName, ContainerName, Authorization);

        //Creo un file
        Response := BlobClient.PutBlobBlockBlobText('Nomedelfile2.txt', 'contenuto del file di testo2');
        if not Response.IsSuccessful() then
            error(Response.GetError());

        //leggo lista dei files
        Response := BlobClient.ListBlobs(ContainerContent);
        if not Response.IsSuccessful() then
            error(Response.GetError());

        DataCompression.CreateZipArchive();

        if ContainerContent.FindSet() then
            repeat
                Filename := ContainerContent.Name;
                //leggo il contenuto del file
                Response := BlobClient.GetBlobAsStream(ContainerContent.Name, BlobInStream);
                if Response.IsSuccessful() then
                    DataCompression.AddEntry(BlobInStream, FileName);

            until ContainerContent.Next() = 0;

        TempBlob.CreateInStream(ZipInStream);
        TempBlob.CreateOutStream(ZipOutStream);
        DataCompression.SaveZipArchive(ZipOutStream);
        DataCompression.CloseZipArchive();

        Filename := ContainerName + '.zip';
        DownloadFromStream(ZipInStream, DialogTitle, '', 'ZIP Files (*.zip)|*.zip', Filename);
    end;

    local procedure StreamToText(var vInStream: InStream; iEncoding: TextEncoding) Result: Text
    var
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        Outst: OutStream;
        TypeHelper: Codeunit "Type Helper";
    begin
        TempBlob.CreateOutStream(Outst, iEncoding);
        TempBlob.CreateInStream(InStr, iEncoding);
        CopyStream(Outst, vInStream);
        Result := TypeHelper.ReadAsTextWithSeparator(InStr, TypeHelper.LFSeparator());
    end;
}