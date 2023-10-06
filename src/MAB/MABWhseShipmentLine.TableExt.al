tableextension 80001 "MAB Whse Shipment Line" extends "Warehouse Shipment Line"
{
    fields
    {

    }

    procedure AmountToShip(): Decimal
    var
        MABWhseMgt: Codeunit "MAB Whse Mgt";
    begin
        exit(MABWhseMgt.WhseShipmentLineAmountToShip(Rec));
    end;

    procedure UnitAmount(): Decimal
    var
        MABWhseMgt: Codeunit "MAB Whse Mgt";
    begin
        exit(MABWhseMgt.WhseShipmentLineUnitAmount(Rec));
    end;
}
