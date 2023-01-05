page 50100 JsonBuffer
{

    ApplicationArea = All;
    Caption = 'JsonBuffer';
    PageType = List;
    SourceTable = "JSON Buffer";
    UsageCategory = Lists;
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Token type"; Rec."Token type")
                {
                    ApplicationArea = All;
                }
                field("Value Type"; Rec."Value Type")
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.GetValue())
                {
                    ApplicationArea = All;
                }
                field(Depth; Rec.Depth)
                {
                    ApplicationArea = All;
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
