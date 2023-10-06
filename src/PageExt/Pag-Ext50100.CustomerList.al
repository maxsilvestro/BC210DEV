pageextension 50100 CustomerList_50100 extends "Customer List"
{

    actions
    {
        addfirst(processing)
        {
            action(TestMail)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    sendMail();
                end;
            }
            action(LinkWebAction)
            {
                ApplicationArea = All;
                Image = LinkWeb;
                Caption = 'Test SalesForce OAuth';

                trigger OnAction()
                var
                    ReqMagt: Codeunit RequestManagement;
                begin
                    Message(ReqMagt.PostEcoSFOauth());
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
                Caption = 'Test Filter';
                trigger OnAction()
                var
                    lCU: Codeunit Varie;

                begin
                    //lCU.CallAzureFuncDemo();
                    //lCU.ReadSMBFile('\\HP-MAMO\Sciascia\pippo.txt');
                    CreateFilterPage;
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
            action(TestFormat)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInteger: Decimal;
                begin
                    myInteger := 3.999999;
                    Message(Format(myInteger, 2, '<Integer,2><Filler Character,0>'));
                end;
            }
            action(TestChar)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myText: Text;
                    valid: Text;
                begin
                    myText := '?123ciao sto cazzo 99@ò';
                    valid := '1234567890';
                    myText := DelChr(myText, '=', DelChr(myText, '=', valid));
                    Message(myText);
                end;
            }
        }
    }

    procedure sendMail()
    var
        lEmailMessage: Codeunit "Email Message";
        lEmail: Codeunit Email;
        lRecipients: List of [Text];
        lCC: List of [Text];
        lBCC: List of [Text];
        lSubj: TextBuilder;
        lBody: TextBuilder;
    begin
        lRecipients.Add('massimiliano.silvestro@4consulting.it');
        lBCC.Add('massimiliano.rampazzo@4consulting.it');
        lSubj.Append('Oggetto');
        lBody.AppendLine('Testo riga 1');
        lBody.AppendLine('Testo riga 2');
        lBody.AppendLine('Testo riga 3');
        lBody.AppendLine('Testo riga 4');
        lEmailMessage.create(lRecipients, lSubj.ToText(), lBody.ToText(), false, lCC, lBCC);

        lEmail.Send(lEmailMessage, enum::"Email Scenario"::Default);
    end;

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

    procedure CreateFilterPage()
    var
        lFilterPageBuilder: FilterPageBuilder;
        lCustomer: Record Customer;
        lItem: Record Item;
    begin
        lFilterPageBuilder.AddRecord('Item Table', lItem);
        lFilterPageBuilder.Addfield('Item Table', lItem."No.", 'A*');
        lFilterPageBuilder.PageCaption := 'Item Filter Page';
        lFilterPageBuilder.RunModal;
        lItem.reset;
        lItem.SetView(lFilterPageBuilder.Getview('Item Table'));
        Message('lItem.GetFilters %1', lItem.GetFilters);
    end;
}

