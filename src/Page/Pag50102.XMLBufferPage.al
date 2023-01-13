page 50102 "XML Buffer Page"
{

    ApplicationArea = All;
    Caption = 'XML Buffer Page';
    PageType = List;
    SourceTable = "XML Buffer";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Import ID"; Rec."Import ID")
                {
                    ApplicationArea = All;
                }


                field("Node Number"; Rec."Node Number")
                {
                    ApplicationArea = All;
                }
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Value BLOB"; Rec."Value BLOB")
                {
                    ApplicationArea = All;
                }

                field(Depth; Rec.Depth)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Namespace; Rec.Namespace)
                {
                    ApplicationArea = All;
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
