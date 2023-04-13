page 50103 "4CO_UserProperty"
{
    ApplicationArea = All;
    Caption = 'UserProperty';
    PageType = List;
    SourceTable = "User Property";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Authentication Key"; Rec."Authentication Key")
                {
                    ToolTip = 'Specifies the value of the Authentication Key field.';
                }
                field("Authentication Object ID"; Rec."Authentication Object ID")
                {
                    ToolTip = 'Specifies the value of the Authentication Object ID field.';
                }
                field("Directory Role ID List"; Rec."Directory Role ID List")
                {
                    ToolTip = 'Specifies the value of the Directory Role ID List field.';
                }
                field("Name Identifier"; Rec."Name Identifier")
                {
                    ToolTip = 'Specifies the value of the Name Identifier field.';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Telemetry User ID"; Rec."Telemetry User ID")
                {
                    ToolTip = 'Specifies the value of the Telemetry User ID field.';
                }
                field("User Security ID"; Rec."User Security ID")
                {
                    ToolTip = 'Specifies the value of the User Security ID field.';
                }
                field("WebServices Key"; Rec."WebServices Key")
                {
                    ToolTip = 'Specifies the value of the WebServices Key field.';
                }
                field("WebServices Key Expiry Date"; Rec."WebServices Key Expiry Date")
                {
                    ToolTip = 'Specifies the value of the WebServices Key Expiry Date field.';
                }
            }
        }
    }
}
