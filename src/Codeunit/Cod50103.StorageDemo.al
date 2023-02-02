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
    begin
        StorageAccountName := 'StorageAccountName';
        //Connessione
        Authorization := StorageServiceAuthorization.CreateSharedKey('CHIAVEDIACCESSO');
        ContainerClient.Initialize(StorageAccountName, Authorization);//A questo punto sono autenticato

        //Azioni
        //Creazione container
        Response := ContainerClient.CreateContainer('nomecontainer');
        if not Response.IsSuccessful() then
            error(Response.GetError());
        //Lista dei container
        Response := ContainerClient.ListContainers(Containers);
        if not Response.IsSuccessful() then
            error(Response.GetError());
        if Containers.FindSet() then
            repeat
                Message(Containers.Name);//
            until Containers.Next() = 0;

        //Inizializza Blob
        BlobClient.Initialize(StorageAccountName, 'nomecontainer', Authorization);

        //Creo un file
        Response := BlobClient.PutBlobBlockBlobText('Nomedelfile', 'contenuto del file di testo');
        if not Response.IsSuccessful() then
            error(Response.GetError());

        //leggo lista dei files
        Response := BlobClient.ListBlobs(ContainerContent);
        if not Response.IsSuccessful() then
            error(Response.GetError());

        if ContainerContent.FindSet() then
            repeat
                Message('Blob name: %1', ContainerContent.Name);
                //leggo il contenuto del file
                Response := BlobClient.GetBlobAsText(ContainerContent.Name, TextFileContent);
                Message(TextFileContent);
            until ContainerContent.Next() = 0;
    end;
}
