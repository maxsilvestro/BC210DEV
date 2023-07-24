report 50103 "Test Symbols"
{
    ApplicationArea = All;
    Caption = 'Test Symbols';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Report\TestSymbols.rdl';
    dataset
    {
        dataitem(Integer; "Integer")
        {
            column(Number; Number)
            { }
            column(Mytext; Mytext)
            { }
            trigger OnPreDataItem()
            begin
                SetFilter(Number, '>0');
            end;

            trigger OnAfterGetRecord()
            begin
                Mytext[1] := Integer.Number;
                if Mytext = '≥' then
                    SetRange(Number, Number)
                else
                    CurrReport.Skip();
            end;
        }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //         }
    //     }
    // }
    var
        Mytext: Text;
}
