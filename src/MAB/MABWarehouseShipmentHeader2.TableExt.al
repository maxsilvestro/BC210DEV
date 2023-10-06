tableextension 80002 "MAB WarehouseShipmentHeader 2" extends "Warehouse Shipment Header"
{
    fields
    {

    }

    procedure AmountToShip(): Decimal
    var
        MABWhseMgt: Codeunit "MAB Whse Mgt";
    begin
        exit(MABWhseMgt.WhseShipmentAmountToShip(Rec));
    end;
}
