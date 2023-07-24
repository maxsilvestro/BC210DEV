report 50101 "Test Language"
{
    ApplicationArea = All;
    Caption = 'Test Language';
    UsageCategory = History;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Report\TestLanguage.rdl';
    dataset
    {
        dataitem(LanguageDI; Language)
        {
            column(Code; "Code")
            {
            }
            column(Name; Name)
            {
            }
            column(MyLabel; MyLabel)
            {
            }
            trigger OnAfterGetRecord()
            var
                lCode: Code[10];
            begin
                // if (LanguageDI.Code <> 'ITA') then
                //     lCode := 'ENG'
                // else
                lCode := LanguageDI.Code;
                CurrReport.Language := CULanguage.GetLanguageIdOrDefault(lCode);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
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
        MyLabel: Label 'Inglese ≥', comment = 'ITA="Italiano ≥"';
        CULanguage: Codeunit Language;
}
