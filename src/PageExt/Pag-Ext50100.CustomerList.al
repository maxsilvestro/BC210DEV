pageextension 50100 CustomerList_50100 extends "Customer List"
{

    actions
    {
        addfirst(processing)
        {
            action(TestStorage)
            {
                ApplicationArea = All;
                Caption = 'Test Storage';

                trigger OnAction()
                var
                    StorageDemo: Codeunit StorageDemo;
                begin
                    StorageDemo.Demostorage();
                end;
            }
            action(Debug)
            {
                ApplicationArea = all;
                Caption = 'Test Azure Function';
                trigger OnAction()
                var
                    lCU: Codeunit StorageDemo;

                begin
                    //lCU.CallAzureFuncDemo();
                    lCU.CallAzureFuncXMLStyle();
                end;
            }
            action(TestXML)
            {
                Caption = 'TestXML';
                ApplicationArea = all;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lFile: Text;
                    lInSt: InStream;
                    lXMLBTMP: record "XML Buffer" temporary;
                    lX: codeunit "XML Buffer Reader";

                begin
                    UploadIntoStream('Scegli il file', '', 'XML Files (*.xml)|*.xml', lFile, lInSt);

                    lXMLBTMP."LoadFromStream"(lInSt);

                    page.RunModal(page::"XML Buffer Page", lXMLBTMP);

                end;
            }
        }
    }
}
