pageextension 50100 CustomerList_50100 extends "Customer List"
{

    actions
    {
        addfirst(processing)
        {
            action(LinkWebAction)
            {
                ApplicationArea = All;
                Image = LinkWeb;
                Caption = 'Test EcoCerved OAuth';

                trigger OnAction()
                var
                    ReqMagt: Codeunit RequestManagement;
                begin
                    Message(ReqMagt.GetEcoCervedDeleghe(ReqMagt.PostEcoCervedAuth()));
                end;
            }

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
                    lXMLDoc: XmlDocument;
                    lXmlNodeList: XmlNodeList;
                    lXMLNode: XmlNode;
                begin
                    UploadIntoStream('Scegli il file', '', 'XML Files (*.xml)|*.xml', lFile, lInSt);

                    XmlDocument.ReadFrom(lInSt, lXMLDoc);
                    lXMLDoc.SelectNodes('//FatturaElettronicaBody/DatiBeniServizi/DettaglioLinee', lXmlNodeList);
                    foreach lXMLNode in lXmlNodeList do begin
                        ProcLine(lXMLNode);
                    end;

                    // lXMLBTMP."LoadFromStream"(lInSt);

                    // page.RunModal(page::"XML Buffer Page", lXMLBTMP);

                end;
            }
        }
    }


    local procedure ProcLine(iXMLNode: XmlNode)
    var
        lText: Text;
        lXMLNodeList: XmlNodeList;
        lXMLNode: XmlNode;
    begin
        lXMLNodeList := iXMLNode.AsXmlElement().GetDescendantElements('NumeroLinea');
        lXMLNodeList.Get(1, lXMLNode);
        Message(lXMLNode.AsXmlElement().InnerText);

    end;
}

