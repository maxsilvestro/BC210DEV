codeunit 50108 TrackingMngt
{
    procedure InsertTrackingSpec(var vItemJournalLine: Record "Item Journal Line"; iSerialNo: Code[50]; iLotNo: Code[50]; iQtyBase: Decimal)
    var
        lForReservEntry: Record "Reservation Entry";
        lTrkSpec: Record "Tracking Specification";
        lCreateReservEntry: Codeunit "Create Reserv. Entry";
        lExpectedReceiptDate: Date;
        lShipmentDate: Date;
    begin
        lForReservEntry."Serial No." := iSerialNo;
        lForReservEntry."Lot No." := iLotNo;
        lCreateReservEntry.CreateReservEntryFor(
                              Database::"Item Journal Line",
                              vItemJournalLine."Entry Type".AsInteger(),
                              vItemJournalLine."Journal Template Name",
                              vItemJournalLine."Journal Batch Name",
                              0,
                              vItemJournalLine."Line No.",
                              vItemJournalLine."Qty. per Unit of Measure",
                              0,
                              iQtyBase,
                              lForReservEntry);

        if (vItemJournalLine."Entry Type"
            in [vItemJournalLine."Entry Type"::Sale, vItemJournalLine."Entry Type"::"Negative Adjmt.", vItemJournalLine."Entry Type"::Transfer, vItemJournalLine."Entry Type"::Consumption]) then
            lShipmentDate := vItemJournalLine."Posting Date"
        else
            lExpectedReceiptDate := vItemJournalLine."Posting Date";

        if (vItemJournalLine."Entry Type" = vItemJournalLine."Entry Type"::Transfer) then begin
            lTrkSpec."New Lot No." := iLotNo;
            lTrkSpec."New Serial No." := iSerialNo;
            lCreateReservEntry.SetNewTrackingFromNewTrackingSpecification(lTrkSpec);
        end;
        lCreateReservEntry.CreateEntry(vItemJournalLine."Item No.",
                          vItemJournalLine."Variant Code",
                          vItemJournalLine."Location Code",
                          vItemJournalLine.Description,
                          lExpectedReceiptDate,
                          lShipmentDate, 0, Enum::"Reservation Status"::Prospect);
    end;

    procedure InsertTrackingSpec(var vSalesLine: Record "Sales Line"; iSerialNo: Code[50]; iLotNo: Code[50]; iQtyBase: Decimal)
    var
        lCreateReservEntry: Codeunit "Create Reserv. Entry";
        lForReservEntry: Record "Reservation Entry";
    begin
        lForReservEntry."Serial No." := iSerialNo;
        lForReservEntry."Lot No." := iLotNo;
        lCreateReservEntry.CreateReservEntryFor(
                              Database::"Sales Line",
                              vSalesLine."Document Type".AsInteger(),
                              vSalesLine."Document No.",
                              '',
                              0,
                              vSalesLine."Line No.",
                              vSalesLine."Qty. per Unit of Measure",
                              0,
                              iQtyBase,
                              lForReservEntry);

        lCreateReservEntry.CreateEntry(vSalesLine."No.",
                          vSalesLine."Variant Code",
                          vSalesLine."Location Code",
                          vSalesLine.Description,
                          0D,
                          vSalesLine."Shipment Date", 0, Enum::"Reservation Status"::Prospect);
    end;
}
