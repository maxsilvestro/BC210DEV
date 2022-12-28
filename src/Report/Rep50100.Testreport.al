report 50100 Test_report
{
    ApplicationArea = All;
    Caption = 'Test_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Excel;
    ExcelLayout = '.\src\Report\Test_Report.xlsx';
    WordLayout = '.\src\Report\Test_Report.docx';
    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            column(BinCode_SalesLine; "Bin Code")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(LineNo; "Line No.")
            {
            }
            column(Type; "Type")
            {
            }
            column(No; "No.")
            {
            }

            column(Quantity; Quantity)
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
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
}
