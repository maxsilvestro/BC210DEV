codeunit 80001 "MAB Whse Mgt"
{

    procedure SplitWhseShipment(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        NewWarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if not WarehouseShipmentLine.FindSet(true) then
            exit;
        WarehouseShipmentHeader.Get(WarehouseShipmentLine."No.");

        NewWarehouseShipmentHeader := CreateNewWhseShipHeader(WarehouseShipmentHeader);

        repeat
            MoveWhseShipLine(NewWarehouseShipmentHeader, WarehouseShipmentLine);
        until WarehouseShipmentLine.Next() = 0;
    end;

    procedure WhseShipmentAmountToShip(WarehouseShipmentHeader: Record "Warehouse Shipment Header") Result: Decimal
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentHeader."No.");
        if not WarehouseShipmentLine.FindSet() then
            exit;

        repeat
            Result += WarehouseShipmentLine.AmountToShip();
        until WarehouseShipmentLine.Next() = 0;
    end;

    procedure WhseShipmentLineAmountToShip(WarehouseShipmentLine: Record "Warehouse Shipment Line") Result: Decimal
    begin
        Result := WarehouseShipmentLine.UnitAmount() * WarehouseShipmentLine."Qty. to Ship";
    end;

    procedure WhseShipmentLineUnitAmount(WarehouseShipmentLine: Record "Warehouse Shipment Line") Result: Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        if (WarehouseShipmentLine."Source Type" <> Database::"Sales Line")
            or (WarehouseShipmentLine."Source Subtype" <> SalesLine."Document Type"::Order.AsInteger()) then
            exit;

        if (not SalesLine.Get(SalesLine."Document Type"::Order, WarehouseShipmentLine."Source No.", WarehouseShipmentLine."Source Line No."))
            or (SalesLine.Quantity = 0) then
            exit;

        Result := SalesLine.Amount / SalesLine.Quantity;
    end;

    local procedure CreateNewWhseShipHeader(WarehouseShipmentHeader: Record "Warehouse Shipment Header") NewWarehouseShipmentHeader: Record "Warehouse Shipment Header"
    begin
        NewWarehouseShipmentHeader.Init();
        NewWarehouseShipmentHeader.TransferFields(WarehouseShipmentHeader, false);
        NewWarehouseShipmentHeader.Insert(true);
    end;

    local procedure MoveWhseShipLine(ToWarehouseShipmentHeader: Record "Warehouse Shipment Header"; WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        ToWarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        if (ToWarehouseShipmentHeader."No." = WarehouseShipmentLine."No.") then
            exit;

        ToWarehouseShipmentLine.TransferFields(WarehouseShipmentLine, false);
        ToWarehouseShipmentLine."No." := ToWarehouseShipmentHeader."No.";
        ToWarehouseShipmentLine."Line No." := WarehouseShipmentLine."Line No.";
        ToWarehouseShipmentLine.Insert(true);

        WarehouseShipmentLine.Delete(true);
    end;
}
