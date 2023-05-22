pageextension 50102 "ItemList50102" extends "Item List"
{
    actions
    {
        addfirst(processing)
        {
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
}
