pageextension 80001 "MAB Whse Shipment Subform" extends "Whse. Shipment Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(UnitAmount; Rec.UnitAmount())
            {
                ApplicationArea = All;
                Caption = 'Unit amount';
                ToolTip = 'Specify the unit amount from order.';
                Editable = false;
            }
        }
    }
    actions
    {
        addlast("&Line")
        {
            action(SplitLinesAction)
            {
                ApplicationArea = All;
                Image = Splitlines;
                Caption = 'Split shipment';
                ToolTip = 'Move selected lines in a new Warehouse Shimpment.';

                trigger OnAction()
                var
                    WarehouseShipmentLine: Record "Warehouse Shipment Line";
                    MABWhseMgt: Codeunit "MAB Whse Mgt";
                    ConfirmLbl: Label 'Do You want to move the %1 selected lines in a new Warehouse Shimpment?';
                begin
                    CurrPage.SetSelectionFilter(WarehouseShipmentLine);
                    if WarehouseShipmentLine.IsEmpty then
                        exit;

                    if not Confirm(ConfirmLbl, false, WarehouseShipmentLine.Count) then
                        exit;

                    MABWhseMgt.SplitWhseShipment(WarehouseShipmentLine);
                end;
            }
        }
    }
}
