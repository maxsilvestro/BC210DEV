pageextension 50186 "MAB Warehouse Shipment" extends "Warehouse Shipment"
{
    layout
    {
        addlast(General)
        {
            field(AmountToShip; Rec.AmountToShip())
            {
                ApplicationArea = All;
                Caption = 'Shipment amount';
                ToolTip = 'Specify the amount to ship.';
                Editable = false;
            }
        }
    }
}
