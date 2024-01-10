pageextension 50102 "ItemList50102" extends "Item List"
{
    actions
    {
        addfirst(processing)
        {
            action(testXLS)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ExportExcel();
                end;
            }
            action(ExplodeBOM)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    lExplodeBOM: Report ExplodeBOM;
                    lEXPBomLine: Record ExpBOMLine temporary;
                    lItem: Record Item;
                begin
                    lItem := rec;
                    litem.SetRecFilter();

                    lExplodeBOM.SetTableView(lItem);
                    lExplodeBOM.SetBOMVers('pippo');
                    lExplodeBOM.UseRequestPage := false;
                    lExplodeBOM.RunModal();
                    lExplodeBOM.getBOMTable(lEXPBomLine);
                    Page.RunModal(pAGE::"ExpBOMLines", lEXPBomLine);
                end;
            }
        }
    }
    procedure ExportExcel()
    var
        lExcelBufferTmp: Record "Excel Buffer" temporary;
        lHeadertext: Text;
        lSheetNameText: Text;
    begin
        lHeadertext := 'Header text';
        lSheetNameText := 'Sheet Name';
        lExcelBufferTmp.CreateNewBook(lSheetNameText);
        lExcelBufferTmp.ClearNewRow();
        lExcelBufferTmp.AddColumn('Pippo', false, '', false, false, false, '', 1);
        lExcelBufferTmp.WriteSheet(lHeadertext, CompanyName(), UserId());
        lSheetNameText := 'Sheet Name2';
        lExcelBufferTmp.SelectOrAddSheet(lSheetNameText);
        lExcelBufferTmp.DeleteAll();
        lExcelBufferTmp.AddColumn('pluto', false, '', false, false, false, '', 1);
        lExcelBufferTmp.WriteSheet(lHeadertext, CompanyName(), UserId());
        lExcelBufferTmp.CloseBook();

        WriteExcelFile(lExcelBufferTmp, lHeadertext + '.xlsx');
    end;

    local procedure WriteExcelFile(var vExcelBuffer: Record "Excel Buffer"; itempFileName: text)
    var
        lDialogTitle: Label 'Save Excel File...', comment = 'ITA="Salva file Excel..."';
        lExcelFileType: Label 'Excel Files (*.xlsx;*.xls)|*.xlsx;*.xls';
        lTempBlob: Codeunit "Temp Blob";
        lFileInStream: InStream;
        lFileOutStream: OutStream;
    begin
        lTempBlob.CreateInStream(lFileInStream);
        lTempBlob.CreateOutStream(lFileOutStream);
        vExcelBuffer.SaveToStream(lFileOutStream, false);

        DownloadFromStream(lFileInStream, lDialogTitle, '', lExcelFileType, itempFileName);
    end;
}
