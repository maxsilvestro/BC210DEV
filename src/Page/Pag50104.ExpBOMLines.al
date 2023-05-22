page 50104 ExpBOMLines
{
    ApplicationArea = All;
    Caption = 'ExpBOMLines';
    PageType = List;
    SourceTable = ExpBOMLine;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(LineNo; Rec.LineNo)
                {
                    ToolTip = 'Specifies the value of the LineNo field.';
                }
                field(ItemNo; Rec.ItemNo)
                {
                    ToolTip = 'Specifies the value of the ItemNo field.';
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                }
                field(CompNo; Rec.CompNo)
                {
                    ToolTip = 'Specifies the value of the CompNo field.';
                }
                field(CompVar; Rec.CompVar)
                {
                    ToolTip = 'Specifies the value of the CompVar field.';
                }

                field(CompDesc; Rec.CompDesc)
                {
                    ToolTip = 'Specifies the value of the CompDesc field.';
                }
                field(UoM; Rec.UoM)
                {
                    ToolTip = 'Specifies the value of the UoM field.';
                }
                field(BOMQuantity; Rec.BOMQuantity)
                {
                    ToolTip = 'Specifies the value of the BOMQuantity field.';
                }
                field(TotalQty; Rec.TotalQty)
                {
                    ToolTip = 'Specifies the value of the TotalQty field.';
                }
            }
        }
    }
}
