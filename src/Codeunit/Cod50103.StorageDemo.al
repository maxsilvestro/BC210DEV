codeunit 50103 StorageDemo
{
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
        Response := BlobClient.PutBlobBlockBlobText('Nomedelfile.txt', 'contenuto del file di testo');
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
}
