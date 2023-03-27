page 50101 MyRecordLinks
{
    ApplicationArea = All;
    Caption = 'MyRecordLinks';
    PageType = List;
    SourceTable = "Record Link";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(Created; Rec.Created)
                {
                    ToolTip = 'Specifies the value of the Created field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Link ID"; Rec."Link ID")
                {
                    ToolTip = 'Specifies the value of the Link ID field.';
                }
                field(Notetext; GetNotetext)
                {
                    ToolTip = 'Specifies the value of the Note field.';
                }
                field(Notify; Rec.Notify)
                {
                    ToolTip = 'Specifies the value of the Notify field.';
                    ApplicationArea = All;
                }
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.';
                }
                field("To User ID"; Rec."To User ID")
                {
                    ToolTip = 'Specifies the value of the To User ID field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(URL1; Rec.URL1)
                {
                    ToolTip = 'Specifies the value of the URL1 field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
        }
    }
    local procedure GetNotetext() OText: Text
    var
        RLMgt: Codeunit "Record Link Management";
    begin
        Rec.CalcFields(note);
        OText := RLMgt.ReadNote(Rec);
    end;
}
