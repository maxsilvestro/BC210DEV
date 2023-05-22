table 50100 ExpBOMLine
{
    Caption = 'ExpBOMLine';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LineNo; Integer)
        {
            Caption = 'LineNo';
            DataClassification = CustomerContent;
        }
        field(2; ItemNo; Code[20])
        {
            Caption = 'ItemNo';
            DataClassification = CustomerContent;
        }
        field(3; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }
        field(4; CompNo; Code[20])
        {
            Caption = 'CompNo';
            DataClassification = CustomerContent;
        }
        field(5; BOMQuantity; Decimal)
        {
            Caption = 'BOMQuantity';
            DataClassification = CustomerContent;
        }
        field(6; UoM; Code[10])
        {
            Caption = 'UoM';
            DataClassification = CustomerContent;
        }
        field(7; TotalQty; Decimal)
        {
            Caption = 'TotalQty';
            DataClassification = CustomerContent;
        }
        field(8; CompDesc; Text[100])
        {
            Caption = 'CompDesc';
            DataClassification = CustomerContent;
        }
        field(9; CompVar; Code[10])
        {
            Caption = 'CompVar';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; LineNo)
        {
            Clustered = true;
        }
    }
}
