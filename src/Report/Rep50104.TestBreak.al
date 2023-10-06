report 50104 TestBreak
{
    ApplicationArea = All;
    Caption = 'TestBreak';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            trigger OnPreDataItem()
            begin
                message('OnPreDataItem 1');
                if BreakOnPre then
                    CurrReport.Break();
                message('OnPreDataItem 2');
            end;

            trigger OnAfterGetRecord()
            begin
                ItemsCount += 1;
                if not FirstPass then
                    FirstPass := true;
            end;

            trigger OnPostDataItem()
            begin
                if (not FirstPass) then
                    CurrReport.Break();
                Message('ItemsCount %1', ItemsCount);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(BreakOnPre; BreakOnPre)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        ItemsCount: Integer;
        FirstPass: Boolean;
        BreakOnPre: Boolean;
}
